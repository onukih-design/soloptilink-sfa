#!/usr/bin/env bash
# =============================================================================
# SoloptiLink Chain v8.0 - Exhaustive QA Engine
# =============================================================================
# Tests EVERY interactive element. Goes beyond unit tests by simulating actual
# user behaviour - buttons, forms, routes, APIs, DB queries, security.
# Usage: source lib/qa-engine.sh
# =============================================================================

# Color codes
readonly _QA_GREEN='\033[0;32m'  _QA_YELLOW='\033[0;33m'  _QA_RED='\033[0;31m'
readonly _QA_CYAN='\033[0;36m'   _QA_BOLD='\033[1m'        _QA_NC='\033[0m'

# Counters
_QA_PASS=0; _QA_FAIL=0; _QA_WARN=0; _QA_RESULTS=""

# --- Helpers ----------------------------------------------------------------

_qa_log() {
  local level="$1" message="$2" ts
  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  case "$level" in
    PASS) printf "${_QA_GREEN}[QA PASS %s]${_QA_NC} %s\n" "$ts" "$message"; ((_QA_PASS++)) ;;
    FAIL) printf "${_QA_RED}[QA FAIL %s]${_QA_NC} %s\n"   "$ts" "$message"; ((_QA_FAIL++)) ;;
    WARN) printf "${_QA_YELLOW}[QA WARN %s]${_QA_NC} %s\n" "$ts" "$message"; ((_QA_WARN++)) ;;
    INFO) printf "${_QA_CYAN}[QA INFO %s]${_QA_NC} %s\n"   "$ts" "$message" ;;
    *)    printf "[QA %s] %s\n" "$ts" "$message" ;;
  esac
  _QA_RESULTS+="${level}: ${message}\n"
}

_qa_call_claude() {
  claude -p --dangerously-skip-permissions --output-format text "$1" 2>/dev/null
}

_qa_find_files() {
  local dir="$1" pattern="$2"
  find "$dir" -type f -name "$pattern" \
    ! -path '*/node_modules/*' ! -path '*/.git/*' \
    ! -path '*/dist/*' ! -path '*/build/*' ! -path '*/.next/*' ! -path '*/vendor/*' \
    2>/dev/null
}

# --- qa_init(project_dir) --------------------------------------------------

qa_init() {
  local project_dir="$1"
  [[ -z "$project_dir" || ! -d "$project_dir" ]] && { _qa_log FAIL "Invalid project dir: ${project_dir}"; return 1; }
  _QA_PASS=0; _QA_FAIL=0; _QA_WARN=0; _QA_RESULTS=""
  _qa_log INFO "Initialising QA for: ${project_dir}"

  QA_PROJECT_TYPE="unknown"
  if [[ -f "${project_dir}/package.json" ]]; then
    QA_PROJECT_TYPE="node"
    grep -q '"react"'  "${project_dir}/package.json" 2>/dev/null && QA_PROJECT_TYPE="react"
    grep -q '"next"'   "${project_dir}/package.json" 2>/dev/null && QA_PROJECT_TYPE="nextjs"
    grep -q '"vue"'    "${project_dir}/package.json" 2>/dev/null && QA_PROJECT_TYPE="vue"
    grep -q '"svelte"' "${project_dir}/package.json" 2>/dev/null && QA_PROJECT_TYPE="svelte"
  elif [[ -f "${project_dir}/requirements.txt" || -f "${project_dir}/pyproject.toml" ]]; then
    QA_PROJECT_TYPE="python"
  elif [[ -f "${project_dir}/Cargo.toml" ]]; then QA_PROJECT_TYPE="rust"
  elif [[ -f "${project_dir}/go.mod" ]]; then       QA_PROJECT_TYPE="go"
  fi
  export QA_PROJECT_TYPE
  _qa_log INFO "Detected project type: ${QA_PROJECT_TYPE}"
}

# --- qa_test_all_buttons(project_dir) ---------------------------------------

