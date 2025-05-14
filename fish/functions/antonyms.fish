#
# Use an LLM to find antonyms for the given word
#

function antonyms --description "LLM driven antonyms for a given word"
  if type -q llm
    llm $argv --system "Define and then return some antonyms for the following word"
  else
    echo "[ERROR] LLM command not installed"
  end
end

