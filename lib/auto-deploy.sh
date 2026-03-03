#!/usr/bin/env bash
# SoloptiLink Chain v10.0 - Auto-Deployment Module
# After validation passes, auto-deploy to Vercel, Railway, or serve locally.
# Detects project type, available tooling, selects the best deployment strategy.
# Sourced by the main orchestrator -- do NOT use set -euo pipefail.

# 1. deploy_init(project_dir) -- colours, state, detect targets
deploy_init() {
    local project_dir="${1:?deploy_init: project_dir required}"
    DP_GREEN="\033[0;32m"; DP_RED="\033[0;31m"; DP_YELLOW="\033[1;33m"
    DP_CYAN="\033[0;36m";  DP_BLUE="\033[0;34m"; DP_MAGENTA="\033[0;35m"
    DP_BOLD="\033[1m";     DP_RESET="\033[0m"
    declare -g DP_PROJECT_DIR="$project_dir" DP_PROJECT_TYPE="" DP_DEPLOY_URL=""
    declare -g DP_DEPLOY_METHOD="" DP_LOCAL_PID=""
    declare -g -a DP_AVAILABLE_TARGETS=()
    deploy_detect_targets "$project_dir"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Initialised  dir=${DP_BOLD}${project_dir}${DP_RESET}"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Available targets: ${DP_AVAILABLE_TARGETS[*]:-none}"
}

# 2. deploy_auto(project_dir) -- MAIN: detect, select strategy, deploy, health-check
deploy_auto() {
    local project_dir="${1:-$DP_PROJECT_DIR}"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} ${DP_BOLD}Auto-deploy starting${DP_RESET} for ${project_dir}"
    _deploy_detect_project_type "$project_dir"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Project type: ${DP_BOLD}${DP_PROJECT_TYPE}${DP_RESET}"
    deploy_detect_targets "$project_dir"
    local deploy_rc=1
    case "$DP_PROJECT_TYPE" in
        nextjs|react|vue|nuxt)
            if _dp_has_target "vercel"; then
                echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Strategy: Vercel"
                _deploy_vercel "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="vercel"
            elif _dp_has_target "netlify"; then
                _deploy_netlify "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="netlify"
            elif _dp_has_target "railway"; then
                _deploy_railway "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="railway"
            else
                echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} No cloud CLI. Falling back to local."
                _deploy_local_serve "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="local"
            fi ;;
        static)
            if _dp_has_target "gh-pages"; then
                _deploy_gh_pages "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="gh-pages"
            else
                _deploy_local_serve "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="local"
            fi ;;
        python|flask|django|fastapi)
            if _dp_has_target "railway"; then
                _deploy_railway "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="railway"
            else
                _deploy_local_serve "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="local"
            fi ;;
        *)
            echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} Unknown type. Local serve."
            _deploy_local_serve "$project_dir"; deploy_rc=$?; DP_DEPLOY_METHOD="local" ;;
    esac
    # Health check
    if [[ $deploy_rc -eq 0 && -n "$DP_DEPLOY_URL" ]]; then
        echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Running health check..."
        if deploy_health_check "$DP_DEPLOY_URL" 5; then
            echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Health check passed!"
        else
            echo -e "${DP_RED}[DEPLOY]${DP_RESET} Health check failed. May need manual verification."
            deploy_report "$DP_DEPLOY_URL" "$DP_PROJECT_TYPE"; return 1
        fi
        deploy_report "$DP_DEPLOY_URL" "$DP_PROJECT_TYPE"
    fi
    return "$deploy_rc"
}

