" The Arch Linux global vimrc - setting only a few sane defaults
"
" DO NOT EDIT THIS FILE. IT'S OVERWRITTEN UPON UPGRADES.
"
" Use /etc/vimrc for system-wide and $HOME/.vimrc for personal configuration
" (for details see ':help initialization').
"
" Use :help '<option>' to see the documentation for the given option.

" Use Vim defaults instead of 100% vi compatibility
" Avoid side-effects when nocompatible has already been set.
source $VIMRUNTIME/defaults.vim
set mouse-=a

if &compatible
  set nocompatible
endif

set backspace=indent,eol,start
set ruler
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj

" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'
" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" automatically compile tex files when saving
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!

" save document keybinds " 
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" save document upon creation (without saving)
:autocmd BufNewFile * :write

" latex word count
autocmd FileType tex noremap <c-a> <Cmd>echom system('texcount -1 ' .. expand('%:p'))<CR>

" perform shellcheck
autocmd FileType sh noremap <c-a> <Cmd>echom system('shellcheck ' .. expand('%:p'))<CR>

" write curent time "
nmap <F3> i<C-R>=strftime("%d/%m/%Y")<CR><Esc>
imap <F3> <C-R>=strftime("%d/%m/%Y")<CR>

" abbreviations
:ab teh the
:ab fro from
:ab jh \en
:ab hj \gr
:ab ξη \en
:ab ηξ \gr

" Greek math for latex
autocmd FileType tex inoremap hm \eta\mu
autocmd FileType tex inoremap syn \sigma\upsilon\nu
autocmd FileType tex inoremap efa \epsilon\phi

" begin and end sections in latex automatically
:noremap \b cw\begin{<C-R>"}<CR>\end{<C-R>"}
" autocomplete common phrases
:noremap \f cw\frac{<C-R>"}{<C-R>"}
" open fff from vim
nnoremap f :F<CR>

" mappings for exiting
inoremap jk <ESC>
inoremap ξκ <ESC>

syntax on " highlight syntax
set number " show line numbers
set noswapfile " disable the swapfile
set hlsearch " highlight all results
set ignorecase " ignore case in search
set incsearch " show search results as you type

" Greek characters
map Α A
map Β B
map Ψ C
map Δ D
map Ε E
map Φ F
map Γ G
map Η H
map Ι I
map Ξ J
map Κ K
map Λ L
map Μ M
map Ν N
map Ο O
map Π P
map Q Q

map Ρ R
map Σ S
map Τ T
map Θ U
map Ω V
map W W
map Χ X
map Υ Y
map Ζ Z
map α a
map β b
map ψ c
map δ d
map ε e
map φ f
map γ g
map η h
map ι i
map ξ j

map κ k
map λ l
map μ m
map ν n
map ο o
map π p
map q q
map ρ r
map σ s
map τ t
map θ u
map ω v
map ς w
map χ x
map υ y
map ζ z
map : :

cab ς w
cab ; q
cab ς; wq



" for wiki
filetype plugin on


"Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
       endif

"       " Run PlugInstall if there are missing plugins
       autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
         \| PlugInstall --sync | source $MYVIMRC
         \| endif


function! TeXWordCount()
	let l:data = g:vimtex#data[b:vimtex.id]
	let l:main_tex_dir = l:data.root
	let l:main_tex_file = l:data.base
	:echo system('cd "' . l:main_tex_dir . '"; texcount "' . l:main_tex_file . '"')
endfunction
nmap <localleader>lw :call TeXWordCount()<cr>

let g:barbaric_default = 0

call plug#begin()
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'dylanaraps/fff.vim'
call plug#end()



