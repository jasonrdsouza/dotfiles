#
# Autoformat the provided sql, read from STDIN.
# Writes result to STDOUT.
# Usage: pbpaste | sqlf
#

function sqlf --description "Autoformat the provided sql"
	command sqlformat --reindent -
end

