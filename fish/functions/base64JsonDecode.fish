#
# Quick snippet to base64 decode and pretty print a JSON blob
#

function base64JsonDecode --description "Decode a JSON blob that has been base64 encoded"
  echo "$argv" | base64 -D | jq "."
end

