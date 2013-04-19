#
# Helper function to alert the user when a command has finished running
# Especially useful for long-running commands.
# Uses the notify-send utility
#

function alert --description "Popup alert when something finishes running"
  command notify-send --urgency=low "$argv"
end
