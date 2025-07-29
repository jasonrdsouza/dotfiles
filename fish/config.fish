#
# Fish user config file
# @author: jasonrdsouza
#


# Add custom locations to $PATH
set -g fish_user_paths {$HOME}/.local/bin /usr/local/bin /opt/homebrew/bin

# Enable Vi Keybindings
fish_vi_key_bindings

# Set EDITOR variable to be vanilla nvim
set -g -x EDITOR "vim --clean"

# Quality of Life Aliases
alias ls "ls --color=auto"
alias ll "ls -lahF"
alias la "ls -A"
alias grep "grep -i --color=auto"
alias less "less -N -M"

# Alias vim to nvim if present
if type -q nvim
  alias vim "nvim"
  alias view "nvim -R"
end

# Use Bat instead of Cat if available
if type -q bat
  alias cat "bat --style=plain --paging=never"
end

# Interactive shell history search
if type -q fzf
  alias historical "history | fzf --header-lines=1"
end

# Golang environment variables
if type -q go
  set -g -x GOROOT (go env GOROOT)
  set -g -x GOPATH {$HOME}/go
  set -g -x GOBIN {$HOME}/go/bin
end

# Source local config
set -g -x LOCAL_CONFIG {$HOME}/local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

# Source TripAdvisor config file
set -g -x TRIP_SCRIPTS {$HOME}/tr-users/jdsouza
if test -f {$TRIP_SCRIPTS}/fish/trip_config.fish
  source {$TRIP_SCRIPTS}/fish/trip_config.fish
end

# Source Localytics config file
set -g -x LOCALYTICS_CONFIG {$HOME}/.localytics/config.fish
if test -f $LOCALYTICS_CONFIG
  source $LOCALYTICS_CONFIG
end

# Source Amazon config file
set -g -x AMAZON_CONFIG {$HOME}/notebook/files/dotfiles/config.fish
if test -f $AMAZON_CONFIG
  source $AMAZON_CONFIG
end

# Source Pedestal config file
set -g -x PEDESTAL_CONFIG {$HOME}/Documents/scripts/config.fish
if test -f $PEDESTAL_CONFIG
  source $PEDESTAL_CONFIG
end

