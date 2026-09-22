#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../../../install/common.sh"

REPO_FILE="/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo"

if [[ -f "$REPO_FILE" ]]; then
    log "Ghostty COPR is already enabled."
    exit 0
fi

log "Enabling Ghostty COPR..."

sudo dnf copr enable -y scottames/ghostty