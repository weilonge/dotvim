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

"==== gitgutter ====
" for gitgutter
" github.com/airblade/vim-gitgutter
" preview, stage, and revert hunks with <leader>hp, <leader>hs, and <leader>hr
" nmap <F2> <Plug>GitGutterPrevHunk
" nmap <F10> <Plug>GitGutterNextHunk

" Toggle line numbers and fold column
" for easy copying:
nmap <C-N><C-N> :set invnumber<CR>

"==== OverLength 80 ====
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"==== vim-plug ====
call plug#begin('~/.vim/plugged')
" Need to install fzf with Homebrew: brew install fzf
Plug '/usr/local/opt/fzf'
call plug#end()

"==== Mozilla Firefox ====
" Need to add these two lines in ~/.bash_profile:
" export MOZILLA_SRC_ROOT=/path/to/gecko
" export MOZILLA_SRC_ROOT_PREFIX=/gecko/
"
autocmd FileType javascript,html
   \ if stridx(expand("%:p"), $MOZILLA_SRC_ROOT_PREFIX) != -1 |
   \    let b:syntastic_checkers = ['eslint'] |
   \    let b:syntastic_eslint_exec = $MOZILLA_SRC_ROOT . "/tools/lint/eslint/node_modules/.bin/eslint" |
   \    let b:syntastic_html_eslint_args = ['--plugin', 'html'] |
   \ endif

autocmd BufRead,BufNewFile *.jsm set filetype=javascript

