nmap j gj
nmap k gk

set nocompatible
set hidden
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

imap jk <Esc>
set timeout
set timeoutlen=100
 
set smartindent
set tabstop=2
set shiftwidth=2
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}
set laststatus=2
set ignorecase smartcase
" set undoreload=0
set ssop-=options    " do not store global and local values in a session
" set ssop-=folds      " do not store folds
set incsearch

" colors
set t_Co=256
set t_ut= 

inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

function! Writemode()
	if has("gui_macvim")
		" should only do this in MacVIM GUI
		set gfn=Menlo:h13
		set lines=44
		set columns=140
		setlocal norelativenumber
		setlocal nu
		setlocal linebreak
		setlocal formatoptions+=1
		if filereadable("./session.vim")
			so session.vim
		endif
	else
		call Progmode()
	endif
endfunction

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

map <F6> :call Writemode()<CR>
" copy buffer to system clipboard
map <F1> :%y+<CR>
" copy current line to system clipboard
map <F2> :normal0"+y$<CR>

cabbrev wmode call Writemode()

map <F12> :make flash<CR>

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=33 columns=100
	set background=light
else
  " This is console Vim.
	set background=dark
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let mapleader = ","

vmap <Leader><Enter> <Plug>SendSelectionToTmux
nmap <Leader>l :g,^\s*$,d<Enter>
nmap <Leader>c "+yy 

" PRIVACY SETTINGS (no backups, swap files, or viminfo)
" You can comment out this section and add the following to your ".profile":
" alias mvim_private="mvim -i NONE --cmd 'set noswapfile' --cmd 'set nobackup' --cmd 'set noautowrite'"
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

