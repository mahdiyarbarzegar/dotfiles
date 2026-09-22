#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"
source "$SCRIPT_DIR/../links.sh"

install_nvim() {
    local nvim_config="$DOTFILES_DIR/nvim"
    local nvim_config_dir="$HOME/.config"
    local nvim_config_target="$nvim_config_dir/nvim"

    log "Installing Neovim..."

    [[ -f "$DOTFILES_DIR/tools/nvim.sh" ]] || \
        die "Neovim installer not found: $DOTFILES_DIR/tools/nvim.sh"

    bash "$DOTFILES_DIR/tools/nvim.sh"

    log "Installing Neovim configuration..."

    [[ -d "$nvim_config" ]] || \
        die "Neovim configuration not found: $nvim_config"

    mkdir -p "$nvim_config_dir"

    link_file "$nvim_config" "$nvim_config_target"

    log "Neovim installed successfully."
}
