#
# Print out a specific line in a file
#

function line --description "print out a specific line in a file"
	set lineno $argv[1]
  sed -n "$lineno"p $argv[2..]
end

