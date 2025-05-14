#
# Logophile allows you to give a description, and comes up with
# words that match that description. Useful to improve writing
# terseness
#

function logophile --description "Convert descriptions to candidate words"
  if type -q llm
    llm $argv --system "You are a sophisticated logophile capable of taking a description of a word or scenario and doing a reverse dictionary lookup to figure out the individual word (or if there is no individual word, pithy phrase) which captures the same semantic intent. Return the top words or phrases based on the users query"
  else
    echo "[ERROR] LLM command not installed"
  end
end

