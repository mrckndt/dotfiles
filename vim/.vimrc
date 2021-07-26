if ($TERM=~"xterm-256color" || $TERM=~"screen-256color")
    call plug#begin('~/.vim/plugged')
    Plug 'cormacrelf/vim-colors-github'
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-signify'
    call plug#end()

    colorscheme github
    let g:lightline = { 'colorscheme': 'github' }
    set background=light
    set noshowmode
    set termguicolors
endif

filetype plugin indent on

let g:markdown_fenced_languages = ['python', 'bash=sh', 'go', 'c', 'cpp', 'yaml', 'json', 'sql']

set autoindent
set autoread
set autowrite
set expandtab
set hidden
set ignorecase
set incsearch
set laststatus=2
set linebreak
set list listchars=trail:·,tab:▸\ ,eol:¬
set mouse=a
set nofoldenable
set nojoinspaces
set number
set printoptions=paper:A4,syntax:n,number:y
set shiftwidth=4
set showbreak=↪\
set splitbelow
set splitright
set statusline=\(%n\)\ %<%.99f\ %y%w%m%r%=%-14.(%l,%c%V%)\ %P
set tabstop=4
set textwidth=120
set wrapscan

let mapleader=" "
let maplocalleader=" "

nnoremap <silent> <esc><esc> :nohls<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

"noremap p p`[
"noremap P P`[

augroup vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
    autocmd BufNewFile,BufRead Vagrantfile setlocal filetype=ruby
    autocmd FileType puppet setlocal tw=140
    autocmd FileType bash,zsh,sh,ruby,yaml setlocal sw=2
    autocmd FileType go setlocal noexpandtab sw=8 ts=8

    " restore cursor
    autocmd VimLeave * set guicursor=a:ver90
augroup END
