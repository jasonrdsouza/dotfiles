#!/bin/bash
#
# Setup dotfile symlinks
#


# Fish
rm -rf ~/.config/fish/functions
ln -s ~/dotfiles/.fish/functions ~/.config/fish/functions
rm ~/.config/fish/config.fish
ln -s ~/dotfiles/.fish/config.fish ~/.config/fish/config.fish

# Vim
rm ~/.vimrc
ln -s ~/dotfiles/.vimrc ~/.vimrc

# Neovim
rm ~/.config/nvim/init.lua
ln -s ~/dotfiles/neovim/init.lua ~/.config/nvim/init.lua

# Kakoune
rm ~/.config/kak/kakrc
ln -s ~/dotfiles/kakrc ~/.config/kak/kakrc

# Pry
rm ~/.pryrc
ln -s ~/dotfiles/.pryrc ~/.pryrc

# IRB
rm ~/.irbrc
ln -s ~/dotfiles/.irbrc ~/.irbrc

# Git
rm ~/.gitconfig
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
rm ~/.gitignore_global
ln -s ~/dotfiles/.gitignore ~/.gitignore_global

# Ack
rm ~/.ackrc
ln -s ~/dotfiles/.ackrc ~/.ackrc

# Sqsh
rm ~/.sqshrc
ln -s ~/dotfiles/.sqshrc ~/.sqshrc

# Redshift
rm ~/.config/redshift.conf
ln -s ~/dotfiles/redshift.conf ~/.config/redshift.conf

# Sqlite
rm ~/.sqliterc
ln -s ~/dotfiles/.sqliterc ~/.sqliterc

# Tmux
rm ~/.tmux.conf
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# Hammerspoon
rm -rf ~/.hammerspoon
ln -s ~/dotfiles/.hammerspoon ~/.hammerspoon

