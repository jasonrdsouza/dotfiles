#
# Helper functionality to deal with my custom vault
#

function vault --description "Manipulate vault files"
  switch $argv[1]
  case 'unlock'
    age --decrypt $argv[2] | tar --extract --gzip -
  case 'lock'
    set baseName (string trim --chars='/' $argv[2])
    tar --create --gzip $argv[2] | age --encrypt --passphrase > $baseName.tar.gz.age
  case '*'
    echo "Unknown command"
  end
end

