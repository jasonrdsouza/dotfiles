#
# Fish user config file
# @author: jasonrdsouza
#


#
# Add custom locations to $PATH
# 
set -g fish_user_paths $HOME/gocode/bin {$HOME}/bin /usr/local/bin /usr/local/sbin/

#
# Enable Vi Keybindings
#
fish_vi_mode

#
# Golang environment variables
#
set -g -x GOROOT (go env GOROOT)
set -g -x GOPATH {$HOME}/gocode

#
# Set EDITOR variable to be vanilla vim
#
set -g -x EDITOR "vim --noplugin"

#
# Setup Google Cloud SDK
#
set -g fish_user_paths $fish_user_paths /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin

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

