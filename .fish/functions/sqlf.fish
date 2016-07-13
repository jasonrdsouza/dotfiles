#
# Autoformat the provided sql file.
# Writes result to STDOUT
#

function sqlf --description "Autoformat the provided sql file"
	command sqlformat --reindent $argv[1]
end

