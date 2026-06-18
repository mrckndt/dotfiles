call plug#begin('~/.config/nvim/plugins')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox', { 'tag': 'v3.0.1-rc.0' }
Plug 'LnL7/vim-nix'
call plug#end()

if ($TERM=~"xterm-256color" || $TERM=~"screen-256color")
  let g:gruvbox_contrast_dark = "soft"
  colorscheme gruvbox
endif

filetype plugin indent on

let g:markdown_fenced_languages = ['python', 'bash=sh', 'go', 'c', 'cpp', 'yaml', 'json', 'sql', 'haskell']

set autowrite
set expandtab
set ignorecase
set laststatus=2
set linebreak
set list listchars=tab:▸\ ,trail:·
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set number
set shiftwidth=2
set showbreak=↪\
set splitbelow
set splitright
set statusline=\(%n\)\ %<%.99f\ %y\ %w%m%r%=%-14.(%l,%c%V%)\ %P
set textwidth=140
set wrapscan

" fzf mappings
nnoremap <silent> <C-g> :GFiles?<CR>
nnoremap <silent> <C-m> :Buffers<CR>
nnoremap <silent> <C-o> :Files<CR>
nnoremap <silent> <C-q> :Bd<CR>
nnoremap <silent> <C-s> :Rg<CR>

nnoremap <silent> <esc><esc> :nohls<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" https://github.com/neovim/neovim/pull/13268
unmap Y

function! s:StripTrailing()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

" helper functions and command for `:bd` in fzf
function! s:ListBuffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:DeleteBuffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! Bd call fzf#run(fzf#wrap({
  \ 'source': s:ListBuffers(),
  \ 'sink*': { lines -> s:DeleteBuffers(lines) },
  \ 'options': '--multi --bind ctrl-a:select-all+accept --prompt "Bd> "'
\ }))

augroup vimrc
  autocmd!
  autocmd BufWritePre * call s:StripTrailing()
  autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
  autocmd FileType go setlocal noexpandtab sw=8

  " https://neovim.io/doc/user/options.html#'updatetime'
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime

  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END
