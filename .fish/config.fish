#
# Fish user config file
# @author: jasonrdsouza
#


#
# Add custom locations to $PATH
# 
set -g fish_user_paths $HOME/go/bin {$HOME}/bin /usr/local/bin (/opt/homebrew/bin/brew --prefix)/bin

#
# Enable Vi Keybindings
#
fish_vi_key_bindings

#
# Golang environment variables
#
set -g -x GOROOT (go env GOROOT)
set -g -x GOPATH {$HOME}/go

#
# Set EDITOR variable to be vanilla vim
#
set -g -x EDITOR "vim --noplugin"

#
# Use Bat instead of Cat if available
#
if type -q bat
  alias cat "bat --paging=never"
end

#
# Source local config
#
set -g -x LOCAL_CONFIG {$HOME}/local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

#
# Source TA config file
#
set -g -x TRIP_SCRIPTS {$HOME}/tr-users/jdsouza
if test -f {$TRIP_SCRIPTS}/fish/trip_config.fish
  source {$TRIP_SCRIPTS}/fish/trip_config.fish
end

#
# Source Localytics config file
#
set -g -x LOCALYTICS_CONFIG {$HOME}/.localytics/config.fish
if test -f $LOCALYTICS_CONFIG
  source $LOCALYTICS_CONFIG
end

#
# Source Amazon config file
#
set -g -x AMAZON_CONFIG {$HOME}/.amazon/config.fish
if test -f $AMAZON_CONFIG
  source $AMAZON_CONFIG
end

