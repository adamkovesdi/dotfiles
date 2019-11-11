#!/bin/bash

echo
echo "This will create dotfile symlinks in home directory"
echo "your dotfiles directory shoud be ~/.dotfiles otherwise this script will fail".
echo
echo "Press ENTER to continue Ctrl+C to abort"
read

ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc

ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

ln -s ~/.dotfiles/inputrc ~/.inputrc

ln -s ~/.dotfiles/Xresources ~/.Xresources

echo
echo "Completed. If you got File exists errors you already have dotfiles in place. Try deleting first."
