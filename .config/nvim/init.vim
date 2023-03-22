"colorscheme hybrid

" XDG Base Directory {{{
if empty($XDG_DATA_HOME) | let $XDG_DATA_HOME = expnad('$HOME/.local/share') | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = expand('$HOME/.config') | endif
if empty($XDG_CACHE_HOME) | let $XDG_CACHE_HOME = expand('$HOME/.cache') | endif

if has('nvim')
  let s:data_home = expand('$XDG_DATA_HOME/nvim')
  let s:config_home = expand('$XDG_CONFIG_HOME/nvim')
  let s:cache_home = expand('$XDG_CACHE_HOME/nvim')
  let $MYVIMRC = expand('$XDG_CONFIG_HOME/nvim/init.vim')
  let g:netrw_home = expand('$XDG_CONFIG_HOME/nvim')
else
  let s:data_home = expand('$XDG_DATA_HOME/vim')
  let s:config_home = expand('$XDG_CONFIG_HOME/vim')
  let s:cache_home = expand('$XDG_CACHE_HOME/vim')
  let $MYVIMRC = expand('$XDG_CONFIG_HOME/vim/vimrc')
  let g:netrw_home = expand('$XDG_CACHE_HOME/vim')
  if !isdirectory(s:data_home) | call mkdir(s:data_home, 'p', 0700) | endif
  if !isdirectory(s:config_home) | call mkdir(s:config_home, 'p', 0700) | endif
  if !isdirectory(s:cache_home) | call mkdir(s:cache_home, 'p', 0700) | endif
  set undodir=$XDG_DATA_HOME/vim/undo | call mkdir(&undodir, 'p', 0700)
  set directory=$XDG_DATA_HOME/vim/swap | call mkdir(&directory, 'p', 0700)
  set backupdir=$XDG_DATA_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
  set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p', 0700)
  set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
  set runtimepath=$XDG_DATA_HOME/vim,$VIMRUNTIME,$XDG_DATA_HOME/vim/after
endif
" }}}

" syntax
syntax enable
set smartindent
set wildmenu

" filetype
filetype on
filetype plugin indent on

" color
set background=dark
set t_Co=256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum""]"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum""]"
set termguicolors
set pumblend=10

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,shift-jis
set fileformats=unix,dos,mac

" row number
set number
set signcolumn=yes

" cursor
set cursorline
set whichwrap=b,s,h,l,<,>,~,[,]

" window
set splitbelow
set splitright

" search
set hlsearch
set incsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set ignorecase
set smartcase
set wrapscan

" tab line
set showtabline=2

" status line
set laststatus=2
set noshowmode

" cmd line
set cmdheight=1

" hel and decimal
set nrformats=hex

" don't create backup
set nowritebackup
set nobackup

" auto refresh changed content
set autoread

" disable beeping
set visualbell t_vb=
set noerrorbells

" tab
set expandtab
set tabstop=4
set shiftwidth=2

" eol, tab, space
set list
set listchars=eol:↲,tab:>-,space:.,trail:.

" folding
set foldmethod=manual

" netrwhist
let g:netrw_dirhistmax = 0

" mouse
set mouse=a

" map {{{
" leader
let mapleader = "\<Space>"

" Indent
inoremap <S-Tab> <C-h>

" move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

call add(g:jetpack_ignore_patterns, '/*.yaml')
let g:jetpack_copy_method='copy' " Neovimのみ使用可能 高速
let g:jetpack#optimization=2

packadd vim-jetpack = 1
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'vim-airline/vim-airline'
Jetpack 'vim-airline/vim-airline-themes'
Jetpack 'lambdalisue/fern.vim'

Jetpack 'joshdick/onedark.vim'
Jetpack 'cocopon/iceberg.vim'
Jetpack 'ghifarit53/tokyonight-vim'

