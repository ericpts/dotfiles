""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.vim/plugged')


" Appearance


Plug 'nathanaelkane/vim-indent-guides'

Plug 'liuchengxu/vim-which-key'

" Autocomplete

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'preservim/nerdtree'


" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  nnoremap <C-p> :FZF <cr>
  nnoremap <A-p> :F <cr>
" }}}

" Moving around easily
Plug 'easymotion/vim-easymotion'
Plug 'raimondi/delimitmate'

" Git
Plug 'tpope/vim-fugitive'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Nice status bar at the bottom
Plug 'vim-airline/vim-airline'

" Tabularize data.
Plug 'godlygeek/tabular'

" Org-mode for vim.
Plug 'jceb/vim-orgmode'
" required by org-mode.
Plug 'tpope/vim-speeddating'


" Easily surround text with tags, quotes etc.
Plug 'tpope/vim-surround'

" Easily comment stuff.
Plug 'tpope/vim-commentary'

" Diff two selections
Plug 'AndrewRadev/linediff.vim'

" Language related plugins


" Clojure
Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


" Javascript
Plug 'jelera/vim-javascript-syntax', {'for': 'javascript'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" Plug 'ternjs/tern_for_vim', {'for': 'javascript'}
"


Plug 'JuliaEditorSupport/julia-vim'


" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust'}


" LaTex
Plug 'lervag/vimtex'


" Tmux
Plug 'christoomey/vim-tmux-navigator'


Plug 'morhetz/gruvbox'


Plug 'skywind3000/asyncrun.vim'


call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set relative line numbering
set rnu
" Show the absolute line number instead of 0.
set nu

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w!<cr>

" Play nice with C's switch statements.
set cinoptions=l1

set cino=N-s


" Ignore case when searching with / or ?.
set ic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

nmap <silent> ,en <Plug>(coc-diagnostic-next-error)
nmap <silent> ,ep <Plug>(coc-diagnostic-prev-error)

nmap <silent> ,ht <Plug>(coc-type-definition)

nmap <leader>fpr :source ~/.vimrc <CR>
nmap <leader>fpe :e ~/.vimrc <CR>

nmap <leader>gd :call CocAction("jumpDefinition", "drop")<CR>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


command! -bang -nargs=? -complete=dir BatFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! Foo(dir)
  let tf = tempname()
  call writefile(['.'], tf)

  call fzf#vim#files(a:dir, {'source': 'fd', 'options': ['--bind', printf('ctrl-p:reload:base="$(cat %s)"/..; echo "$base" > %s; fd . "$base"', shellescape(tf), shellescape(tf))]})
endfunction

command! -nargs=* Foo call Foo(<q-args>)



nmap <silent> <leader>cc :CocCommand <CR>
nmap <silent> <leader>ce :CocConfig <CR>

nmap <silent> <leader>ff :BatFiles <CR>

nmap <silent> <leader>bb :Buffers <CR>

nmap <silent> <leader>bk :bp<BAR>bd#<CR>

nmap <silent> <leader>mr <Plug>(coc-rename)





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For all the jumps, use the bidirectional options.
nmap <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>W <Plug>(easymotion-bd-W)
nmap <leader><leader>e <Plug>(easymotion-bd-e)
nmap <leader><leader>E <Plug>(easymotion-bd-E)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTex settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" See https://github.com/lervag/vimtex/wiki/introduction#neovim
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WhichKey settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,tex}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Live preview of %s.
set inccommand=split

" Don't redraw while executing macros (good performance config)
set lazyredraw

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

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" 'smartindent' makes comments in Python not have any indentation.
set nosmartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable


set t_Co=256

set background=light
colorscheme gruvbox

" Show indent guides.
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" ":hi IndentGuidesOdd ctermbg=236
" ":hi IndentGuidesEven ctermbg=237


" Highlight current line
set cursorline

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set nowritebackup


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 80 characters
set lbr
set tw=80

" set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Automatically indent when hitting a new line
let delimitMate_expand_cr=1

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>fd :Bclose<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>dc :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for everything :)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

set spelllang=ro,en_us

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
