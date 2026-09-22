#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../install/common.sh"

install_wezterm() {
    log "Checking WezTerm installation..."

    if command -v wezterm >/dev/null 2>&1; then
        log "WezTerm is already installed."
        return 0
    fi

    if [[ ! -f /etc/os-release ]]; then
        die "Cannot detect Linux distribution: /etc/os-release not found"
    fi

    source /etc/os-release

    case "$ID" in
        fedora)
            install_wezterm_fedora
            ;;

        *)
            die "Unsupported Linux distribution: $ID"
            ;;
    esac
}

install_wezterm_fedora() {
    local repo_script="$DOTFILES_DIR/packages/fedora/repos/wezterm.sh"

    [[ -f "$repo_script" ]] || \
        die "WezTerm repository script not found: $repo_script"

    log "Configuring WezTerm repository..."

    bash "$repo_script"

    log "Installing WezTerm..."

    sudo dnf install -y wezterm

    log "WezTerm installed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    install_wezterm
fi