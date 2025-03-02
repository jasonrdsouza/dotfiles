#
# Helper function to alert the user when a command has finished running
# Especially useful for long-running commands.
# Uses Hammerspoon, and depends on the following URLevent configuration:
#
# hs.urlevent.bind("alert", function(eventName, params)
#     hs.alert.show(params["value"])
# end)
#

function alert --description "Popup alert when something finishes running"
  open -g "hammerspoon://alert?value=$argv"
end
