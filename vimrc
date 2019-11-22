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

"==== OverLength 100 ====
if exists('+colorcolumn')
  set colorcolumn=100
else
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

"==== vim-plug ====
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Disable ale since coc is used for code references/definition
" Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'moll/vim-bbye'
Plug 'sunaku/vim-dasht'
Plug 'mileszs/ack.vim'
Plug 'weilonge/vim-ydict', { 'do': 'npm install -g ydict.js'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/vimshell.vim'

" Need to install fzf with git:
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
"
" Then apply :PlugInstall in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }

Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim', {'for': ['js', 'jsm', 'html', 'xml', 'css', 'json', 'jsx', 'ts', 'tsx']}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'maksimr/vim-jsbeautify', {'on': ['DontLoadMe']} " Workaround to prevent loading.
Plug 'tikhomirov/vim-glsl'
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

"==== ack.vim ====
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"==== NERDTree ====
" Map C-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
let g:dasht_filetype_docsets['jsx'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']
let g:dasht_filetype_docsets['css'] = ['JavaScript', 'CSS', 'React', 'HTML', 'Jest']

"==== bbye ====
nnoremap <Leader>q :Bdelete<CR>

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
let g:airline_theme='cobalt2'

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
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>z  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
