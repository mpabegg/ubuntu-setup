#!/usr/bin/env zsh

# ----------------------------------------
# ⚙️  Basic Shell Behavior
# ----------------------------------------

setopt NULL_GLOB             # Globs that don't match expand to nothing (no error)
bindkey -e                   # Use Emacs-style keybindings

# ----------------------------------------
# 🧠 Completion System Configuration
# ----------------------------------------

# Set completion cache location and enable menu selection (like arrow-key menus)
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

# ----------------------------------------
# 🌠 Optional: Starship Prompt
# ----------------------------------------

# Initialize Starship prompt if available (cross-shell statusline)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ----------------------------------------
# 🧩 Completion Initialization
# ----------------------------------------

autoload -Uz compinit        # Load Zsh completion system

# Regenerate the zcompdump file if it's more than ~20 hours old
_comp_files=($XDG_CACHE_HOME/zsh/zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
else
  compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi
unset _comp_files

# ----------------------------------------
# 🛠️ Autoload Custom Functions
# ----------------------------------------

# Add all subfolders of $ZDOTDIR/functions/ to fpath
fpath=($ZDOTDIR/functions/**/ $fpath)

# Autoload all function files inside that path
autoload -U $ZDOTDIR/functions/**/*(.:t)

# ----------------------------------------
# 🎨 UI Enhancements
# ----------------------------------------

zmodload zsh/complist        # Enable advanced completion features (e.g., selection UI)
_comp_options+=(globdots)    # Include dotfiles in completion results
autoload -Uz colors && colors  # Enable and load color definitions

# ----------------------------------------
# 🔌 Load Custom Init and Plugins
# ----------------------------------------

# Source custom function definitions if the file exists
[[ -f "$ZDOTDIR/zsh-functions" ]] && source "$ZDOTDIR/zsh-functions"

# Initialize plugins if the function is defined
command -v zsh_init_plugins &>/dev/null && zsh_init_plugins

# Source all .zsh files in ~/.config/zsh/adds/ if they exist
for file in "$HOME/.config/zsh/adds/"*.zsh(N); do
  source "$file"
done

# ----------------------------------------
# 🧾 Aliases and Plugin Setup
# ----------------------------------------

# Source user-defined aliases if the file exists
[[ -f "$ZDOTDIR/alias.zsh" ]] && source "$ZDOTDIR/alias.zsh"

# Add plugins manually (can be used by your zsh_add_plugin helper)
zsh_add_plugin "zimfw/environment"                      # Loads environment settings
zsh_add_plugin "zsh-users/zsh-autosuggestions"          # Shows command suggestions as you type
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"      # Highlights commands and syntax in real time

# Configure autosuggestions (accept suggestion with Ctrl+Y)
bindkey '^Y' autosuggest-accept

# Disable bell sounds
set bell-style off

# ----------------------------------------
# 🛣️ PATH Setup
# ----------------------------------------

# Add local user binaries, system sbin, and optional Neovim paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