# Internal: detect project type from files
_deploy_detect_project_type() {
    local dir="$1"
    if [[ -f "${dir}/next.config.js" || -f "${dir}/next.config.mjs" || -f "${dir}/next.config.ts" ]]; then
        DP_PROJECT_TYPE="nextjs"
    elif [[ -f "${dir}/nuxt.config.js" || -f "${dir}/nuxt.config.ts" ]]; then
        DP_PROJECT_TYPE="nuxt"
    elif [[ -f "${dir}/vue.config.js" || -f "${dir}/vite.config.ts" ]]; then
        DP_PROJECT_TYPE="vue"
    elif [[ -f "${dir}/package.json" ]] && grep -q '"react"' "${dir}/package.json" 2>/dev/null; then
        DP_PROJECT_TYPE="react"
    elif [[ -f "${dir}/requirements.txt" || -f "${dir}/pyproject.toml" || -f "${dir}/setup.py" ]]; then
        if grep -q 'flask' "${dir}/requirements.txt" 2>/dev/null; then DP_PROJECT_TYPE="flask"
        elif grep -q 'django' "${dir}/requirements.txt" 2>/dev/null; then DP_PROJECT_TYPE="django"
        elif grep -q 'fastapi' "${dir}/requirements.txt" 2>/dev/null; then DP_PROJECT_TYPE="fastapi"
        else DP_PROJECT_TYPE="python"; fi
    elif [[ -f "${dir}/index.html" ]]; then DP_PROJECT_TYPE="static"
    elif [[ -f "${dir}/package.json" ]]; then DP_PROJECT_TYPE="nodejs"
    else DP_PROJECT_TYPE="unknown"; fi
}

# Internal: check if target is available
_dp_has_target() {
    local t; for t in "${DP_AVAILABLE_TARGETS[@]}"; do [[ "$t" == "$1" ]] && return 0; done; return 1
}

# 3. _deploy_vercel(project_dir)
_deploy_vercel() {
    local project_dir="$1"
    command -v vercel >/dev/null 2>&1 || { echo -e "${DP_RED}[DEPLOY]${DP_RESET} Vercel CLI not found." >&2; return 1; }
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Deploying to Vercel (production)..."
    local output; output=$(cd "$project_dir" && vercel --yes --prod 2>&1); local rc=$?
    if [[ $rc -eq 0 ]]; then
        DP_DEPLOY_URL=$(echo "$output" | grep -oE 'https://[^ ]+' | tail -1)
        echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Vercel: ${DP_BOLD}${DP_DEPLOY_URL}${DP_RESET}"
    else
        echo -e "${DP_RED}[DEPLOY]${DP_RESET} Vercel failed (exit=${rc})"; echo "$output" | tail -5
    fi
    return "$rc"
}

# 4. _deploy_local_serve(project_dir)
_deploy_local_serve() {
    local project_dir="$1" port="${DP_LOCAL_PORT:-3000}"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Starting local server on port ${port}..."
    local logf="/tmp/soloptilink_deploy_local.log"
    case "$DP_PROJECT_TYPE" in
        nextjs|react|vue|nuxt|nodejs)
            if [[ -f "${project_dir}/package.json" ]]; then
                if grep -q '"dev"' "${project_dir}/package.json" 2>/dev/null; then
                    (cd "$project_dir" && PORT=$port npm run dev > "$logf" 2>&1) &
                elif grep -q '"start"' "${project_dir}/package.json" 2>/dev/null; then
                    (cd "$project_dir" && PORT=$port npm start > "$logf" 2>&1) &
                else
                    echo -e "${DP_RED}[DEPLOY]${DP_RESET} No dev/start script"; return 1
                fi
                DP_LOCAL_PID=$!
            fi ;;
        flask)
            (cd "$project_dir" && FLASK_APP=app.py flask run --port "$port" > "$logf" 2>&1) &
            DP_LOCAL_PID=$! ;;
        django)
            (cd "$project_dir" && python3 manage.py runserver "0.0.0.0:${port}" > "$logf" 2>&1) &
            DP_LOCAL_PID=$! ;;
        fastapi)
            (cd "$project_dir" && uvicorn main:app --host 0.0.0.0 --port "$port" > "$logf" 2>&1) &
            DP_LOCAL_PID=$! ;;
        python|static|*)
            (cd "$project_dir" && python3 -m http.server "$port" > "$logf" 2>&1) &
            DP_LOCAL_PID=$! ;;
    esac
    sleep 3
    if kill -0 "$DP_LOCAL_PID" 2>/dev/null; then
        DP_DEPLOY_URL="http://localhost:${port}"
        echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Running: ${DP_BOLD}${DP_DEPLOY_URL}${DP_RESET} (pid=${DP_LOCAL_PID})"
        return 0
    else
        echo -e "${DP_RED}[DEPLOY]${DP_RESET} Server failed to start. See ${logf}"; return 1
    fi
}

