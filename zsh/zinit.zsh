# ------------------------------------------------------------
# Zinit
# ------------------------------------------------------------

ZINIT_HOME="$HOME/.zinit"

if [[ -f "$ZINIT_HOME/zinit.zsh" ]]; then
    source "$ZINIT_HOME/zinit.zsh"

    zinit light zdharma-continuum/history-search-multi-word
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit cdreplay -q
fi
