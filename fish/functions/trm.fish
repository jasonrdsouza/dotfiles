#
# Drop in replacement for rm so that rm'd files go to 
# the trash instead.
# Uses the trash-cli tool
#

function trm --description "Move files to trash instead of deleting them"
  command trash-put $argv
end
