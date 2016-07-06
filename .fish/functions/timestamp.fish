#
# Convert a unix timestamp (in seconds or milliseconds) to a DateTime
#

function timestamp --description "Convert timestamp to human readable format"
    command date -r (python -c "import sys; sys.stdout.write(str($argv[1] if $argv[1] < 9000000000 else $argv[1] / 1000))")
end

