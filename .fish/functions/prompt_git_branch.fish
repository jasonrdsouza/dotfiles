#
# Function to get the current git branch
# Mainly for use in the command prompt
#

function prompt_git_branch --description "Get the current git branch"
  set fish_git_branch_color purple
  set -l branch (git symbolic-ref HEAD 2> /dev/null | cut -d/ -f3-)
  if test -n "$branch"
    printf "%s[%s] " (set_color $fish_git_branch_color) $branch
  end
end