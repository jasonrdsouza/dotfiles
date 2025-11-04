#
# Print out the current time and calendar date
#

function now --description "Print out the current time and date"
  date "+%l:%M%p on %A, %B %e, %Y"
  echo
  cal | grep -E "\b$(date '+%e')\b| "
end

