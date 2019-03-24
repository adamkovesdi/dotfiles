"
" .vimrc of adamkov
" last major rewrite 2017.11.17.
"

" traverse wrapped lines
nmap j gj
nmap k gk

set nocompatible			" No old vi behaviour pls.
set hidden						" Abandoned buffer becomes hidden 
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set smartindent
set tabstop=2
set shiftwidth=2
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}
set laststatus=2
set ignorecase smartcase
set ssop-=options    " do not store global and local values in a session
set incsearch
set linebreak

" New splits below and to the right (:vs, :sp commands)
set splitright
set splitbelow

" colors
set t_Co=256
set t_ut= 

" kill F1 key functions
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" buffer navigation shortcuts for me
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

if has("gui_running")
  set lines=40 columns=100
	set background=light
else
	set background=dark
endif

function! Writemode()
	if has("gui_macvim") " should only do this in MacVIM GUI
		set guifont=Menlo:h13
	else " I suppose Linux then 
		set guifont=Monospace\ 13
	endif
	set lines=44
	set columns=140
	setlocal norelativenumber
	setlocal nu
	if filereadable("./session.vim")
		so session.vim
	endif
endfunction
cabbrev wm call Writemode() 

function! Progmode()
	set number
	set relativenumber
	set cul
	colorscheme apprentice
	if !has("gui_macvim")
		hi Normal ctermbg=Black
	endif
	if filereadable("./session.vim")
		so session.vim
	endif
endfunction
cabbrev pmode call Progmode() 

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

" change to Programmer mode
map <F6> :call Progmode()<CR>
" copy buffer to system clipboard
map <F1> :%y+<CR>
" copy current line to system clipboard
map <F2> :normal0"+y$<CR>
" make shortcut for F12
map <F12> :make<CR>

" map leader key to comma
let mapleader = ","

" send current selection to tmux
vmap <Leader><Enter> <Plug>SendSelectionToTmux
" remove empty lines from buffer
nmap <Leader>l :g,^\s*$,d<Enter>
" yank current line to system clipboard
nmap <Leader>c "+yy
" reformat using uncrustify
nmap <Leader>i :%!uncrustify -c ~/.dotfiles/uncrustify.cfg -q<CR>

" PRIVACY SETTINGS (no backups, swap files, or viminfo)
set nobackup
set nowritebackup
set noswapfile
" set viminfo="NONE"

" Pathogen framework launcher
" silent! execute pathogen#infect()
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
	runtime! autoload/pathogen.vim
	if exists("g:loaded_pathogen")
		execute pathogen#infect()
	endif
endif

" autoload folds
autocmd BufWinEnter *.* silent loadview 

" tslime enabler
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

" autocommand to set programming mode
au FileType ruby setl ai ts=2 sts=2 et sw=2 | call Progmode()
au FileType sh setl ai ts=2 sts=2 et sw=2 | call Progmode()
au FileType tex call Progmode()
au FileType python call PythonDev()

call Progmode()
