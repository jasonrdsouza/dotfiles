#
# LLM-based Unix Greybeard to assist with shell incantations
#

function greybeard --description "LLM Unix Greybeard to assist with shell incantations"
  if type -q llm
    llm cmd $argv
  else
    echo "[ERROR] LLM command not installed"
  end
end

