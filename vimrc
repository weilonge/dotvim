syntax on
set background=dark
if (&t_Co == 256)
  function! _256ColorHighlights() abort
    highlight LineNr ctermfg=239
  endfunction
  augroup _8ColorScheme
    autocmd!
    autocmd ColorScheme * call _256ColorHighlights()
  augroup END
  colorscheme hybrid
elseif (&t_Co == 16)
  colorscheme noctu
elseif (&t_Co == 8)
  function! _8ColorHighlights() abort
    highlight CursorLine ctermbg=0
    highlight ColorColumn ctermbg=0
  endfunction
  augroup _8ColorScheme
    autocmd!
    autocmd ColorScheme * call _8ColorHighlights()
  augroup END
  colorscheme jellybeans
endif

set backspace=indent,eol,start
set tabstop=2           " number of visual spaces per TAB
set shiftwidth=2
set expandtab           " tabs are spaces
" set autoindent
set number              " show line numbers
set showcmd             " show command in bottom bar
if !filereadable(expand('~/.lowprofile'))
  set cursorline          " highlight current line
endif
set showmatch           " highlight matching [{()}]
set wildmenu            " visual autocomplete for command menu

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set autoread

set hidden

if exists('+clipboard')
  set clipboard^=unnamed,unnamedplus
endif

let mapleader = ","

" Toggle line numbers and fold column for easy copying:
" nnoremap <C-N><C-N> :set invnumber<CR>

" Toggle relative line number
" nnoremap <C-L><C-L> :set invrelativenumber<CR>

" Toggle paste mode or easy pasting:
nnoremap <C-P><C-P> :set invpaste<CR>

"==== OverLength 80 ====
if exists('+colorcolumn')
  set colorcolumn=80
else
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"==== vim-plug ====
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Need to install fzf with git:
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
"
" Then apply :PlugInstall in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }

Plug 'pangloss/vim-javascript', {'for': ['js', 'jsm', 'html', 'xml', 'css', 'json', 'jsx']}
Plug 'mxw/vim-jsx'

Plug 'jelera/vim-javascript-syntax'
" othree's syntax is better than jelera's for me.
" However, the syntax of yajs is broken with arrow function.
" Plug 'othree/yajs.vim'

Plug 'othree/javascript-libraries-syntax.vim'

Plug 'maksimr/vim-jsbeautify', {'on': ['DontLoadMe']} " Workaround to prevent loading.
call plug#end()

"==== fzf ====
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

"==== vim-gitgutter ====
" preview, stage, and revert hunks with <leader>hp, <leader>hs, and <leader>hr
" nmap <F2> <Plug>GitGutterPrevHunk
" nmap <F10> <Plug>GitGutterNextHunk
if !filereadable(expand('~/.lowprofile'))
  set updatetime=200
else
  set updatetime=750
endif

"==== vim-javascript ====
let g:javascript_plugin_jsdoc = 1

"==== vim-airline ====
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_theme='cobalt2'

"==== vim-session ====
let g:session_autosave = 'no'

"==== vim-gitgutter ====
if exists('+signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

"==== Trailing White Spaces ====
" usage: :call StripTrailingWhitespace()
function! StripTrailingWhitespace() abort
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
augroup AutoStripTrailingSpace
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespace()
augroup END

"==== window switch ====
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

"==== buffer switch ====
nnoremap <silent> <leader>n :bprev<CR>
nnoremap <silent> <leader>m :bnext<CR>
