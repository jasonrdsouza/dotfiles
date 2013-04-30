#
# Setup RVM to work with fish shell 
#

function rvm -d 'Ruby enVironment Manager'
  # run RVM and capture the resulting environment
  set -l env_file (mktemp -t rvm.fish.XXXXXXXXXX)
  bash -c 'source ~/.rvm/scripts/rvm; cd .;rvm "$@"; status=$?; env > "$0"; exit $status' $env_file $argv

  # apply rvm_* *PATH RUBY_* GEM_* variables from the captured environment
  and eval (grep '^rvm\|^[^=]*PATH\|^RUBY_\|^GEM_' $env_file |grep -v _clr| sed '/^[^=]*PATH/y/:/ /; s/^/set -xg /; s/=/ /; s/$/ ;/; s/(//; s/)//')

  # clean up
  rm -f $env_file
end
