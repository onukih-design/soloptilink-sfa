#!/usr/bin/env bash
# =============================================================================
# SoloptiLink Chain v10.0 - Browser Integration Testing Module
# =============================================================================
# Actually opens a browser via Playwright/Puppeteer, clicks every button,
# fills every form, navigates every route. Real interaction testing beyond
# static analysis - the ultimate QA tool.
# Usage: source lib/browser-test.sh
# =============================================================================

BT_GREEN='\033[0;32m' BT_YELLOW='\033[0;33m' BT_RED='\033[0;31m'
BT_CYAN='\033[0;36m'  BT_PURPLE='\033[0;35m' BT_BOLD='\033[1m' BT_NC='\033[0m'

BT_AVAILABLE=false; BT_ENGINE=""; BT_APP_PID=""
BT_ROUTES_TESTED=0; BT_BUTTONS_CLICKED=0; BT_FORMS_SUBMITTED=0
BT_ERRORS_FOUND=0; BT_SCREENSHOTS_TAKEN=0; BT_RESULTS=""

# --- Helpers -----------------------------------------------------------------
_bt_log() {
    local level="$1" msg="$2" ts; ts="$(date '+%H:%M:%S')"
    case "$level" in
        PASS) printf "${BT_GREEN}[BT PASS %s]${BT_NC} %s\n" "$ts" "$msg" ;;
        FAIL) printf "${BT_RED}[BT FAIL %s]${BT_NC} %s\n"   "$ts" "$msg" ;;
        WARN) printf "${BT_YELLOW}[BT WARN %s]${BT_NC} %s\n" "$ts" "$msg" ;;
        INFO) printf "${BT_CYAN}[BT INFO %s]${BT_NC} %s\n"   "$ts" "$msg" ;;
        *)    printf "[BT %s] %s\n" "$ts" "$msg" ;;
    esac
    BT_RESULTS+="${level}: ${msg}\n"
}

_bt_wait_for_port() {
    local port="$1" timeout="${2:-30}" i=0
    _bt_log INFO "Waiting for port ${port} (max ${timeout}s)..."
    while (( i < timeout )); do
        if command -v nc &>/dev/null; then
            nc -z localhost "$port" 2>/dev/null && { _bt_log PASS "Port ${port} ready"; return 0; }
        elif curl -s -o /dev/null "http://localhost:${port}" 2>/dev/null; then
            _bt_log PASS "Port ${port} ready"; return 0
        fi
        sleep 1; (( i++ ))
    done
    _bt_log FAIL "Port ${port} not ready after ${timeout}s"; return 1
}

_bt_call_claude() {
    claude -p --dangerously-skip-permissions --output-format text "$1" 2>/dev/null
}

# === 1. btest_init(project_dir) ==============================================
btest_init() {
    local pd="$1"
    [[ -z "$pd" || ! -d "$pd" ]] && { _bt_log FAIL "Invalid project dir: ${pd}"; return 1; }
    BT_AVAILABLE=false; BT_ENGINE=""
    BT_ROUTES_TESTED=0; BT_BUTTONS_CLICKED=0; BT_FORMS_SUBMITTED=0
    BT_ERRORS_FOUND=0; BT_SCREENSHOTS_TAKEN=0; BT_RESULTS=""
    _bt_log INFO "Initialising browser testing for: ${pd}"

    if npx playwright --version &>/dev/null 2>&1; then
        BT_ENGINE="playwright"; BT_AVAILABLE=true
        _bt_log PASS "Playwright detected"; return 0
    elif node -e "require('puppeteer')" &>/dev/null 2>&1; then
        BT_ENGINE="puppeteer"; BT_AVAILABLE=true
        _bt_log PASS "Puppeteer detected"; return 0
    elif command -v npx &>/dev/null; then
        _bt_log WARN "No engine found - Playwright installable via npx"
        BT_ENGINE="playwright-pending"; return 0
    fi
    _bt_log WARN "No browser engine available. Fallback mode only."; return 0
}

