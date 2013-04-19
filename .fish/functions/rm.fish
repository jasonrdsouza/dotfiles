#
# Alias rm so that rm'd files go to the trash instead.
# Uses the trash-cli tool
#

function rm --description "Make rm move files to trash instead of deleting them"
  command trash-put $argv
end
