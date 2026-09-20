# ============================================================
# AMD PetaLinux
# ============================================================

PETALINUX_ROOT="$HOME/Petalinux/2025.2"
PETALINUX_SETTINGS="$PETALINUX_ROOT/settings.sh"

petalinux-active() {
    if [[ ! -f "$PETALINUX_SETTINGS" ]]; then
        echo "PetaLinux settings not found: $PETALINUX_SETTINGS" >&2
        return 1
    fi

    source "$PETALINUX_SETTINGS" "$PETALINUX_ROOT/"
}
