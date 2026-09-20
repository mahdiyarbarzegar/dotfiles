#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../common.sh"
source "$SCRIPT_DIR/../links.sh"

install_git() {
    local git_config="$DOTFILES_DIR/git/gitconfig"
    local git_config_target="$HOME/.gitconfig"

    local local_config_dir="$HOME/.config/git"
    local local_config="$local_config_dir/local.gitconfig"

    log "Installing Git configuration..."

    [[ -f "$git_config" ]] || die "Git configuration not found: $git_config"

    mkdir -p "$local_config_dir"

    if [[ ! -f "$local_config" ]]; then
        log "Creating local Git configuration..."

        local git_name
        local git_email

        read -r -p "Git user name: " git_name
        read -r -p "Git user email: " git_email

        git config --file "$local_config" user.name "$git_name"
        git config --file "$local_config" user.email "$git_email"

        log "Created: $local_config"
    else
        log "Local Git configuration already exists: $local_config"
    fi

    link_file "$git_config" "$git_config_target"

    log "Git configuration installed successfully."
}