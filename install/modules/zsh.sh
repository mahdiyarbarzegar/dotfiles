#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"
source "$SCRIPT_DIR/../links.sh"

install_zsh() {
    local zsh_config="$DOTFILES_DIR/zsh/zshrc"
    local zshrc="$HOME/.zshrc"

    log "Installing Zsh configuration..."

    [[ -f "$zsh_config" ]] || die "Zsh configuration not found: $zsh_config"

    link_file "$zsh_config" "$zshrc"

    log "Zsh configuration installed successfully."
}