" status line {{{
Jetpack 'itchyny/lightline.vim'
let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'lsp_status', 'lsp_diagnostic_info', 'fileencoding', 'fileformat', 'filetype' ],
  \   ],
  \ },
  \ 'component_function': {
  \   'filename': 'lightline#additional#get_relative_path',
  \   'fileencoding': 'lightline#additional#get_encoding',
  \   'fileformat': 'lightline#additional#get_eol',
  \   'filetype': 'lightline#additional#get_formatted_filetype',
  \   'lineinfo': 'lightline#additional#get_formatted_lineinfo',
  \   'gitbranch': 'lightline#additional#fugitive#get_head_branch',
  \   'lsp_status': 'lightline#additional#coc#get_status',
  \   'lsp_diagnostic_info': 'lightline#additional#coc#get_diagnostic_info',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }
" }}}

" filer
Jetpack 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeShowHidden = 1
augroup nerdtree
  autocmd!
  autocmd FileType nerdtree setlocal signcolumn=auto
augroup END
nnoremap <C-e> :NERDTreeToggle<CR>
Jetpack 'Xuyuanp/nerdtree-git-plugin'
Jetpack 'ryanoasis/vim-devicons'

" japanese documentation
Jetpack 'vim-jp/vimdoc-ja'

" surround
Jetpack 'tpope/vim-surround'
Jetpack 'tpope/vim-repeat'

" insert or delete pairs
Jetpack 'jiangmiao/auto-pairs'

" comment out and uncomment
Jetpack 'tpope/vim-commentary'

" fuzzy finder
Jetpack 'junegunn/fzf'
Jetpack 'junegunn/fzf.vim'
nnoremap <C-p> :<C-u>Files<CR>

" easy motion
Jetpack 'easymotion/vim-easymotion'

" coc.nvim {{{
if executable('node') || executable('nodejs')
  Jetpack 'neoclide/coc.nvim', {'branch': 'release'}

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <expr> <C-n> coc#refresh()
  inoremap <expr> <C-p> coc#refresh()

  inoremap <silent><expr> <Tab> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<Tab>"

  inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [g <Jetpack>(coc-diagnostic-prev)
  nmap <silent> ]g <Jetpack>(coc-diagnostic-next)
  nmap <silent> gd <Jetpack>(coc-definition)
  nmap <silent> gy <Jetpack>(coc-type-definition)
  nmap <silent> gi <Jetpack>(coc-implementation)
  nmap <silent> gr <Jetpack>(coc-references)

  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  nmap <leader>rn <Jetpack>(coc-rename)
  nmap <leader>ac <Jetpack>(coc-codeaction)

  command! -nargs=0 Format :call CocAction('format')
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

  let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-clangd',
    \ 'coc-tsserver',
    \ 'coc-prettier',
    \ 'coc-eslint',
    \ 'coc-vetur',
    \ 'coc-deno',
    \ 'coc-python',
    \ 'coc-tailwindcss',
    \ 'coc-sh',
    \ 'coc-diagnostic',
    \ 'coc-vimlsp',
    \ 'coc-omnisharp',
    \ 'coc-go',
    \ 'coc-rust-analyzer',
    \ 'coc-solargraph',
    \ 'coc-markdownlint',
    \ ]
endif
" }}}

" EditorConfig
Jetpack 'editorconfig/editorconfig-vim'

" syntax
Jetpack 'sheerun/vim-polyglot'
Jetpack 'cespare/vim-toml'
Jetpack 'elzr/vim-json'
Jetpack 'pantharshit00/vim-prisma'

if has('nvim')
  Jetpack 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
endif

" git
if executable('git')
  Jetpack 'tpope/vim-fugitive'
  Jetpack 'airblade/vim-gitgutter'
endif

" Markdown
if executable('node') && executable('yarn')
  Jetpack 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
else
  Jetpack 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
endif

Jetpack 'koyashiro/lightline-additional.vim'
call jetpack#end()
" }}}

" colorscheme {{{
let s:colorscheme = 'tokyonight'
if index(map(split(globpath(&runtimepath, 'colors/*.vim'), '\n'), "fnamemodify(v:val, ':t:r')"), s:colorscheme) + 1
  execute 'colorscheme ' . s:colorscheme
  highlight Comment gui=NONE
  if exists('g:lightline')
    let g:lightline.colorscheme = s:colorscheme
  else
    let g:lightline = { 'colorscheme': s:colorscheme }
  endif
endif
" }}}

