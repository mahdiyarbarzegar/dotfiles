#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../install/common.sh"

install_ghostty() {
    log "Checking Ghostty installation..."

    if command -v ghostty >/dev/null 2>&1; then
        log "Ghostty is already installed."
        return 0
    fi

    if [[ ! -f /etc/os-release ]]; then
        die "Cannot detect Linux distribution: /etc/os-release not found"
    fi

    source /etc/os-release

    case "$ID" in
        fedora)
            install_ghostty_fedora
            ;;

        *)
            die "Unsupported Linux distribution: $ID"
            ;;
    esac
}

install_ghostty_fedora() {
    log "Enabling Ghostty COPR..."

    sudo dnf copr enable -y scottames/ghostty

    log "Installing Ghostty..."

    sudo dnf install -y ghostty

    log "Ghostty installed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    install_ghostty
fi