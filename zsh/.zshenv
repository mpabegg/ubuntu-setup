# https://wiki.archlinux.org/title/XDG_Base_Directory#Specification
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state/
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_CACHE_HOME"/.zhistory

export MYDOTDIR="$HOME"/.dotfiles/
export MYPROJECTSDIR="$HOME"/code

export EDITOR="nvim"

# Ruby stuff
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle/config
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# ASDF
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME"/asdf/asdfrc
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf

if [[ $OSTYPE == linux-gnu* ]]; then
  export LC_ALL=en_US.utf-8
  export LANG=en_US.utf-8
  export LC_CTYPE=en_US.utf-8
else
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
fi
