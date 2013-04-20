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
# 
set -U fish_user_paths /usr/local/go/bin $HOME/gocode/bin /usr/local/dart/dart-sdk/bin 

#
# Golang environment variables
#
set -U -x GOPATH {$HOME}/gocode

#
# Set EDITOR variable (not sure if its needed)
#
set -g -x EDITOR vim

