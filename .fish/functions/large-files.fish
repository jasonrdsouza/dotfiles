#
# Command to find the largest files in a given folder
#

function large-files --description "Find the largest files in the current directory"
	command du -hsx * | sort -rh | head -n $argv[1]
end

