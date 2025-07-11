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
  highlight statusline cterm=NONE gui=NONE
  highlight statuslinenc cterm=NONE gui=NONE
  highlight tabline cterm=NONE gui=NONE
  highlight winbar cterm=NONE gui=NONE
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

set noswapfile
set backupdir=~/.vim/.metafile/backup//
set directory=~/.vim/.metafile/swap//
set undodir=~/.vim/.metafile/undo//

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

" Disable mouse support
set mouse=

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Avoid ESC key
" inoremap <Esc> <Nop>

if exists('+clipboard')
  set clipboard^=unnamed,unnamedplus
endif

let mapleader = ","

" Toggle line numbers and fold column for easy copying:
" nnoremap <C-N><C-N> :set invnumber<CR>

" Toggle relative line number
" nnoremap <C-L><C-L> :set invrelativenumber<CR>

" Toggle paste mode or easy pasting:
" nnoremap <C-P><C-P> :set invpaste<CR>

"==== OverLength 80 ====
if exists('+colorcolumn')
  set colorcolumn=80
else
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"==== vim-plug ====
call plug#begin('~/.vim/plugged')

" Disable nerdtree
""" Plug 'scrooloose/nerdtree'
""" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Disable ale since coc is used for code references/definition
" Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'sunaku/vim-dasht'
Plug 'mileszs/ack.vim'
Plug 'weilonge/vim-ydict', { 'do': 'npm install -g ydict.js'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/vimshell.vim'
Plug 'tpope/vim-projectionist'

if bufname() !~# '\.g/\|COMMIT_EDITMSG\|MERGE_MSG\|git-rebase-todo' && exists('$DPRINT_BIN_PATH')
  Plug 'Canva/dprint-vim-plugin'
endif

if filereadable(expand('~/.vim/.enable_copilot'))
  Plug 'github/copilot.vim'
endif

" Need to install fzf with git:
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
"
" Then apply :PlugInstall in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim', {'for': ['js', 'jsm', 'html', 'xml', 'css', 'json', 'jsx', 'ts', 'tsx']}
Plug 'maxmellon/vim-jsx-pretty'

if !filereadable(expand('~/.vim/.disable_coc'))
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'maksimr/vim-jsbeautify', {'on': ['DontLoadMe']} " Workaround to prevent loading.
Plug 'tikhomirov/vim-glsl'
call plug#end()

"==== dprint ====
if bufname() !~# '\.g/\|COMMIT_EDITMSG\|MERGE_MSG\|git-rebase-todo' && exists('$DPRINT_BIN_PATH')
  let g:dprint_dir = expand('$DPRINT_BIN_PATH')
  let g:dprint_format_on_save = 1
endif

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

"==== ack.vim ====
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"==== NERDTree ====
" Map C-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" Open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"==== vim-ydict ====
" Search a word under cursor:
" - search a word
nnoremap <silent> <Leader>d :call YDict([expand('<cword>'), expand('<cWORD>')])<Return>

" Search a word for your selected text:
" - search a word
vnoremap <silent> <Leader>d y:<C-U>call YDict(getreg(0))<Return>

"==== vim-dasht ====
" Search docsets for something you type:
" - search related docsets
nnoremap <Leader>K :Dasht<Space>

" - search ALL the docsets
nnoremap <Leader><Leader>K :Dasht!<Space>

" Search docsets for words under cursor:
" - search related docsets
nnoremap <silent> <Leader>k :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>

" - search ALL the docsets
nnoremap <silent> <Leader><Leader>k :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>

" Search docsets for your selected text:
" - search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" - search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp

" When in C++, also search C, Boost, and OpenGL:
let g:dasht_filetype_docsets['cpp'] = ['^c$', 'boost', 'OpenGL']

" When in html/js/jsx/css, also search JavaScript, CSS, React and HTML:
let g:dasht_filetype_docsets['html'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['js'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['ts'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['typescript'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['jsx'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['tsx'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['css'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']

"==== plugin/bclose.vim ====
nnoremap <Leader>q :Bclose<CR>

"==== vim-gitgutter ====
" preview, stage, and revert hunks with <leader>hp, <leader>hs, and <leader>hr
" nmap <F2> <Plug>GitGutterPrevHunk
" nmap <F10> <Plug>GitGutterNextHunk
if !filereadable(expand('~/.lowprofile'))
  set updatetime=200
else
  set updatetime=750
endif

if exists('+signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Fix the foreground color after this commit:
" commit fd834e48eed21cc3c3ab66779a2296a16f41cbca
" Author: Andy Stewart <boss@airbladesoftware.com>
" Date:   Mon Feb 4 14:45:58 2019 +0000
highlight GitGutterDelete ctermfg=1

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
let g:airline_theme='luna'

"==== vim-session ====
let g:session_autosave = 'no'

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

"==== UTF-8 Encoding ====
if has("multi_byte")
  " if &termencoding == ""
  "   let &termencoding = &encoding
  " endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"==== window switch ====
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

"==== buffer switch ====
nnoremap <silent> <leader>n :bprev<CR>
nnoremap <silent> <leader>m :bnext<CR>

"==== coc.vim ====
if !filereadable(expand('~/.vim/.disable_coc'))
  source ~/.vim/configs/coc.vim
endif

function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

function LoadLocalVimrc() abort
  let current = FindSessionDirectory()
  while ((current != '.') && (current != '/'))
    let localvimrc = current . '/.localvimrc'
    if filereadable(localvimrc)
      execute 'source' localvimrc
      return
    endif
    let current = fnamemodify(current, ':h')
  endwhile
endfunction
call LoadLocalVimrc()