# 5. _deploy_gh_pages(project_dir)
_deploy_gh_pages() {
    local project_dir="$1"
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Deploying to GitHub Pages..."
    # Build if needed
    if [[ -f "${project_dir}/package.json" ]] && grep -q '"build"' "${project_dir}/package.json" 2>/dev/null; then
        echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Building..."
        (cd "$project_dir" && npm run build 2>&1) || { echo -e "${DP_RED}[DEPLOY]${DP_RESET} Build failed."; return 1; }
    fi
    # Find build output
    local build_dir=""
    for d in dist build out public _site; do
        [[ -d "${project_dir}/${d}" ]] && { build_dir="${project_dir}/${d}"; break; }
    done
    [[ -z "$build_dir" ]] && { build_dir="$project_dir"; echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} No build dir; deploying root."; }
    # Push gh-pages branch
    (
        cd "$project_dir" || return 1
        local remote_url; remote_url=$(git remote get-url origin 2>/dev/null)
        [[ -z "$remote_url" ]] && { echo -e "${DP_RED}[DEPLOY]${DP_RESET} No origin remote."; return 1; }
        local repo_path; repo_path=$(echo "$remote_url" | sed -E 's|.*github\.com[:/](.+)(\.git)?$|\1|' | sed 's/\.git$//')
        git checkout --orphan gh-pages 2>/dev/null || git checkout gh-pages 2>/dev/null
        git rm -rf . 2>/dev/null
        [[ "$build_dir" != "$project_dir" ]] && cp -r "${build_dir}/"* . 2>/dev/null
        git add -A
        git commit -m "Deploy to GitHub Pages [auto-deploy]" 2>/dev/null
        git push origin gh-pages --force 2>&1; local rc=$?
        git checkout - 2>/dev/null
        if [[ $rc -eq 0 ]]; then
            DP_DEPLOY_URL="https://${repo_path%%/*}.github.io/${repo_path##*/}/"
            echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Pages: ${DP_BOLD}${DP_DEPLOY_URL}${DP_RESET}"
            echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} May take 1-2 min to propagate."
        fi
        return "$rc"
    )
}

# Internal: deploy to Railway
_deploy_railway() {
    local project_dir="$1"
    command -v railway >/dev/null 2>&1 || { echo -e "${DP_RED}[DEPLOY]${DP_RESET} Railway CLI not found." >&2; return 1; }
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Deploying to Railway..."
    local output; output=$(cd "$project_dir" && railway up --detach 2>&1); local rc=$?
    if [[ $rc -eq 0 ]]; then
        DP_DEPLOY_URL=$(echo "$output" | grep -oE 'https://[^ ]+' | tail -1)
        echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Railway: ${DP_BOLD}${DP_DEPLOY_URL}${DP_RESET}"
    else
        echo -e "${DP_RED}[DEPLOY]${DP_RESET} Railway failed (exit=${rc})"; echo "$output" | tail -5
    fi
    return "$rc"
}

