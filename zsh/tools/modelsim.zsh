# ============================================================
# ModelSim
# ============================================================

MODELSIM_ROOT="/opt/ModelSim-2020.4"
MODELSIM_BIN="$MODELSIM_ROOT/modeltech/bin"
MODELSIM_LICENSE="$MODELSIM_ROOT/LICENSE.TXT"

if [[ -d "$MODELSIM_BIN" ]]; then
    path=(
        "$MODELSIM_BIN"
        $path
    )

    export MTI_VCO_MODE=64
fi

if [[ -f "$MODELSIM_LICENSE" ]]; then
    export LM_LICENSE_FILE="${LM_LICENSE_FILE:+$LM_LICENSE_FILE:}$MODELSIM_LICENSE"
fi
