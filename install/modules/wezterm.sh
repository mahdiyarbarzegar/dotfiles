#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"
source "$SCRIPT_DIR/../links.sh"

install_wezterm() {
    local wezterm_config="$DOTFILES_DIR/wezterm/wezterm.lua"
    local wezterm_config_target="$HOME/.wezterm.lua"

    log "Installing WezTerm configuration..."

    [[ -f "$wezterm_config" ]] || die "WezTerm configuration not found: $wezterm_config"

    link_file "$wezterm_config" "$wezterm_config_target"

    log "WezTerm configuration installed successfully."
}