# Internal: deploy to Netlify
_deploy_netlify() {
    local project_dir="$1"
    command -v netlify >/dev/null 2>&1 || { echo -e "${DP_RED}[DEPLOY]${DP_RESET} Netlify CLI not found." >&2; return 1; }
    echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Deploying to Netlify..."
    local output; output=$(cd "$project_dir" && netlify deploy --prod 2>&1); local rc=$?
    if [[ $rc -eq 0 ]]; then
        DP_DEPLOY_URL=$(echo "$output" | grep -oE 'https://[^ ]+' | tail -1)
        echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} Netlify: ${DP_BOLD}${DP_DEPLOY_URL}${DP_RESET}"
    else
        echo -e "${DP_RED}[DEPLOY]${DP_RESET} Netlify failed (exit=${rc})"; echo "$output" | tail -5
    fi
    return "$rc"
}

# 6. deploy_detect_targets(project_dir)
deploy_detect_targets() {
    local project_dir="${1:-.}"
    DP_AVAILABLE_TARGETS=()
    command -v vercel  >/dev/null 2>&1 && DP_AVAILABLE_TARGETS+=("vercel")
    command -v railway >/dev/null 2>&1 && DP_AVAILABLE_TARGETS+=("railway")
    command -v netlify >/dev/null 2>&1 && DP_AVAILABLE_TARGETS+=("netlify")
    if [[ -d "${project_dir}/.git" ]] || git -C "$project_dir" rev-parse --git-dir >/dev/null 2>&1; then
        local ru; ru=$(git -C "$project_dir" remote get-url origin 2>/dev/null)
        [[ "$ru" == *"github.com"* ]] && DP_AVAILABLE_TARGETS+=("gh-pages")
    fi
    { command -v python3 >/dev/null 2>&1 || command -v node >/dev/null 2>&1; } && DP_AVAILABLE_TARGETS+=("local")
}

# 7. deploy_health_check(url, retries)
deploy_health_check() {
    local url="${1:?url required}" retries="${2:-5}" delay=3 attempt=0
    command -v curl >/dev/null 2>&1 || { echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} curl unavailable, skip." >&2; return 0; }
    while [[ $attempt -lt $retries ]]; do
        attempt=$((attempt + 1))
        echo -e "${DP_CYAN}[DEPLOY]${DP_RESET} Health check ${attempt}/${retries}: ${url}"
        local code; code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "$url" 2>/dev/null)
        if [[ "$code" =~ ^2[0-9][0-9]$ ]]; then
            echo -e "${DP_GREEN}[DEPLOY]${DP_RESET} HTTP ${code} OK"; return 0
        fi
        echo -e "${DP_YELLOW}[DEPLOY]${DP_RESET} HTTP ${code}, retry in ${delay}s..."; sleep "$delay"
    done
    echo -e "${DP_RED}[DEPLOY]${DP_RESET} Health check failed after ${retries} attempts."; return 1
}

# 8. deploy_report(deploy_url, project_type)
deploy_report() {
    local deploy_url="${1:-$DP_DEPLOY_URL}" project_type="${2:-$DP_PROJECT_TYPE}"
    echo ""
    echo -e "${DP_CYAN}========================================${DP_RESET}"
    echo -e "${DP_BOLD} Deployment Report${DP_RESET}"
    echo -e "${DP_CYAN}========================================${DP_RESET}"
    echo -e " Project dir   : ${DP_PROJECT_DIR}"
    echo -e " Project type  : ${DP_BOLD}${project_type}${DP_RESET}"
    echo -e " Deploy method : ${DP_BOLD}${DP_DEPLOY_METHOD}${DP_RESET}"
    echo -e " URL           : ${DP_GREEN}${DP_BOLD}${deploy_url}${DP_RESET}"
    [[ -n "$DP_LOCAL_PID" ]] && echo -e " Local PID     : ${DP_LOCAL_PID}  (kill ${DP_LOCAL_PID} to stop)"
    echo -e " Targets avail : ${DP_AVAILABLE_TARGETS[*]:-none}"
    echo -e " Deployed at   : $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "${DP_CYAN}========================================${DP_RESET}"
    echo ""
}
