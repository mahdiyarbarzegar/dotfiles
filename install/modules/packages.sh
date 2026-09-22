#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"

install_packages() {
    local group=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --group)
                [[ $# -ge 2 ]] || die "--group requires a group name"
                group="$2"
                shift 2
                ;;

            *)
                die "Unknown packages option: $1"
                ;;
        esac
    done

    log "Installing system packages..."

    if [[ ! -f /etc/os-release ]]; then
        die "Cannot detect Linux distribution: /etc/os-release not found"
    fi

    source /etc/os-release

    case "$ID" in
        fedora)
            source "$DOTFILES_DIR/packages/fedora/fedora.sh"

            log "Detected Fedora."

            fedora_configure_repositories
            fedora_install_packages "$group"
            ;;

        *)
            die "Unsupported Linux distribution: $ID"
            ;;
    esac

    log "System packages installed successfully."
}