# === 2. btest_run_all(project_dir, base_url) - MAIN ==========================
btest_run_all() {
    local pd="$1" url="${2:-http://localhost:3000}" app_started=false
    local port; port="$(echo "$url" | grep -oE '[0-9]+$' || echo 3000)"
    [[ -z "$pd" || ! -d "$pd" ]] && { _bt_log FAIL "Invalid project dir"; return 1; }
    _bt_log INFO "=== Browser Test Suite Starting ==="
    _bt_log INFO "Project: ${pd} | URL: ${url}"

    # No engine? fallback
    if [[ "$BT_AVAILABLE" != "true" && "$BT_ENGINE" != "playwright-pending" ]]; then
        _bt_log WARN "No browser engine - running fallback"
        btest_fallback_check "$pd" "$url"; btest_report; return 0
    fi
    # Setup Playwright if pending
    if [[ "$BT_ENGINE" == "playwright-pending" ]]; then
        btest_setup_playwright "$pd" || {
            btest_fallback_check "$pd" "$url"; btest_report; return 1; }
    fi
    # Ensure app is running
    if ! curl -s -o /dev/null -w '' "http://localhost:${port}" 2>/dev/null; then
        _bt_log INFO "App not running - starting..."
        btest_start_app "$pd" "$port"
        [[ -n "$BT_APP_PID" ]] && app_started=true || {
            btest_fallback_check "$pd" "$url"; btest_report; return 1; }
    else
        _bt_log PASS "App already running at ${url}"
    fi
    # Generate & execute
    btest_generate_tests "$pd" "$url"
    local tf="${pd}/tests/e2e/generated.spec.ts"
    [[ -f "$tf" ]] && btest_execute "$pd" "$tf" || _bt_log WARN "No test file generated"
    btest_capture_errors "$pd" "$url"
    btest_accessibility_check "$pd" "$url"
    [[ "$app_started" == "true" && -n "$BT_APP_PID" ]] && btest_stop_app "$BT_APP_PID"
    btest_report; return 0
}

# === 3. btest_generate_tests(project_dir, base_url) ==========================
btest_generate_tests() {
    local pd="$1" url="$2" td="${1}/tests/e2e" tf="${1}/tests/e2e/generated.spec.ts"
    mkdir -p "$td" "${pd}/tests/e2e/screenshots" 2>/dev/null
    _bt_log INFO "Generating Playwright tests via Claude..."
    # Gather source context
    local src_ctx=""
    src_ctx="$(find "$pd" -type f \( -name '*.tsx' -o -name '*.jsx' -o -name '*.vue' -o -name '*.svelte' -o -name '*.py' -o -name '*.html' \) \
        ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' \
        2>/dev/null | head -30 | while read -r f; do
        echo "--- ${f#"$pd"/} ---"; head -40 "$f" 2>/dev/null
    done | head -600)"

    local gen; gen="$(_bt_call_claude "You are a Playwright E2E test generator. Given these source files, generate a COMPLETE Playwright test (TypeScript).

PROJECT FILES:
${src_ctx}

BASE URL: ${url}

