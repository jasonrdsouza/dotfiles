#
# Use an LLM to find synonyms for the given word
#

function synonyms --description "LLM driven synonyms for a given word"
  if type -q llm
    llm $argv --system "Define and then return some synonyms for the following word"
  else
    echo "[ERROR] LLM command not installed"
  end
end

