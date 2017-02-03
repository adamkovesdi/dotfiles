nmap j gj
nmap k gk

set nocompatible
set hidden

set smartindent
set tabstop=2
set shiftwidth=2
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}
set laststatus=2
set ignorecase smartcase
" set undoreload=0
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set incsearch

inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

" set list
" hi NonText ctermfg=7 guifg=gray
" hi SpecialKey ctermfg=7 guifg=gray

function! Writemode()
	if has("gui_macvim")
		set gfn=Menlo:h13
	endif
	setlocal norelativenumber
	setlocal nu
	setlocal linebreak
	setlocal formatoptions+=1
	" should only do this in GUI
	set lines=44
	set columns=140
	if filereadable("session.vim")
		so session.vim
	endif
endfunction

function! ClearUndo()
    let choice = confirm("Clear undo information?", "&Yes\n&No", 2)
    if choice == 1
        let old_undolevels = &undolevels
        set undolevels=-1
        exe "normal a \<Bs>\<Esc>"
        let &undolevels = old_undolevels
        echo "done."
    endif
endfunction
cabbrev cu call ClearUndo()

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
  " if exists("+lines")
    " set lines=50
  " endif
  " if exists("+columns")
    " set columns=100
  " endif
	set background=dark
endif

" set relativenumber
" set showtabline=2
" set guioptions-=e
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


let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

