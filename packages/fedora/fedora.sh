#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../../install/common.sh"

fedora_configure_repositories() {
    if [[ "${DOTFILES_DRY_RUN:-false}" == "true" ]]; then
        log "Dry run: skipping repository configuration."
        return 0
    fi

    local repo_dir="$SCRIPT_DIR/repos"

    [[ -d "$repo_dir" ]] || die "Repository directory not found: $repo_dir"

    for repo_script in "$repo_dir"/*.sh; do
        [[ -e "$repo_script" ]] || continue

        log "Configuring repository: $(basename "$repo_script")"

        bash "$repo_script"
    done
}

fedora_install_packages() {
    local group="${1:-}"
    local package_dir="$SCRIPT_DIR/packages"

    [[ -d "$package_dir" ]] || \
        die "Package directory not found: $package_dir"

    local package_files=()

    if [[ -n "$group" ]]; then
        local package_file="$package_dir/${group}.txt"

        [[ -f "$package_file" ]] || \
            die "Package group not found: $group"

        package_files+=("$package_file")
    else
        for package_file in "$package_dir"/*.txt; do
            [[ -e "$package_file" ]] || continue
            package_files+=("$package_file")
        done
    fi

    if [[ ${#package_files[@]} -eq 0 ]]; then
        warn "No package lists found."
        return 0
    fi

    local packages=()

    for package_file in "${package_files[@]}"; do
        log "Reading package list: $(basename "$package_file")"

        while IFS= read -r package; do
            packages+=("$package")
        done < <(
            grep -vE '^[[:space:]]*(#|$)' "$package_file"
        )
    done

    if [[ ${#packages[@]} -eq 0 ]]; then
        warn "No packages specified."
        return 0
    fi

    mapfile -t packages < <(
        printf '%s\n' "${packages[@]}" | sort -u
    )

    log "Packages:"
    printf '  %s\n' "${packages[@]}"

    if [[ "${DOTFILES_DRY_RUN:-false}" == "true" ]]; then
        log "Dry run: skipping package installation."
        return 0
    fi

    log "Installing ${#packages[@]} package(s)..."

    sudo dnf install -y "${packages[@]}"
}