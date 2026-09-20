# ============================================================
# Starship prompt
# ============================================================

STARSHIP_HOME="$HOME/.starship_zsh"

if [[ -f "$STARSHIP_HOME" ]]; then
  source $STARSHIP_HOME
fi

#if command -v starship >/dev/null 2>&1; then
#    eval "$(starship init zsh)"
#fi
