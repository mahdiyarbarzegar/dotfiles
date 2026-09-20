# ============================================================
# AMD Vivado
# ============================================================

VIVADO_SETTINGS="/opt/Xilinx/2025.2/Vivado/settings64.sh"

if [[ -f "$VIVADO_SETTINGS" ]]; then
    source "$VIVADO_SETTINGS"
fi
