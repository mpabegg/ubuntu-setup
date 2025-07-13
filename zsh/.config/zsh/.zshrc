#!/usr/bin/env zsh

setopt NULL_GLOB

# Use emacs keybindings
bindkey -e

# Set up completion caching
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

# Initialize Starship prompt (if available)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Load completions (Homebrew or fallback)
autoload -Uz compinit

# Add Homebrew completions if available
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

# Regenerate zcompdump if older than 20 hours
_comp_files=($XDG_CACHE_HOME/zsh/zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
else
  compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi
unset _comp_files

# Add custom function directories to fpath and autoload them
fpath=($ZDOTDIR/functions/**/ $fpath)
autoload -U $ZDOTDIR/functions/**/*(.:t)

# Load zsh/complist module and set completion options
zmodload zsh/complist
_comp_options+=(globdots)

# Load colors
autoload -Uz colors && colors

# Source custom functions and initialize plugins
[[ -f "$ZDOTDIR/zsh-functions" ]] && source "$ZDOTDIR/zsh-functions"
command -v zsh_init_plugins &>/dev/null && zsh_init_plugins

# Source all .zsh files in the adds directory
for file in "$HOME/.config/zsh/adds/"*.zsh(N); do
  source "$file"
done

# Source aliases
[[ -f "$ZDOTDIR/alias.zsh" ]] && source "$ZDOTDIR/alias.zsh"

# Add and configure plugins
zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Set keybinding for accepting autosuggestions
bindkey '^Y' autosuggest-accept
set bell-style off

# Set environment variables
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export ARCHFLAGS="-arch $(uname -m)"

# Modify PATH (remove mac-only paths, only include relevant ones)
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
