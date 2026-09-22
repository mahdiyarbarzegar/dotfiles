#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../../../install/common.sh"

REPO_FILE="/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:wezfurlong:wezterm-nightly.repo"

if [[ -f "$REPO_FILE" ]]; then
    log "WezTerm COPR is already enabled."
    exit 0
fi

log "Enabling WezTerm COPR..."

sudo dnf copr enable -y wezfurlong/wezterm-nightly