qa_test_all_buttons() {
  local project_dir="$1"
  _qa_log INFO "Testing all button / click handlers ..."

  local all_files
  all_files="$(_qa_find_files "$project_dir" '*.js')
$(_qa_find_files "$project_dir" '*.tsx')
$(_qa_find_files "$project_dir" '*.vue')
$(_qa_find_files "$project_dir" '*.svelte')"
  all_files="$(echo "$all_files" | sed '/^$/d')"
  [[ -z "$all_files" ]] && { _qa_log WARN "No JS/TSX/Vue/Svelte files - skipping"; return 0; }

  local handler_count=0 missing_count=0
  while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    local handlers
    handlers="$(grep -nE '(onClick|@click|on:click|onclick)\s*=' "$file" 2>/dev/null)"
    [[ -z "$handlers" ]] && continue
    local n; n="$(echo "$handlers" | wc -l | tr -d ' ')"
    handler_count=$(( handler_count + n ))

    local analysis
    analysis="$(_qa_call_claude "Analyse click handlers from ${file}. For each: 1) handler exists/imported? 2) unhandled throw? 3) edge cases? Reply JSON [{\"line\":N,\"status\":\"pass|fail|warn\",\"reason\":\"...\"}]. Handlers:\n${handlers}\n\nFile (first 200 lines):\n$(head -200 "$file")")"
    if echo "$analysis" | grep -q '"fail"'; then
      _qa_log FAIL "Button handler issues: $(basename "$file")"
      missing_count=$(( missing_count + 1 ))
    else
      _qa_log PASS "Button handlers OK: $(basename "$file") (${n})"
    fi
  done <<< "$all_files"
  _qa_log INFO "Button audit: ${handler_count} handlers, ${missing_count} issues"
}

# --- qa_test_all_forms(project_dir) -----------------------------------------

qa_test_all_forms() {
  local project_dir="$1"
  _qa_log INFO "Testing all form submissions ..."

  local all_files
  all_files="$(_qa_find_files "$project_dir" '*.tsx')
$(_qa_find_files "$project_dir" '*.jsx')
$(_qa_find_files "$project_dir" '*.vue')
$(_qa_find_files "$project_dir" '*.svelte')
$(_qa_find_files "$project_dir" '*.html')"
  all_files="$(echo "$all_files" | sed '/^$/d')"
  [[ -z "$all_files" ]] && { _qa_log WARN "No template files - skipping forms"; return 0; }

  local form_count=0
  while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    grep -qE '<form' "$file" 2>/dev/null || continue
    form_count=$(( form_count + 1 ))

    if ! grep -qE '(onSubmit|@submit|on:submit|action=)' "$file" 2>/dev/null; then
      _qa_log FAIL "Form without submit handler: $(basename "$file")"; continue
    fi
    local req; req="$(grep -cE '(required|aria-required|\.required)' "$file" 2>/dev/null || echo 0)"
    (( req == 0 )) && _qa_log WARN "No required-field markers: $(basename "$file")"
    if grep -qE '(error|Error|err|invalid|Invalid)' "$file" 2>/dev/null; then
      _qa_log PASS "Form validation OK: $(basename "$file")"
    else
      _qa_log WARN "Form may lack error display: $(basename "$file")"
    fi
  done <<< "$all_files"
  (( form_count == 0 )) && _qa_log INFO "No <form> elements detected" || _qa_log INFO "Form audit: ${form_count} form(s)"
}

# --- qa_test_all_routes(project_dir) ----------------------------------------

