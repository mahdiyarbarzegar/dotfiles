# ============================================================
# Starship prompt
# ============================================================

#STARSHIP_HOME="$HOME/.starship_zsh"

#if [[ -f "$STARSHIP_HOME" ]]; then
#  source $STARSHIP_HOME
#fi

# Disable Starship's Zsh vi-mode integration.
export STARSHIP_ZSH_VI_MODE=false

eval "$(starship init zsh)"
