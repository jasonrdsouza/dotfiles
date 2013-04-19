#
# Setup dotfile symlinks
#


# Fish
rm -rf ~/.config/fish/functions
ln -s ~/dotfiles/.fish/functions ~/.config/fish/functions
rm -rf ~/.config/fish/completions
ln -s ~/dotfiles/.fish/completions ~/.config/fish/completions
rm ~/.config/fish/config.fish
ln -s ~/dotfiles/.fish/config.fish ~/.config/fish/config.fish

# Bash

# Vim
rm ~/.vimrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
rm -rf ~/.vim
ln -s ~/dotfiles/.vim ~/.vim

# Pry

# IRB
rm ~/.irbrc
ln -s ~/dotfiles/.irbrc ~/.irbrc