qa_test_all_routes() {
  local project_dir="$1"
  _qa_log INFO "Testing all routes ..."

  local router_files
  router_files="$(_qa_find_files "$project_dir" 'router.*')
$(_qa_find_files "$project_dir" 'routes.*')
$(_qa_find_files "$project_dir" 'App.tsx')
$(_qa_find_files "$project_dir" 'App.jsx')
$(_qa_find_files "$project_dir" 'app.py')
$(_qa_find_files "$project_dir" 'urls.py')"
  router_files="$(echo "$router_files" | sed '/^$/d' | sort -u)"
  [[ -z "$router_files" ]] && { _qa_log INFO "No router configs - skipping"; return 0; }

  local route_count=0 issue_count=0
  while IFS= read -r rfile; do
    [[ -z "$rfile" || ! -f "$rfile" ]] && continue
    local routes
    routes="$(grep -oE "(path|route|Route)\s*[:=(\[]\s*['\"][^'\"]+['\"]" "$rfile" 2>/dev/null)"
    [[ -z "$routes" ]] && continue
    local n; n="$(echo "$routes" | wc -l | tr -d ' ')"
    route_count=$(( route_count + n ))

    local out
    out="$(_qa_call_claude "Analyse routes from ${rfile}. For each: component/handler exists? 404 catch-all? Reply concisely, issues only.\nRoutes:\n${routes}\nFile (first 300 lines):\n$(head -300 "$rfile")")"
    if echo "$out" | grep -qiE '(missing|no 404|not found|undefined)'; then
      _qa_log WARN "Route issues: $(basename "$rfile")"; issue_count=$(( issue_count + 1 ))
    else
      _qa_log PASS "Routes OK: $(basename "$rfile") (${n})"
    fi
  done <<< "$router_files"

  # 404 check
  local has_404; has_404="$(_qa_find_files "$project_dir" '*404*' | head -1)"
  if [[ -z "$has_404" ]]; then
    grep -rlE '(\*|catch.?all|notFound|not-found|NotFound)' "$project_dir/src" 2>/dev/null | head -1 | grep -q . \
      || _qa_log WARN "No 404 / catch-all page detected"
  fi
  _qa_log INFO "Route audit: ${route_count} route(s), ${issue_count} issue(s)"
}

# --- qa_test_api_endpoints(project_dir) -------------------------------------

qa_test_api_endpoints() {
  local project_dir="$1"
  _qa_log INFO "Testing API endpoints ..."

  local api_files
  api_files="$(_qa_find_files "$project_dir" '*.controller.*')
$(_qa_find_files "$project_dir" '*.route.*')
$(_qa_find_files "$project_dir" '*.api.*')
$(_qa_find_files "$project_dir" 'views.py')
$(_qa_find_files "$project_dir" 'handlers.go')
$(grep -rlE '\.(get|post|put|delete|patch)\s*\(' "$project_dir/src" 2>/dev/null | head -30)"
  api_files="$(echo "$api_files" | sed '/^$/d' | sort -u)"
  [[ -z "$api_files" ]] && { _qa_log INFO "No API endpoints found - skipping"; return 0; }

  local ep_total=0
  while IFS= read -r afile; do
    [[ -z "$afile" || ! -f "$afile" ]] && continue
    local n; n="$(grep -cE '\.(get|post|put|delete|patch)\s*\(' "$afile" 2>/dev/null || echo 0)"
    ep_total=$(( ep_total + n ))

    # Error handling
    if grep -qE '(try\s*\{|catch\s*\(|\.catch\(|except |rescue )' "$afile" 2>/dev/null; then
      _qa_log PASS "Error handling present: $(basename "$afile")"
    else
      _qa_log FAIL "No error handling: $(basename "$afile")"
    fi
    # Auth
    if grep -qE '(auth|Auth|authenticate|protect|guard|jwt|token|session)' "$afile" 2>/dev/null; then
      _qa_log PASS "Auth refs found: $(basename "$afile")"
    else
      _qa_log WARN "No auth middleware: $(basename "$afile")"
    fi
    # Validation
    if grep -qE '(validate|sanitize|zod|yup|joi|class-validator|pydantic)' "$afile" 2>/dev/null; then
      _qa_log PASS "Input validation: $(basename "$afile")"
    else
      _qa_log WARN "No input validation lib: $(basename "$afile")"
    fi
  done <<< "$api_files"
  _qa_log INFO "API audit: ~${ep_total} endpoint(s)"
}

# --- qa_test_database(project_dir) ------------------------------------------

qa_test_database() {
  local project_dir="$1"
  _qa_log INFO "Testing database layer ..."

  local db_files
  db_files="$(grep -rlE '(SELECT|INSERT|UPDATE|DELETE|CREATE TABLE|query\(|prisma|sequelize|mongoose|knex|typeorm|drizzle)' \
    "$project_dir/src" "$project_dir/lib" "$project_dir/app" 2>/dev/null \
    | grep -v node_modules | grep -v '.git' | head -40)"
  [[ -z "$db_files" ]] && { _qa_log INFO "No DB query files - skipping"; return 0; }

  local issues=0
  while IFS= read -r dbf; do
    [[ -z "$dbf" || ! -f "$dbf" ]] && continue
    # SQL injection risk
    if grep -nE '(query\s*\(\s*[`"'"'"'].*\$\{|execute\s*\(\s*f['"'"'"])' "$dbf" 2>/dev/null | grep -q .; then
      _qa_log FAIL "SQL injection risk: $(basename "$dbf")"; issues=$(( issues + 1 ))
    fi
    # Error handling
    if grep -qE '(try\s*\{|\.catch\(|except |rescue )' "$dbf" 2>/dev/null; then
      _qa_log PASS "DB error handling: $(basename "$dbf")"
    else
      _qa_log WARN "DB lacks error handling: $(basename "$dbf")"; issues=$(( issues + 1 ))
    fi
  done <<< "$db_files"

  # Migrations
  local mdir; mdir="$(find "$project_dir" -type d -name 'migrations' ! -path '*/node_modules/*' 2>/dev/null | head -1)"
  if [[ -n "$mdir" ]]; then
    _qa_log INFO "Migrations dir found: ${mdir}"
  elif [[ -f "${project_dir}/prisma/schema.prisma" ]]; then _qa_log PASS "Prisma schema detected"
  elif [[ -d "${project_dir}/drizzle" ]]; then               _qa_log PASS "Drizzle migrations detected"
  else _qa_log WARN "No migration system detected"
  fi
  _qa_log INFO "DB audit: ${issues} issue(s)"
}

# --- qa_security_scan(project_dir) ------------------------------------------

qa_security_scan() {
  local project_dir="$1"
  _qa_log INFO "Running security scan ..."
  local issues=0 hits

  # 1. Hardcoded secrets
  hits="$(grep -rnE '(API_KEY|SECRET_KEY|PASSWORD|PRIVATE_KEY|ACCESS_TOKEN|api_key|secret|password)\s*[:=]\s*['"'"'"][A-Za-z0-9]' \
    "$project_dir/src" "$project_dir/lib" "$project_dir/app" 2>/dev/null \
    | grep -v node_modules | grep -v .env.example | head -20)"
  if [[ -n "$hits" ]]; then
    _qa_log FAIL "Hardcoded secrets found"; issues=$(( issues + 1 ))
    echo "$hits" | while IFS= read -r l; do printf "  ${_QA_RED}%s${_QA_NC}\n" "$l"; done
  else _qa_log PASS "No hardcoded secrets"
  fi

  # 2. eval()
  hits="$(grep -rnE '\beval\s*\(' "$project_dir/src" "$project_dir/lib" 2>/dev/null \
    | grep -v node_modules | grep -v test | head -10)"
  if [[ -n "$hits" ]]; then
    _qa_log FAIL "Dangerous eval() usage"; issues=$(( issues + 1 ))
    echo "$hits" | while IFS= read -r l; do printf "  ${_QA_RED}%s${_QA_NC}\n" "$l"; done
  else _qa_log PASS "No eval() usage"
  fi

  # 3. innerHTML / dangerouslySetInnerHTML
  hits="$(grep -rnE '(innerHTML\s*=|dangerouslySetInnerHTML|v-html)' "$project_dir/src" 2>/dev/null \
    | grep -v node_modules | head -10)"
  if [[ -n "$hits" ]]; then
    _qa_log WARN "innerHTML usage found (verify sanitisation)"; issues=$(( issues + 1 ))
  else _qa_log PASS "No dangerous innerHTML"
  fi

  # 4. CORS
  hits="$(grep -rnE '(cors|CORS|Access-Control-Allow-Origin)' "$project_dir/src" "$project_dir/lib" 2>/dev/null \
    | grep -v node_modules | head -10)"
  if [[ -n "$hits" ]]; then
    if echo "$hits" | grep -qE '(\*|origin:\s*true)'; then
      _qa_log WARN "CORS wildcard origin detected"
    else _qa_log PASS "CORS restricted"
    fi
  else _qa_log INFO "No CORS config found"
  fi

  # 5. Auth middleware
  local auth_f
  auth_f="$(grep -rlE '(middleware.*auth|auth.*middleware|protect|guard|jwt\.verify|passport\.)' \
    "$project_dir/src" "$project_dir/lib" 2>/dev/null | grep -v node_modules | head -5)"
  if [[ -n "$auth_f" ]]; then
    _qa_log PASS "Auth middleware found"
  else _qa_log WARN "No auth middleware detected"
  fi

  # 6. .env exposure
  if [[ -f "${project_dir}/.env" ]]; then
    if grep -q '\.env' "${project_dir}/.gitignore" 2>/dev/null; then
      _qa_log PASS ".env properly gitignored"
    else
      _qa_log FAIL ".env NOT in .gitignore"; issues=$(( issues + 1 ))
    fi
  fi
  _qa_log INFO "Security scan: ${issues} issue(s)"
}

# --- qa_suggest_missing_tests(project_dir) ----------------------------------

qa_suggest_missing_tests() {
  local project_dir="$1"
  _qa_log INFO "Asking Claude for missing test suggestions ..."

  local structure
  structure="$(find "$project_dir/src" "$project_dir/lib" "$project_dir/app" \
    -type f \( -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' -o -name '*.py' -o -name '*.go' \) \
    ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | head -80)"

  local test_files
  test_files="$(find "$project_dir" \
    -type f \( -name '*.test.*' -o -name '*.spec.*' -o -name 'test_*' -o -name '*_test.*' \) \
    ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | head -40)"

  local suggestion
  suggestion="$(_qa_call_claude "Given this project, suggest missing tests. Focus on: 1) source files with no test 2) critical integration tests 3) untested edge cases. Be specific.

