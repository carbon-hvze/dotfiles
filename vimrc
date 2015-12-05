set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive' 
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'wlangstroth/vim-racket'
" Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

colorscheme jellybeans

" bind ctrl-movement keys to buffers switching

map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

nmap <C-\> :NERDTreeFind<CR>

imap <Tab> <Esc>

