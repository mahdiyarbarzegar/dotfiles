#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"
source "$SCRIPT_DIR/../links.sh"

install_ghostty() {
    local ghostty_config="$DOTFILES_DIR/ghostty/config.ghostty"
    local ghostty_config_target="$HOME/.config/ghostty/config.ghostty"

    log "Installing Ghostty configuration..."

    [[ -f "$ghostty_config" ]] || die "Ghostty configuration not found: $ghostty_config"

    link_file "$ghostty_config" "$ghostty_config_target"

    log "Ghostty configuration installed successfully."
}