Generate tests that: 1) import {test,expect} from '@playwright/test' 2) Visit every route 3) Click every button 4) Fill/submit every form with test data 5) Check zero console errors 6) Screenshot after actions 7) Verify no 4xx/5xx 8) Test keyboard nav.
Output ONLY valid TypeScript. No markdown fences.")"

    if [[ -n "$gen" && ${#gen} -gt 100 ]]; then
        echo "$gen" | sed '/^```/d' > "$tf"
        _bt_log PASS "Generated: ${tf} ($(wc -l < "$tf") lines)"
    else
        _bt_log WARN "Claude output insufficient - writing minimal test"
        cat > "$tf" << 'MINT'
import { test, expect } from '@playwright/test';
test('homepage loads without errors', async ({ page }) => {
  const errors: string[] = [];
  page.on('console', m => { if (m.type() === 'error') errors.push(m.text()); });
  page.on('pageerror', e => errors.push(e.message));
  const r = await page.goto(process.env.BASE_URL || 'http://localhost:3000');
  expect(r?.status()).toBeLessThan(400);
  await page.screenshot({ path: 'tests/e2e/screenshots/homepage.png', fullPage: true });
  expect(errors).toHaveLength(0);
});
test('all internal links valid', async ({ page }) => {
  await page.goto(process.env.BASE_URL || 'http://localhost:3000');
  const links = await page.locator('a[href]').all();
  for (const link of links) {
    const href = await link.getAttribute('href');
    if (href?.startsWith('/')) {
      const r = await page.goto(`${process.env.BASE_URL || 'http://localhost:3000'}${href}`);
      expect(r?.status()).toBeLessThan(400);
    }
  }
});
MINT
    fi
}

# === 4. btest_setup_playwright(project_dir) ==================================
btest_setup_playwright() {
    local pd="$1"
    _bt_log INFO "Setting up Playwright..."
    (cd "$pd" && npx playwright install --with-deps chromium 2>&1) | \
        while read -r l; do _bt_log INFO "  ${l}"; done
    if ! npx playwright --version &>/dev/null 2>&1; then
        _bt_log FAIL "Playwright installation failed"; return 1
    fi
    BT_ENGINE="playwright"; BT_AVAILABLE=true
    _bt_log PASS "Playwright installed"
    # Create config if missing
    local cfg="${pd}/playwright.config.ts"
    [[ -f "$cfg" ]] && return 0
    cat > "$cfg" << 'PW'
import { defineConfig } from '@playwright/test';
export default defineConfig({
  testDir: './tests/e2e', timeout: 30000, retries: 1,
  use: {
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    screenshot: 'only-on-failure', trace: 'retain-on-failure', headless: true,
  },
  reporter: [['list'], ['html', { open: 'never' }]],
  projects: [{ name: 'chromium', use: { browserName: 'chromium' } }],
});
PW
    _bt_log PASS "Created ${cfg}"; return 0
}

# === 5. btest_execute(project_dir, test_file) ================================
btest_execute() {
    local pd="$1" tf="$2" output ec
    [[ ! -f "$tf" ]] && { _bt_log FAIL "Test file missing: ${tf}"; return 1; }
    _bt_log INFO "Executing: ${tf}"
    output="$(cd "$pd" && npx playwright test "$tf" --reporter=list 2>&1)"; ec=$?
    local passed failed skipped
    passed="$(echo "$output" | grep -cE '✓|passed' || echo 0)"
    failed="$(echo "$output" | grep -cE '✘|failed|✗' || echo 0)"
    skipped="$(echo "$output" | grep -cE 'skipped' || echo 0)"
    BT_ROUTES_TESTED=$(( BT_ROUTES_TESTED + passed + failed ))
    if (( ec == 0 )); then
        _bt_log PASS "All passed (${passed} ok, ${skipped} skipped)"
    else
        _bt_log FAIL "Failures: ${passed} passed, ${failed} failed, ${skipped} skipped"
        BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + failed ))
        local ss; ss="$(find "${pd}/test-results" -name '*.png' 2>/dev/null | wc -l | tr -d ' ')"
        BT_SCREENSHOTS_TAKEN=$(( BT_SCREENSHOTS_TAKEN + ss ))
        [[ "$ss" -gt 0 ]] && _bt_log INFO "Failure screenshots: ${ss}"
    fi
    echo "$output" | tail -15 | while read -r l; do _bt_log INFO "  $l"; done
    return "$ec"
}

