# Kak user preferences

# Set color scheme
colorscheme gruvbox

# Show whitespace characters
add-highlighter global/ show-whitespaces
# Show line numbers (relative to current line)
add-highlighter global/ number-lines -relative -hlcursor
# What does this do?
add-highlighter global/ show-matching

# Turn tabs into 4 spaces
set global tabstop 4

# Comment out current line
map global normal '#' :comment-line<ret>

# use tab for tab completion (https://github.com/mawww/kakoune/issues/1327)
hook global InsertCompletionShow .* %{
  map window insert <tab> <c-n>
  map window insert <s-tab> <c-p>
}
hook global InsertCompletionHide .* %{
  unmap window insert <tab> <c-n>
  unmap window insert <s-tab> <c-p>
}

# System clipboard handling
evaluate-commands %sh{
  case $(uname) in
    Linux) copy="xclip -i"; paste="xclip -o" ;;
    Darwin)  copy="pbcopy"; paste="pbpaste" ;;
  esac

  printf "map global user -docstring 'paste (after) from clipboard' p '!%s<ret>'\n" "$paste"
  printf "map global user -docstring 'paste (before) from clipboard' P '<a-!>%s<ret>'\n" "$paste"
  printf "map global user -docstring 'yank to clipboard' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy"
  printf "map global user -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
}

# Commands to fix whitespace
# - clear whitespace before newlines
# - replace tabs with spaces
define-command -params 0 -docstring %{
    clear all whitespace before newlines in the current file
} whitespace-clear %{
  try %{
    # this is an attempt at clearing all whitespace except that on the current line
    execute-keys -draft <a-x> '"' a y <a-h> <a-h> Z '%' s \h+$ <ret> d z <a-x> '"' a R
    execute-keys -draft '%' s\h+$ <ret> d
  }
}
define-command -params 0 -docstring %{
  replaces all tabs with spaces in the current file
} tabs-to-spaces %{
  try %{
    execute-keys -draft '%' s \t <ret> c <tab>
  }
}

# Remap user mode from , to <space>
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

# Use plugin manager (plug.kak)
# Keeping the plug.kak repo inside the plugins directory allows
# plug.kak to update itself like it would normal plugins
source "%val{config}/plugins/plug.kak/rc/plug.kak"
# Fuzzy finder plugin
plug "andreyorst/fzf.kak" %{
  map global user f ": fzf-mode<ret>" -docstring "enter fzf mode"
  map global user t ": fzf-mode<ret>f" -docstring "enter fzf file finder"
}

