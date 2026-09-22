# ------------------------------------------------------------
# Zinit
# ------------------------------------------------------------

ZINIT_HOME="$HOME/.zinit"

# zsh-vi-mode configuration
# Enable system clipboard integration
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
# Wayland clipboard
ZVM_CLIPBOARD_COPY_CMD='wl-copy'
ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n'

if [[ -f "$ZINIT_HOME/zinit.zsh" ]]; then
    source "$ZINIT_HOME/zinit.zsh"

    zinit light zdharma-continuum/history-search-multi-word
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit cdreplay -q

    # Vim-style editing
    zinit ice depth=1
    zinit light jeffreytse/zsh-vi-mode
fi