# === 6. btest_start_app(project_dir, port) ===================================
btest_start_app() {
    local pd="$1" port="${2:-3000}" cmd=""
    if [[ -f "${pd}/package.json" ]]; then
        grep -q '"dev"'   "${pd}/package.json" 2>/dev/null && cmd="npm run dev"
        grep -q '"start"' "${pd}/package.json" 2>/dev/null && [[ -z "$cmd" ]] && cmd="npm start"
    elif [[ -f "${pd}/manage.py" ]]; then cmd="python manage.py runserver 0.0.0.0:${port}"
    elif [[ -f "${pd}/app.py" ]];    then cmd="python app.py"
    elif [[ -f "${pd}/main.py" ]];   then cmd="python main.py"
    elif [[ -f "${pd}/Cargo.toml" ]]; then cmd="cargo run"
    elif [[ -f "${pd}/main.go" || -f "${pd}/cmd/main.go" ]]; then cmd="go run ."
    fi
    [[ -z "$cmd" ]] && { _bt_log WARN "Cannot detect start command"; BT_APP_PID=""; return 1; }
    _bt_log INFO "Starting: ${cmd}"
    (cd "$pd" && PORT="$port" $cmd &>/dev/null &); BT_APP_PID=$!
    if _bt_wait_for_port "$port" 30; then
        _bt_log PASS "App started (PID:${BT_APP_PID}) on :${port}"; return 0
    else
        _bt_log FAIL "App failed to start"; kill "$BT_APP_PID" 2>/dev/null; BT_APP_PID=""; return 1
    fi
}

# === 7. btest_stop_app(pid) ==================================================
btest_stop_app() {
    local pid="$1"; [[ -z "$pid" ]] && return 0
    _bt_log INFO "Stopping app (PID:${pid})..."
    if kill -0 "$pid" 2>/dev/null; then
        kill "$pid" 2>/dev/null; sleep 2
        kill -0 "$pid" 2>/dev/null && { kill -9 "$pid" 2>/dev/null; _bt_log WARN "Force-killed ${pid}"; } \
            || _bt_log PASS "App stopped gracefully"
    else _bt_log INFO "PID ${pid} already exited"; fi
    BT_APP_PID=""
}

# === 8. btest_capture_errors(project_dir, base_url) ==========================
btest_capture_errors() {
    local pd="$1" url="$2" sf="${1}/tests/e2e/_err_check.mjs"
    [[ "$BT_AVAILABLE" != "true" ]] && return 0
    _bt_log INFO "Capturing console/network errors across routes..."
    cat > "$sf" << 'ES'
import { chromium } from '@playwright/test';
const base = process.argv[2] || 'http://localhost:3000';
(async () => {
  const br = await chromium.launch({ headless: true });
  const pg = await br.newPage();
  const errs = [], netErrs = [];
  pg.on('console', m => { if (m.type()==='error') errs.push({url:pg.url(),e:m.text()}); });
  pg.on('pageerror', e => errs.push({url:pg.url(),e:e.message}));
  pg.on('response', r => { if (r.status()>=400) netErrs.push({url:r.url(),s:r.status()}); });
  await pg.goto(base, { waitUntil:'networkidle' });
  const hrefs = await pg.$$eval('a[href]', as => as.map(a => a.href));
  const routes = [...new Set(hrefs.filter(h => h.startsWith(base)))].slice(0, 30);
  for (const r of routes) {
    try { await pg.goto(r, { waitUntil:'networkidle', timeout:15000 }); }
    catch(e) { errs.push({url:r,e:e.message}); }
  }
  await br.close();
  console.log(JSON.stringify({ce:errs.length,ne:netErrs.length,rt:routes.length+1}));
})();
ES
    local res; res="$(cd "$pd" && node "$sf" "$url" 2>/dev/null)"; rm -f "$sf"
    if [[ -n "$res" ]]; then
        local ce ne rt
        ce="$(echo "$res" | node -e "process.stdout.write(''+JSON.parse(require('fs').readFileSync(0,'utf8')).ce)" 2>/dev/null || echo 0)"
        ne="$(echo "$res" | node -e "process.stdout.write(''+JSON.parse(require('fs').readFileSync(0,'utf8')).ne)" 2>/dev/null || echo 0)"
        rt="$(echo "$res" | node -e "process.stdout.write(''+JSON.parse(require('fs').readFileSync(0,'utf8')).rt)" 2>/dev/null || echo 0)"
        BT_ROUTES_TESTED=$(( BT_ROUTES_TESTED + rt ))
        BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + ce + ne ))
        [[ "$ce" -gt 0 ]] && _bt_log FAIL "Console errors: ${ce}"
        [[ "$ne" -gt 0 ]] && _bt_log FAIL "Network errors (4xx/5xx): ${ne}"
        [[ "$ce" -eq 0 && "$ne" -eq 0 ]] && _bt_log PASS "Zero console/network errors"
    else _bt_log WARN "Error capture returned no output"; fi
}

