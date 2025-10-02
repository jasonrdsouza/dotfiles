#
# Check whether CORS is enabled for the given host and origin
#

function checkCors --description "Usage: checkCors <host> <origin>"
  if test (count $argv) -ne 2
    echo "Usage: checkCors <host> <origin>"
    return 1
  end

  set host $argv[1]
  set origin $argv[2]

  curl -v -X OPTIONS \
        -H "Origin: $origin" \
        -H "Access-Control-Request-Method: GET" \
        -H "Access-Control-Request-Headers: Content-Type" \
        $host
end

