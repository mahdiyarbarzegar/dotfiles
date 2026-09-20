# ============================================================
# Zsh options
# ============================================================

# Keybindings for word navigation
bindkey '^[[1;5C' forward-word # CTRL+RIGHT
bindkey '^[[1;5D' backward-word # CTRL+LEFT
bindkey '^[[3~' delete-char

# Initialize Zsh completions first
autoload -Uz compinit
compinit -C

# Enable Bash-style completion (if needed for specific commands)
autoload -Uz bashcompinit
bashcompinit