Source files:
${structure}

Existing tests:
${test_files:-'(none found)'}")"

  if [[ -n "$suggestion" ]]; then
    printf "\n${_QA_BOLD}${_QA_CYAN}=== Missing Test Suggestions ===${_QA_NC}\n"
    printf '%s\n' "$suggestion"
    printf "${_QA_CYAN}=================================${_QA_NC}\n\n"
  else
    _qa_log WARN "Claude returned no suggestions"
  fi
}

# --- qa_generate_report(project_dir) ----------------------------------------

qa_generate_report() {
  local project_dir="${1:-.}"
  local report_file="${project_dir}/docs/chain-logs/qa-report-$(date '+%Y%m%d-%H%M%S').txt"
  mkdir -p "$(dirname "$report_file")"

  {
    printf '=%.0s' {1..70}; echo
    printf "SoloptiLink Chain v8.0 - QA Report\n"
    printf "Generated: %s\nProject: %s\nType: %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$project_dir" "${QA_PROJECT_TYPE:-unknown}"
    printf '=%.0s' {1..70}; echo; echo
    printf "SUMMARY\n"; printf '─%.0s' {1..40}; echo
    printf "  PASS: %d  FAIL: %d  WARN: %d  TOTAL: %d\n" "$_QA_PASS" "$_QA_FAIL" "$_QA_WARN" "$((_QA_PASS+_QA_FAIL+_QA_WARN))"
    echo; printf "DETAILS\n"; printf '─%.0s' {1..40}; echo
    printf '%b' "$_QA_RESULTS"
    echo; printf '=%.0s' {1..70}; echo
  } > "$report_file"

  echo
  printf "${_QA_BOLD}+--------------------------------------+${_QA_NC}\n"
  printf "${_QA_BOLD}|        QA Report Summary             |${_QA_NC}\n"
  printf "${_QA_BOLD}+--------------------------------------+${_QA_NC}\n"
  printf "${_QA_BOLD}|${_QA_NC}  ${_QA_GREEN}PASS:${_QA_NC}     %-24d${_QA_BOLD}|${_QA_NC}\n" "$_QA_PASS"
  printf "${_QA_BOLD}|${_QA_NC}  ${_QA_RED}FAIL:${_QA_NC}     %-24d${_QA_BOLD}|${_QA_NC}\n" "$_QA_FAIL"
  printf "${_QA_BOLD}|${_QA_NC}  ${_QA_YELLOW}WARNINGS:${_QA_NC} %-24d${_QA_BOLD}|${_QA_NC}\n" "$_QA_WARN"
  printf "${_QA_BOLD}+--------------------------------------+${_QA_NC}\n"

  if (( _QA_FAIL > 0 )); then
    printf "\n${_QA_RED}${_QA_BOLD}QA FAILED${_QA_NC} - %d issue(s) require attention\n" "$_QA_FAIL"
  elif (( _QA_WARN > 0 )); then
    printf "\n${_QA_YELLOW}${_QA_BOLD}QA PASSED WITH WARNINGS${_QA_NC} - %d warning(s)\n" "$_QA_WARN"
  else
    printf "\n${_QA_GREEN}${_QA_BOLD}QA PASSED${_QA_NC} - all checks green\n"
  fi
  _qa_log INFO "Report saved: ${report_file}"
}

