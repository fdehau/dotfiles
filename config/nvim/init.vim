" vim: fdm=marker

" Configure leader key for extra combination
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Plugins {{{

call plug#begin()

" Colorschemes {{{

Plug 'morhetz/gruvbox'
" {{{
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'medium'
nnoremap <Leader>bg :let &background = ( &background == "dark" ? "light" : "dark")<CR>
" }}}

Plug 'junegunn/seoul256.vim'
" {{{
let g:seoul256_background = 235
" }}}

" }}}

" Additional colors {{{

" Display nested parentheses with different colors
Plug 'junegunn/rainbow_parentheses.vim'
" {{{
autocmd VimEnter * :RainbowParentheses<CR>
" }}}

" Display css color codes with the right color
Plug 'ap/vim-css-color'

" }}}

" {{{ Moving around

" Move to a specific word using two letters hints
Plug 'justinmk/vim-sneak'
" {{{
" Quick move
let g:sneak#streak = 1
" }}}

" }}}

" Less typing {{{

" Automatic closing of quotes, parenthesis, brackets,...
Plug 'Raimondi/delimitMate'

" Add wisely end, endif, ... in various languages
Plug 'tpope/vim-endwise'

" }}}

" User Interface {{{

" Highlight trailing whitespaces and remove them with :StripWhitespaces
Plug 'ntpeters/vim-better-whitespace'

" Nice status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
" {{{
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 1
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'tabline': {
      \   'left': [ [ 'buffers' ] ],
      \   'right': [ [ 'close' ] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
" }}}

" Help to manage buffers with a dedicated screen
Plug 'troydm/easybuffer.vim'
" {{{
nnoremap <Leader>b :EasyBuffer <CR>
" }}}

" }}}

" Git integration {{{

" Add git commands to vim
Plug 'tpope/vim-fugitive'

" Commit browser
Plug 'junegunn/gv.vim'

" Prepare commits in a nicer UI
Plug 'jreybert/vimagit', { 'on': ['Magit', 'MagitOnly'] }
" {{{
nnoremap <Leader>gg :Magit<CR>
" }}}

" Display git diff in signs
Plug 'airblade/vim-gitgutter'
" {{{
" Disable realtime features (update on save)
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
" }}}

" }}}

" Lint {{{

Plug 'neomake/neomake'
" {{{
" Call :make asynchronously and provide feedback from different tools
nnoremap <Leader>m :Neomake<CR>
nnoremap <Leader>M :Neomake!<CR>
" Open the location window
nnoremap <Leader>mo :lopen<CR>
" Close the location window
nnoremap <Leader>mk :lclose<CR>
" Current error
nnoremap <Leader>mc :ll<CR>
" Next error
nnoremap <Leader>mn :lnext<CR>
" Previous error
nnoremap <Leader>mp :lprevious<CR>
" }}}

" }}}

" Completion {{{

" Show inline documentation
Plug 'Shougo/echodoc'
" {{{
" Do not open preview window
set completeopt-=preview
let g:echodoc_enable_at_startup = 1
" }}}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" {{{
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-tag'
Plug 'Shougo/neoinclude.vim'
" }}}

" Complete using tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}

" Quick edits {{{

" Quoting / parenthezing made simple
" cs"' to replace " by '
" ds" to remove "
Plug 'tpope/vim-surround'

Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
" {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Comment stuff out
" gcc to comment a line
" gc to comment out target of a motion
" gcap to comment out a paragraph
" gc to comment out in visual mode
Plug 'tpope/vim-commentary'

" Increment sequences of numbers
Plug 'triglav/vim-visual-increment'

" Visually select increasingly larger regions of text
Plug 'terryma/vim-expand-region'

Plug 'mbbill/undotree'
" {{{
" Visualize undos
nnoremap <Leader>u :UndotreeToggle<CR>
" Persistent Undo
set undofile
" Auto create undodir if doesn't exist
let undodir = expand($HOME . '/.config/nvim/backups')
if !isdirectory(undodir)
  call mkdir(undodir, 'p')
endif
let &undodir = undodir
" }}}

" Sublime Text's multiple cursors for Vim
Plug 'terryma/vim-multiple-cursors'
" {{{
" Enable all mode transitions with multiple cursor
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
" Disable completion with multiple cursor
if has_key(g:plugs, 'deoplete.nvim')
  function! Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
  endfunction

  function! Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
  endfunction
endif
" }}}

" Move lines and selection up and down
Plug 'matze/vim-move'
" {{{
let g:move_map_keys = 0
let g:move_auto_indent = 0
vmap <C-Up> <Plug>MoveBlockUp
vmap <C-Down> <Plug>MoveBlockDown
" }}}

" }}}

" Prose writing {{{

Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
" {{{
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
" }}}

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
" {{{
function! s:goyo_enter()
  if exists('$TMUX')
    silent !tmux set status off
  endif
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = '90%'
let g:goyo_height = '90%'

nnoremap <Leader>z :Goyo<CR>
" }}}

" }}}

" Navigation {{{

" Moving in vim as in tmux
Plug 'christoomey/vim-tmux-navigator'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Commands collection based on fzf
Plug 'junegunn/fzf.vim'
" {{{

" Navigate files
nnoremap <Leader>f :Files <CR>
nnoremap <Leader>F :GFiles <CR>
nnoremap <Leader>o :Buffers <CR>
nnoremap <Leader>h :History <CR>

" Search in buffer
nnoremap <Leader>l :BLines <CR>
nnoremap <Leader>L :BLines <C-R><C-W><CR>

" Search in all files
nnoremap <Leader>rg :Rg <C-R><C-W><CR>

" Tags
nnoremap <Leader>t :BTags <CR>
nnoremap <Leader>tt :BTags <C-R><C-W><CR>
nnoremap <Leader>T :Tags <CR>
nnoremap <Leader>TT :Tags <C-R><C-W><CR>

nnoremap <Leader>c :Commands<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
" }}}

" }}}

" Tags {{{
Plug 'ludovicchabant/vim-gutentags'
" }}}

" Langs {{{

Plug 'editorconfig/editorconfig-vim'

Plug 'lervag/vimtex', { 'for': 'tex' }
" {{{
" Handle uncommon extensions
au BufRead,BufNewFile *.cls set filetype=tex
" }}}

" C / C++ {{{

Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'cpp'] }

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" {{{
let g:load_doxygen_syntax = 1
" }}}

function! ClangFormatFile()
  let l:lines="all"
  pyf $CLANG_FORMAT_PY
endfunction

if !empty($CLANG_FORMAT_PY)
  au Filetype c,cpp map <Leader>k :pyf $CLANG_FORMAT_PY<CR>
  au Filetype c,cpp map <Leader>K :call ClangFormatFile()<CR>
endif

" }}}

" Python {{{

Plug 'hdima/python-syntax', { 'for': 'python' }
" {{{
let python_highlight_all = 1
" }}}

Plug 'hynek/vim-python-pep8-indent', { 'for': 'python'}

Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" {{{
let g:deoplete#sources#jedi#show_docstring = 1
" }}}

" }}}

Plug 'othree/html5.vim', { 'for': 'html' }

Plug 'vhda/verilog_systemverilog.vim', { 'for': 'verilog_systemverilog' }
" {{{
autocmd Filetype verilog_systemverilog setl nosmartindent autoindent
" }}}

Plug 'rollxx/vim-antlr', { 'for': 'antlr' }

" Rust {{{

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" {{{
let g:rustfmt_autosave = 0
let g:rustfmt_fail_silently = 1
au Filetype rust map <Leader>k :RustFmt<CR>
" }}}

Plug 'racer-rust/vim-racer', { 'for': 'rust' }
" {{{
let g:racer_cmd = expand($HOME . '/.cargo/bin/racer')
au Filetype rust nmap <Leader>d <Plug>(rust-def)
" }}}

" }}}

" JSON {{{
au FileType json map <Leader>k :!jq .<CR>
au FileType json map <Leader>K :%!jq .<CR>
" }}}

Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'tfnico/vim-gradle', { 'for': 'gradle' }

Plug 'mitsuhiko/vim-jinja', { 'for': 'jinja' }

Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

" Go {{{

Plug 'fatih/vim-go', { 'for': 'go' }
" {{{
autocmd Filetype go setlocal shiftwidth=8 tabstop=8 softtabstop=8
" }}}

" }}}

" Javascript {{{

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" "{{{
let g:javascript_enable_domhtmlcss = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
" }}}

Plug 'mxw/vim-jsx', { 'for': 'javascript' }
" {{{
let g:jsx_ext_required = 0
" }}}

" }}}

Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

Plug 'honza/dockerfile.vim', { 'for': 'dockerfile' }

Plug 'Shougo/neco-vim', { 'for': 'vim' }

" Elixir {{{
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
" }}}

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'mattn/emmet-vim', { 'for': 'html' }

Plug 'lambdatoast/elm.vim', { 'for': 'elm' }

Plug 'robbles/logstash.vim'

" }}}

call plug#end()

call deoplete#custom#option({
\ 'smart_case': v:true,
\ 'max_list': 30,
\ 'omni_patterns': {
\   'go': '[^. *\t]\.\w*'
\ },
\ })
" because of the omni_patterns
set completeopt+=noselect

" }}}

" Settings {{{

" Set how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to autoread when a file is changed from the outside
set autoread

" Show line info on status bar
set ruler
" Disable curso line
set nocursorline

" Line number
set number

" Line width
set colorcolumn=100
set tw=100

" Height of the command line
set cmdheight=2

" A buffer becomes hidden when its abandoned
set hidden

" Enable mouse
if has("mouse")
  set mouse=a
endif

" Ignore case when searching
set ignorecase
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Make replace interactive
set inccommand=split

" Don't redraw while executing macros (good performance config)
set lazyredraw
set ttyfast

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Tab on the command line will show menu to complete buffer an file name
set wildchar=<Tab> wildmenu wildmode=full

" Enable syntax highlighting
syntax enable

" True colors
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if has("termguicolors")
  set termguicolors
endif

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
  set guifont=Fira\ Mono\ 10
endif

colorscheme gruvbox
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Tags
set tags=./tags;$HOME

" *** Text, tab and indent related ***

" No tab in files and all tabs are 4 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set shiftround

" Keep indentation from the previous line
set autoindent
" Automatically inserts indentation in some cases
set smartindent
set breakindent
set cindent
set cinoptions+=N-s
set cinoptions+=:0

set nowrap

" Scrolling
set scrolloff=10
set sidescrolloff=10
set sidescroll=1

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable modline
set modeline

" }}}

" Keys {{{

function! ToggleSyntax()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction

nmap <silent> <Leader>s :call ToggleSyntax()<CR>

" Type <Space>w to save a file
nnoremap <Leader>w :w<CR>
" Type <Space>wq to save a file and exit
nnoremap <Leader>wq :wq<CR>
" Type <Space><Space> to enter visual mode
nnoremap <Leader><Leader> V
xmap <Leader><Leader> <Esc>

" Copy and paste to sytem clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Quick move
nnoremap <S-Left>  b
nnoremap <S-Right> w
nnoremap <S-Up>    10k
nnoremap <S-Down>  10j

" Window navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Buffer navigation
nnoremap <C-Right> :bnext<CR>
nnoremap <C-Left> :bprev<CR>

" Quickly open explore
nnoremap <Leader>e :Explore<CR>

" Remap the ESC in insert mode
inoremap jj <Esc>

" Wrap
command! -nargs=* Wrap set wrap linebreak nolist

" Insert blank lines in normal mode
nnoremap <CR> o<Esc>

" }}}
