#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/install/common.sh"
source "$SCRIPT_DIR/install/modules.sh"

DRY_RUN=false

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
    shift

    export DOTFILES_DRY_RUN="$DRY_RUN"

    load_module "$module"

    local function_name="install_${module}"

    if ! declare -F "$function_name" >/dev/null; then
        die "Module '$module' does not provide function '$function_name'"
    fi

    log "Running module: $module"
    "$function_name" "$@"
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi

    local module
    local -a module_args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;

            --dry-run)
                DRY_RUN=true
                shift
                ;;

            all)
                for module in "${MODULES[@]}"; do
                    run_module "$module"
                done
                shift
                ;;

            packages)
                module_args=()
                shift

                while [[ $# -gt 0 ]]; do
                    case "$1" in
                        --group)
                            [[ $# -ge 2 ]] || die "--group requires a group name"

                            module_args+=("--group" "$2")
                            shift 2
                            ;;

                        --dry-run)
                            DRY_RUN=true
                            shift
                            ;;

                        *)
                            break
                            ;;
                    esac
                done

                run_module packages "${module_args[@]}"
                ;;

            *)
                run_module "$1"
                shift
                ;;
        esac
    done
}

main "$@"
