#!/usr/bin/env bash

backup_existing() {
    local target="$1"

    if [[ ! -e "$target" && ! -L "$target" ]]; then
        return 0
    fi

    local backup="${target}.backup.$(date +%Y%m%d-%H%M%S)"

    log "Backing up: $target"
    mv "$target" "$backup"

    log "Backup created: $backup"
}

link_file() {
    local source="$1"
    local target="$2"

    if [[ ! -e "$source" ]]; then
        die "Source does not exist: $source"
    fi

    # Already the correct symlink
    if [[ -L "$target" ]]; then
        local current_target
        current_target="$(readlink -f "$target")"

        if [[ "$current_target" == "$(readlink -f "$source")" ]]; then
            log "Already linked: $target"
            return 0
        fi
    fi

    backup_existing "$target"

    log "Linking:"
    log "  $target -> $source"

    ln -s "$source" "$target"
}
