#
# Fish user config file
# @author: jasonrdsouza
#


#
# Add custom locations to $PATH
# 
set -g fish_user_paths $HOME/gocode/bin {$HOME}/bin

#
# Golang environment variables
#
set -g -x GOPATH {$HOME}/gocode

#
# Set EDITOR variable to be vanilla vim
#
set -g -x EDITOR "vim --noplugin"

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


