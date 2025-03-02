#
# Utility function to allow updating vim with vundle
# necessary since vundle depends on bourne shell compliance
#

function updatevim --description "Utility function to update vim"
  set SHELL (which sh)
  vim +BundleInstall! +BundleClean +qall
  set SHELL (which fish)
end
