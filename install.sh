#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/install/common.sh"
source "$SCRIPT_DIR/install/modules.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") [module...]

Available modules:
    -- all      Install all modules
    zsh         Install Zsh configuration

Examples:
    $(basename "$0") zsh
    $(basename "$0") --all
EOF
}

run_module() {
    local module="$1"

    load_module "$module"

    local function_name="install_${module}"

    if ! declare -F "$function_name" >/dev/null; then
        die "Module '$module' does not provide function '$function_name'"
    fi

    log "Running module: $module"
    "$function_name"
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi

    for module in "$@"; do
        case "$module" in
            -h|--help)
                usage
                ;;
            --all)
                for module in "${MODULES[@]}"; do
                    run_module "$module"
                done
                ;;
            *)
                run_module "$module"
                ;;
        esac
    done
}

main "$@"
