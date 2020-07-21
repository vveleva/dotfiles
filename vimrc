" set nocompatible
filetype plugin indent on
runtime macros/matchit.vim

syntax on " Enable syntax highlighting.

set autoindent                    " Next-line indentation; keep same as smartindent
set backspace=indent,eol,start    " Backspace deletes like most programs in insert mode
set cursorline                    " Highlight currently-selected line
set diffopt+=vertical             " Use vertical splits in Gdiff
set encoding=utf-8                " use UTF-8.
set expandtab                     " Convert tab characters to spaces
set fillchars+=vert:│             " custom character for vertical split separator
set hlsearch                      " Highlight search results
set ignorecase                    " Ignore case when searching.
set incsearch                     " Search as you type.
set lazyredraw                    " Boost performance a little bit
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set mouse+=niv                    " Allow scrolling and mouse selecting
set nojoinspaces                  " One space after periods when joining lines
set noswapfile                    " Disable swapfiles
set ruler                         " Show line number, cursor position.
set scrolloff=5                   " Number of lines to keep above and below the cursor
set shiftround                    " Always indent to a multiple of shiftwidth
set shiftwidth=0                  " Use the value of 'tabstop' for autoindent
set showcmd                       " Display incomplete commands.
set showmode                      " Show editing mode
set smartcase                     " Overrides ignorecase if pattern contains caps
set splitbelow splitright         " Open splits to the right and bottom
set tabstop=2                     " Use 2 spaces for tabs
set timeoutlen=1000 ttimeoutlen=0 " Eliminate delay on ESC
set ttymouse=xterm2               " Allow resizing of vim windows in tmux
set undodir=$HOME/.vim/undodir    " Store undofiles in $HOME/.vim/undodir
set undofile                      " Record undo history after leaving buffer
set visualbell                    " Error bells are displayed visually.
set wildmenu                      " Show autocomplete menus.

" Make it obvious where 100 char is
set colorcolumn=+1
set formatoptions+=w
set number relativenumber         " Hybrid line numbers
set textwidth=100
set wrapmargin=2


" ##### STATUS LINE ################################################################################
set laststatus=2                             " Always display the status line
set statusline=%.40t
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

" ##### KEYMAPPINGS ################################################################################
if filereadable(expand("~/.vimrc.keymappings"))
  source ~/.vimrc.keymappings
endif

" ##### PLUGINS ####################################################################################
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ##### COLOR SCHEME ###############################################################################
if filereadable(expand("~/.vimrc.colors"))
  source ~/.vimrc.colors
endif

" ##### LOCAL CONFIG ###############################################################################
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif
