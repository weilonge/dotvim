execute pathogen#infect()
syntax on
filetype plugin indent on
set background=dark
colorscheme hybrid

set number
set tabstop=2
set shiftwidth=2
set showcmd
set expandtab
" set autoindent

" for gitgutter
" github.com/airblade/vim-gitgutter
" preview, stage, and revert hunks with <leader>hp, <leader>hs, and <leader>hr
" nmap <F2> <Plug>GitGutterPrevHunk
" nmap <F10> <Plug>GitGutterNextHunk

" Toggle line numbers and fold column
" for easy copying:
nmap <C-N><C-N> :set invnumber<CR>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

call plug#begin('~/.vim/plugged')
" Need to install fzf with Homebrew: brew install fzf
Plug '/usr/local/opt/fzf'
call plug#end()

