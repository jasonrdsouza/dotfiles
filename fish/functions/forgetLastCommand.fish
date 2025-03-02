#
# Command to forget the last shell command so it isn't in the shell history
#

function forgetLastCommand --description "Forget the last typed command from the shell history"
  set last_typed_command (history --max 1)
  history delete --exact --case-sensitive "$last_typed_command"
  history save
end