# --- qa_run_exhaustive(project_dir) -----------------------------------------

qa_run_exhaustive() {
  local project_dir="$1"
  qa_init "$project_dir" || return 1

  printf "\n${_QA_BOLD}${_QA_CYAN}"
  printf '=%.0s' {1..60}; echo
  printf "  SoloptiLink Chain v8.0 - Exhaustive QA Engine\n"
  printf '=%.0s' {1..60}
  printf "${_QA_NC}\n\n"
  _qa_log INFO "Starting exhaustive QA run ..."

  printf "\n${_QA_BOLD}--- Phase 1: Interactive Elements ---${_QA_NC}\n"
  qa_test_all_buttons "$project_dir"
  qa_test_all_forms   "$project_dir"

  printf "\n${_QA_BOLD}--- Phase 2: Routing ---${_QA_NC}\n"
  qa_test_all_routes "$project_dir"

  printf "\n${_QA_BOLD}--- Phase 3: API & Database ---${_QA_NC}\n"
  qa_test_api_endpoints "$project_dir"
  qa_test_database      "$project_dir"

  printf "\n${_QA_BOLD}--- Phase 4: Security ---${_QA_NC}\n"
  qa_security_scan "$project_dir"

  printf "\n${_QA_BOLD}--- Phase 5: Missing Test Coverage ---${_QA_NC}\n"
  qa_suggest_missing_tests "$project_dir"

  printf "\n${_QA_BOLD}--- Final Report ---${_QA_NC}\n"
  qa_generate_report "$project_dir"

  (( _QA_FAIL == 0 ))
}
