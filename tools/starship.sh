#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../install/common.sh"

install_starship() {
    log "Checking Starship installation..."

    if command -v starship >/dev/null 2>&1; then
        log "Starship is already installed."
        return 0
    fi

    if [[ ! -f /etc/os-release ]]; then
        die "Cannot detect Linux distribution: /etc/os-release not found"
    fi

    source /etc/os-release

    case "$ID" in
        fedora)
            install_starship_fedora
            ;;

        *)
            die "Unsupported Linux distribution: $ID"
            ;;
    esac
}

install_starship_fedora() {
    log "Enabling Starship COPR..."

    sudo dnf copr enable -y atim/starship

    log "Installing Starship..."

    sudo dnf install -y starship

    log "Starship installed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    install_starship
fi