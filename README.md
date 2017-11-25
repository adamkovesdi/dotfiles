# dotfiles

This is my personal dotfiles library with automatic link deployer shell script  
Contents: vim, zsh, tmux configs
![screenshot](https://i.imgur.com/4AINDxR.png)

## vim

Lightweight vim config  
Custom functions Writemode and Progmode for respective writing tasks  
[apprentice](https://github.com/romainl/Apprentice) color scheme by romainl

Minimal plugin set:
- buftabline
- ctrlp
- tslime

## zsh

Low profile no frills to run smoothly on low performance systems (Raspberry Pi, etc.)  
Few aliases and some autocomplete directives  

Custom minimal zsh prompt  
- hostname
- directory (depth: 1)
- return code (hidden if 0)
- root privilege indicator

## tmux

Ctrl-A as prefix  
History, save history facility  
Able to receive input from vim through tslime plugin  

## Usage

Clone repository then
```
mv dotfiles .dotfiles
cd .dotfiles
./createsymlinks.sh
```


