#
# Start less with line numbers
#

function less --description "Less pager with line numbers and status bar"
  command less -N -M $argv
end