# === 9. btest_accessibility_check(project_dir, base_url) =====================
btest_accessibility_check() {
    local pd="$1" url="$2" sf="${1}/tests/e2e/_a11y.mjs"
    [[ "$BT_AVAILABLE" != "true" ]] && return 0
    _bt_log INFO "Running accessibility checks (axe-core)..."
    cat > "$sf" << 'AX'
import { chromium } from '@playwright/test';
const base = process.argv[2] || 'http://localhost:3000';
(async () => {
  const br = await chromium.launch({ headless: true });
  const pg = await br.newPage();
  await pg.goto(base, { waitUntil:'networkidle' });
  await pg.addScriptTag({ url:'https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.8.2/axe.min.js' });
  const res = await pg.evaluate(() => window.axe.run());
  const v = res.violations.map(x => ({id:x.id,impact:x.impact,desc:x.description,n:x.nodes.length}));
  await br.close();
  console.log(JSON.stringify({total:v.length,critical:v.filter(x=>x.impact==='critical').length}));
})();
AX
    local res; res="$(cd "$pd" && node "$sf" "$url" 2>/dev/null)"; rm -f "$sf"
    if [[ -n "$res" ]]; then
        local total crit
        total="$(echo "$res" | node -e "process.stdout.write(''+JSON.parse(require('fs').readFileSync(0,'utf8')).total)" 2>/dev/null || echo 0)"
        crit="$(echo "$res" | node -e "process.stdout.write(''+JSON.parse(require('fs').readFileSync(0,'utf8')).critical)" 2>/dev/null || echo 0)"
        if [[ "$total" -eq 0 ]]; then _bt_log PASS "Accessibility: zero violations"
        elif [[ "$crit" -gt 0 ]]; then
            _bt_log FAIL "Accessibility: ${total} violations (${crit} critical)"
            BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + crit ))
        else _bt_log WARN "Accessibility: ${total} violations (0 critical)"; fi
    else _bt_log WARN "Accessibility check returned no output"; fi
}

# === 10. btest_report() ======================================================
btest_report() {
    echo ""
    printf "${BT_BOLD}${BT_PURPLE}+------------------------------------------------+${BT_NC}\n"
    printf "${BT_BOLD}${BT_PURPLE}|     Browser Test Report - SoloptiLink v10      |${BT_NC}\n"
    printf "${BT_BOLD}${BT_PURPLE}+------------------------------------------------+${BT_NC}\n"
    printf "  ${BT_CYAN}Engine:${BT_NC}          %s\n"  "${BT_ENGINE:-none}"
    printf "  ${BT_CYAN}Routes tested:${BT_NC}   %d\n"  "$BT_ROUTES_TESTED"
    printf "  ${BT_CYAN}Buttons clicked:${BT_NC} %d\n"  "$BT_BUTTONS_CLICKED"
    printf "  ${BT_CYAN}Forms submitted:${BT_NC} %d\n"  "$BT_FORMS_SUBMITTED"
    printf "  ${BT_CYAN}Screenshots:${BT_NC}     %d\n"  "$BT_SCREENSHOTS_TAKEN"
    if (( BT_ERRORS_FOUND == 0 )); then
        printf "\n  ${BT_GREEN}${BT_BOLD}Result: ALL CLEAR - No errors detected${BT_NC}\n"
    else
        printf "\n  ${BT_RED}${BT_BOLD}Result: %d ERROR(S) FOUND${BT_NC}\n" "$BT_ERRORS_FOUND"
    fi
    printf "${BT_PURPLE}+------------------------------------------------+${BT_NC}\n\n"
}

