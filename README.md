# dotfiles

This is my personal dotfiles library with automatic symlink deployer script  
Universal Linux/Solaris/Mac compatible  
Contents: vim, zsh, tmux configs  
![screenshot](https://i.imgur.com/4AINDxR.png)

## vim

Lightweight vim config  
Custom functions Writemode and Progmode for respective writing tasks  
[apprentice](https://github.com/romainl/Apprentice) color scheme by romainl

Minimal plugin set:
- buftabline https://github.com/ap/vim-buftabline
- ctrlp https://github.com/kien/ctrlp.vim
- tslime https://github.com/jgdavey/tslime.vim

buftabline is hard baked, the others are linked to this repository through git submodules

## zsh

Please no oh-my-zsh for me. No rainbow colors and fancy Unicode characters, I am a grown up  
Low profile no frills to run smoothly on inferior performance systems (Raspberry Pi, etc.)  
Few aliases and some autocomplete directives  

Custom minimal zsh prompt  
- hostname
- current directory without full path
- return code, hidden if zero
- privilege indicator % or #
```
RPROMPT='%T'
```
if you need time on the right side of the prompt

## tmux

Ctrl-A as prefix  
History, save history facility  
Able to receive input from vim through tslime plugin  

## Usage

Clone repository then run createsymlinks.sh
```
git clone https://github.com/adamkovesdi/dotfiles
mv dotfiles ~/.dotfiles
cd ~/.dotfiles
./createsymlinks.sh
```


