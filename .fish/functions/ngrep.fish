#
# Add useful command line flags to grep
# - line numbers on
# - ignore case
#
function ngrep --description "Search through a file"
	command grep -n -i $argv
end
