#!/usr/bin/env bash

set -euo pipefail

ZINIT_VERSION="3.17.0"
ZINIT_INSTALL_DIR="$HOME/.zinit"
ZINIT_VERSION_FILE="$ZINIT_INSTALL_DIR/VERSION"
ZINIT_SCRIPT="$ZINIT_INSTALL_DIR/zinit.zsh"

ZINIT_URL="https://github.com/zdharma-continuum/zinit/archive/refs/tags/v${ZINIT_VERSION}.tar.gz"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../install/common.sh"

install_zinit() {
    log "Checking Zinit installation..."

    if [[ -f "$ZINIT_VERSION_FILE" ]]; then
        local installed_version
        installed_version="$(<"$ZINIT_VERSION_FILE")"

        if [[ "$installed_version" == "$ZINIT_VERSION" ]]; then
            log "Zinit ${ZINIT_VERSION} is already installed."
            return 0
        fi

        log "Different Zinit version detected:"
        log "  installed: $installed_version"
        log "  required:  $ZINIT_VERSION"
    fi

    if [[ "${DOTFILES_DRY_RUN:-false}" == "true" ]]; then
        log "Dry run: would download:"
        log "  $ZINIT_URL"

        log "Dry run: would install to:"
        log "  $ZINIT_INSTALL_DIR"

        return 0
    fi

    local tmp_dir
    tmp_dir="$(mktemp -d)"

    trap 'rm -rf "$tmp_dir"' RETURN

    local archive="zinit-v${ZINIT_VERSION}.tar.gz"

    log "Downloading Zinit ${ZINIT_VERSION}..."

    curl -fL \
        "$ZINIT_URL" \
        -o "$tmp_dir/$archive"

    log "Installing Zinit to $ZINIT_INSTALL_DIR..."

    rm -rf "$ZINIT_INSTALL_DIR"

    mkdir -p "$ZINIT_INSTALL_DIR"

    tar -xzf \
        "$tmp_dir/$archive" \
        -C "$tmp_dir"

    mv \
        "$tmp_dir/zinit-${ZINIT_VERSION}"/* \
        "$ZINIT_INSTALL_DIR/"

    log "Verifying Zinit installation..."

    if [[ ! -f "$ZINIT_VERSION_FILE" ]]; then
        die "Zinit VERSION file not found: $ZINIT_VERSION_FILE"
    fi

    local installed_version
    installed_version="$(<"$ZINIT_VERSION_FILE")"

    if [[ "$installed_version" != "$ZINIT_VERSION" ]]; then
        die "Zinit version verification failed:
  expected: $ZINIT_VERSION
  actual:   $installed_version"
    fi

    log "Zinit ${ZINIT_VERSION} installed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    install_zinit
fi