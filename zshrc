# Set up the prompt
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
bindkey "^?" backward-delete-char

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.history

# PATH
export PATH=~/bin:$PATH

# Use modern completion system
autoload -Uz compinit
compinit

# liquidprompt
[[ $- = *i* ]] && source ~/.dotfiles/liquidprompt/liquidprompt

# OS specific aliases
case "$OSTYPE" in
  linux*)
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
		alias ls='ls --color=auto'

		alias duh="du -h -d 1 | sort -h"
		alias nocaps="setxkbmap -option ctrl:nocaps"
		
		eval "$(dircolors -b)"
		;;
	darwin*)
		alias ls='ls -G'
		function ff { osascript -e 'tell application "Finder"'\
			-e "if (${1-1} <= (count Finder windows)) then"\
				-e "get POSIX path of (target of window ${1-1} as alias)"\
				-e 'else' -e 'get POSIX path of (desktop as alias)'\
				-e 'end if' -e 'end tell'; };

		function cdff { cd "`ff $@`"; };
		;;
esac

# aliases
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias ll="ls -alh"
alias l="ls -CF1"
alias rs="rsync -av --progress"
alias httpd="sudo python -m SimpleHTTPServer 80"
alias termproxy=". ~/bin/termproxy"

# ZSH completion config
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

