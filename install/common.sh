#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

load_module() {
    local module="$1"
    local module_file="$DOTFILES_DIR/install/modules/${module}.sh"

    [[ -f "$module_file" ]] || die "Module not found: $module"

    source "$module_file"
}

log() {
    printf '\033[1;32m[INFO]\033[0m %s\n' "$*"
}

warn() {
    printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

error() {
    printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2
}

die() {
	error "$*"
	exit 1
}