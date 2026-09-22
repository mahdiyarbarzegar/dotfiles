#!/usr/bin/env bash

set -euo pipefail

NVIM_VERSION="0.12.5"
NVIM_SHA256="bce0f56eda1f1b1db6eee8f4133d7a38813ea07933837dd1777411ca384c6875"
NVIM_INSTALL_DIR="/opt/nvim"
NVIM_BIN_PATH="$NVIM_INSTALL_DIR/bin/nvim"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../install/common.sh"

install_nvim() {
    log "Checking Neovim ${NVIM_VERSION}..."

    if [[ -x "$NVIM_BIN_PATH" ]]; then
        local installed_version
        installed_version="$("$NVIM_BIN_PATH" --version | head -n 1)"

        if [[ "$installed_version" == "NVIM v${NVIM_VERSION}" ]]; then
            log "Neovim ${NVIM_VERSION} is already installed."
            return 0
        fi

        log "Different Neovim version detected:"
        log "  installed: $installed_version"
        log "  required:  NVIM v${NVIM_VERSION}"
    fi

    case "$(uname -m)" in
        x86_64)
            ;;
        *)
            die "Unsupported architecture: $(uname -m)"
            ;;
    esac

    local archive="nvim-linux-x86_64.tar.gz"
    local url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${archive}"

    if [[ "${DOTFILES_DRY_RUN:-false}" == "true" ]]; then
        log "Dry run: would download:"
        log "  $url"

        log "Dry run: would verify SHA-256:"
        log "  $NVIM_SHA256"

        log "Dry run: would install to:"
        log "  $NVIM_INSTALL_DIR"

        return 0
    fi

    local tmp_dir
    tmp_dir="$(mktemp -d)"

    trap 'rm -rf "$tmp_dir"' RETURN

    log "Downloading Neovim ${NVIM_VERSION}..."

    curl -fL \
        "$url" \
        -o "$tmp_dir/$archive"

    log "Verifying SHA-256..."

    local actual_sha256
    actual_sha256="$(sha256sum "$tmp_dir/$archive" | awk '{print $1}')"

    if [[ "$actual_sha256" != "$NVIM_SHA256" ]]; then
        die "SHA-256 verification failed!
  expected: $NVIM_SHA256
  actual:   $actual_sha256"
    fi

    log "SHA-256 verification passed."

    log "Installing Neovim to $NVIM_INSTALL_DIR..."

    sudo rm -rf "$NVIM_INSTALL_DIR"

    sudo tar -xzf \
        "$tmp_dir/$archive" \
        -C /opt

    sudo mv \
        "/opt/nvim-linux-x86_64" \
        "$NVIM_INSTALL_DIR"

    log "Verifying installation..."

    local installed_version
    installed_version="$("$NVIM_BIN_PATH" --version | head -n 1)"

    if [[ "$installed_version" != "NVIM v${NVIM_VERSION}" ]]; then
        die "Installed version verification failed!
  expected: NVIM v${NVIM_VERSION}
  actual:   $installed_version"
    fi

    log "$installed_version"
    log "Neovim ${NVIM_VERSION} installed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    install_nvim
fi