#
# Show ruby version
#

set fish_ruby_version_color yellow

function ruby_version --description "Show which version of ruby is active"
  printf '%s(%s) ' (set_color $fish_ruby_version_color) (ruby --version | cut -d' ' -f1,2)
end