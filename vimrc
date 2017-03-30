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

set backspace=indent,eol,start
set tabstop=2           " number of visual spaces per TAB
set shiftwidth=2
set expandtab           " tabs are spaces
" set autoindent
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set wildmenu            " visual autocomplete for command menu

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

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
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"==== vim-plug ====
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

" Need to install fzf with git:
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
"
" Then apply :PlugInstall in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }

Plug 'pangloss/vim-javascript', {'for': ['js', 'jsm', 'html', 'xml', 'css', 'json']}

Plug 'maksimr/vim-jsbeautify', {'on': ['DontLoadMe']} " Workaround to prevent loading.
call plug#end()

if executable('fzf')
  " FZF {{{
  " <C-p> or <C-t> to search files
  " nnoremap <silent> <C-t> :FZF -m<cr>
  nnoremap <silent> <C-p> :FZF -m<cr>

  " <M-p> for open buffers
  " nnoremap <silent> <M-p> :Buffers<cr>

  " <M-S-p> for MRU
  " nnoremap <silent> <M-S-p> :History<cr>

  " Use fuzzy completion relative filepaths across directory
  " imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with q:
  " command! CmdHist call fzf#vim#command_history({'right': '40'})
  " nnoremap q: :CmdHist<CR>

  " Better search history
  " command! QHist call fzf#vim#search_history({'right': '40'})
  " nnoremap q/ :QHist<CR>

  " command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
  " }}}
else
  " CtrlP fallback
end

"==== Syntastic ====
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

"==== Mozilla Firefox ====
" Apply this command to setup eslint in m-c
" $ ./mach eslint --setup
" Need to add these two lines in ~/.bash_profile:
" export MOZILLA_SRC_ROOT=/path/to/gecko
" export MOZILLA_SRC_ROOT_PREFIX=/gecko/
"
autocmd FileType javascript,html
   \ if stridx(expand("%:p"), $MOZILLA_SRC_ROOT_PREFIX) != -1 |
   \    let b:syntastic_mode = 'active' |
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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"==== vim-session ====
let g:session_autosave = 'no'

"==== window switch ====
:nmap <silent> <leader>- :wincmd h<CR>
:nmap <silent> <leader>= :wincmd l<CR>
" :nmap <silent> <C-h> :wincmd h<CR>
" :nmap <silent> <C-j> :wincmd j<CR>
" :nmap <silent> <C-k> :wincmd k<CR>
" :nmap <silent> <C-l> :wincmd l<CR>

"==== buffer switch ====
:nmap <silent> <leader>[ :bprev<CR>
:nmap <silent> <leader>] :bnext<CR>