# === 11. btest_fallback_check(project_dir, base_url) =========================
btest_fallback_check() {
    local pd="$1" url="${2:-}"
    _bt_log INFO "=== Fallback Mode (no browser engine) ==="

    # HTTP checks via curl
    if [[ -n "$url" ]] && command -v curl &>/dev/null; then
        _bt_log INFO "Checking HTTP status of routes..."
        local st; st="$(curl -s -o /dev/null -w '%{http_code}' "$url" 2>/dev/null || echo 000)"
        if [[ "$st" -ge 200 && "$st" -lt 400 ]]; then
            _bt_log PASS "Homepage: HTTP ${st}"; BT_ROUTES_TESTED=$(( BT_ROUTES_TESTED + 1 ))
        elif [[ "$st" != "000" ]]; then
            _bt_log FAIL "Homepage: HTTP ${st}"; BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + 1 ))
        else _bt_log WARN "Homepage unreachable"; fi

        # Discover routes from source
        local routes; routes="$(grep -rhoE "(href|to|path|route)=['\"]\/[a-zA-Z0-9/_-]*['\"]" "$pd" \
            --include='*.tsx' --include='*.jsx' --include='*.vue' --include='*.html' \
            2>/dev/null | grep -oE '/[a-zA-Z0-9/_-]+' | sort -u | head -20)"
        while IFS= read -r r; do
            [[ -z "$r" ]] && continue
            st="$(curl -s -o /dev/null -w '%{http_code}' "${url}${r}" 2>/dev/null || echo 000)"
            [[ "$st" -ge 200 && "$st" -lt 400 ]] && _bt_log PASS "Route ${r}: HTTP ${st}" \
                || { [[ "$st" != "000" ]] && _bt_log FAIL "Route ${r}: HTTP ${st}" && BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + 1 )); }
            BT_ROUTES_TESTED=$(( BT_ROUTES_TESTED + 1 ))
        done <<< "$routes"
    fi

    # Static analysis: broken references in HTML
    _bt_log INFO "Checking HTML for broken static references..."
    local broken=0 html_files
    html_files="$(find "$pd" -type f -name '*.html' ! -path '*/node_modules/*' \
        ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' 2>/dev/null | head -20)"
    while IFS= read -r hf; do
        [[ -z "$hf" ]] && continue
        local dir; dir="$(dirname "$hf")"
        # Check JS refs
        grep -oE 'src="[^"]*\.js"' "$hf" 2>/dev/null | tr -d '"' | sed 's/src=//' | while read -r ref; do
            [[ -z "$ref" || "$ref" == http* ]] && continue
            [[ ! -f "${dir}/${ref}" && ! -f "${pd}/${ref}" ]] && {
                _bt_log FAIL "Broken JS: $(basename "$hf") -> ${ref}"; (( broken++ )); }
        done
        # Check CSS refs
        grep -oE 'href="[^"]*\.css"' "$hf" 2>/dev/null | tr -d '"' | sed 's/href=//' | while read -r ref; do
            [[ -z "$ref" || "$ref" == http* ]] && continue
            [[ ! -f "${dir}/${ref}" && ! -f "${pd}/${ref}" ]] && {
                _bt_log FAIL "Broken CSS: $(basename "$hf") -> ${ref}"; (( broken++ )); }
        done
    done <<< "$html_files"
    BT_ERRORS_FOUND=$(( BT_ERRORS_FOUND + broken ))
    [[ "$broken" -eq 0 ]] && _bt_log PASS "No broken static references"
    _bt_log INFO "Fallback check complete"
}
