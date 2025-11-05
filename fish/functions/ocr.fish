#
# OCR the given file via LLM
#

function ocr --description "OCR the given file via LLM"
  if not type -q llm
    echo "Error: llm tool is not installed"
    echo "Install it with: uv tool install llm"
    return 1
  end

  set system_prompt "You are an OCR assistant. Extract and transcribe all text from the provided image accurately. Preserve formatting, structure, and layout as much as possible."

  if test (count $argv) -eq 1
    # Just file, no user prompt
    set file $argv[1]
    llm -s $system_prompt -a $file
  else if test (count $argv) -eq 2
    # User prompt and file
    set prompt $argv[1]
    set file $argv[2]
    llm -s $system_prompt $prompt -a $file
  else
    echo "Usage: ocr [prompt] <file>"
    return 1
  end

end

