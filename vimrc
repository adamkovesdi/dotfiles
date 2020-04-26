"
" .vimrc of adamkov
" last major rewrite 2017.11.17.
" restructuring 2019.11.11.

"######################## Generic ########################## 

set nocompatible			" No old vi behaviour pls.
set hidden						" Abandoned buffer becomes hidden 
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set smartindent				" autoindent follows current style
set tabstop=2					" tab width is 2 spaces
set shiftwidth=2			" effect of >> indentation

set ignorecase smartcase " unless capital letters in search ignorecase
set sessionoptions-=options	" don't store glob/loc vals in session file
set incsearch					" inclremental search as you type
set linebreak					" only wrap at breakoption chars (e. nl,)

set nobackup					" no ackup files
set nowritebackup			" do not write backup files
set noswapfile				" no swapping
let g:netrw_dirhistmax=0 "no history file

"######################## Looks ########################## 

set number					" line numbering
set relativenumber	" relative line numbering for jumps
set cursorline			" highlight the line with cursor

set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}
set laststatus=2			" always show status line

" New splits below and to the right (:vs, :sp commands)
set splitright			" new split position
set splitbelow			" new split position

if has("gui_running")
  set lines=40 columns=100
	set background=dark
	colorscheme adamkov
else
	set background=dark
	colorscheme wal
endif

"######################## Plugins ########################## 

if filereadable(expand("~/.vim/autoload/pathogen.vim"))
" Pathogen framework launcher
" silent! execute pathogen#infect()
	runtime! autoload/pathogen.vim
	if exists("g:loaded_pathogen")
		execute pathogen#infect()
	endif
endif

" tslime enabler
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

"######################## Colors ########################## 

" set t_Co=256
set t_ut= 
colorscheme adamkov

"######################## Custom funcs  ########################## 

if filereadable("./session.vim")
	" restore session if available
	so session.vim
endif

function! ClearUndo()
    let choice = confirm("Clear undo information?", "&Yes\n&No", 2)
    if choice == 1
        let old_undolevels = &undolevels
        set undolevels=-1
				m-1
        let &undolevels = old_undolevels
        echo "done."
    endif
endfunction
cabbrev cundo call ClearUndo() 

function! PythonDev()
    " Enable folding
    set foldmethod=indent
    set foldlevel=99
    " Fold/unfold with space
    nnoremap <space> za
    " Python formatting
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
    set encoding=utf-8
    syntax on
    let g:netrw_chgwin=winnr()
    let g:netrw_winsize=20
endfunction
cabbrev pydev call PythonDev()

"######################## Keybindings ########################## 

nmap j gj
nmap k gk
" Buffer navigation Ctrl+H Ctrl+L
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

" copy buffer to system clipboard
map <F1> :%y+<CR>
" copy current line to system clipboard
map <F2> :normal0"+y$<CR>
" F12 calls GNU make (buildshortcut)
map <F12> :make<CR>

" map leader key to comma
let mapleader = ","

" send current selection to tmux
vmap <Leader><Enter> <Plug>SendSelectionToTmux
nmap <Leader>? <Plug>SetTmuxVars
" remove empty lines from buffer
nmap <Leader>l :g,^\s*$,d<Enter>
" yank current line to system clipboard
nmap <Leader>c "+yy
" reformat using uncrustify
nmap <Leader>i :%!uncrustify -c ~/.dotfiles/uncrustify.cfg -q<CR>

"######################## Autocommands ########################## 

" autoload previously saved folds
autocmd BufWinEnter *.* silent loadview 

" autocommand to set programming mode for filetypes
au FileType ruby setl ai ts=2 sts=2 et sw=2
au FileType sh setl ai ts=2 sts=2 et sw=2
au FileType python call PythonDev()

