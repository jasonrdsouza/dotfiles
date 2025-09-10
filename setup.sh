#!/bin/bash
#
# Setup dotfile symlinks
#


# Fish
mkdir -p ~/.config/fish
rm -rf ~/.config/fish/functions
ln -s ~/dotfiles/fish/functions ~/.config/fish/functions
rm ~/.config/fish/config.fish
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish

# Alacritty
rm -rf ~/.config/alacritty
ln -s ~/dotfiles/alacritty ~/.config/alacritty

# Neovim
mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.lua
ln -s ~/dotfiles/neovim/init.lua ~/.config/nvim/init.lua

# Zed
mkdir -p ~/.config/zed
rm ~/.config/zed/settings.json
ln -s ~/dotfiles/zed/settings.json ~/.config/zed/settings.json

# Kakoune
mkdir -p ~/.config/kak
rm ~/.config/kak/kakrc
ln -s ~/dotfiles/kakrc ~/.config/kak/kakrc

# OpenCode
rm -rf ~/.config/opencode
ln -s ~/dotfiles/opencode ~/.config/opencode

# Pry
rm ~/.pryrc
ln -s ~/dotfiles/pryrc ~/.pryrc

# IRB
rm ~/.irbrc
ln -s ~/dotfiles/irbrc ~/.irbrc

# Git
rm ~/.gitconfig
ln -s ~/dotfiles/gitconfig ~/.gitconfig
rm ~/.gitignore_global
ln -s ~/dotfiles/gitignore ~/.gitignore_global

# Ack
rm ~/.ackrc
ln -s ~/dotfiles/ackrc ~/.ackrc

# Redshift
rm ~/.config/redshift.conf
ln -s ~/dotfiles/redshift.conf ~/.config/redshift.conf

# Sqlite
rm ~/.sqliterc
ln -s ~/dotfiles/sqliterc ~/.sqliterc

# Tmux
rm ~/.tmux.conf
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# Hammerspoon
rm -rf ~/.hammerspoon
ln -s ~/dotfiles/hammerspoon ~/.hammerspoon

