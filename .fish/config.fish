#
# Fish user config file
# @author: jasonrdsouza
#


#
# Setup RVM
#
rvm > /dev/null

#
# Add custom locations to $PATH
# - golang bin
# - my gocode bin
# - dart bin
# - local bin
# 
set -g fish_user_paths /usr/local/go/bin $HOME/gocode/bin /usr/local/dart/dart-sdk/bin {$HOME}/bin

#
# Golang environment variables
#
set -g -x GOPATH {$HOME}/gocode

#
# Set EDITOR variable (not sure if its needed)
#
set -g -x EDITOR vim

#
# Add personal functions path
#
#set -g fish_function_path $fish_function_path {$HOME}/<personal_functions_dir>

#
# Source TA config file
#
set -g -x TRIP_SCRIPTS {$HOME}/tr-users/jdsouza
if test -f {$TRIP_SCRIPTS}/fish/trip_config.fish
  . {$TRIP_SCRIPTS}/fish/trip_config.fish
end


