execute pathogen#infect()
filetype plugin indent on

" In Linux, make sure these lines are added into ~/.bashrc:
" if [[ "$TERM" =~ "term" ]]; then
"   export TERM="xterm-256color"
" fi
"
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
set background=dark
syntax on
" If there is any trouble about using 256-color theme, use this line instead:
" colorscheme noctu
colorscheme hybrid

set number
set backspace=indent,eol,start
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
" Need to install fzf with git:
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
"
" Then apply :PlugInstall in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'pangloss/vim-javascript'
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

"==== vim-javascript ====
let g:javascript_plugin_jsdoc = 1

"==== vim-airline ====
set laststatus=2
let g:airline_powerline_fonts = 1

