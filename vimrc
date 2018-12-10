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


" ##### STATUS LINE ############################################################
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


" ##### AUTOLOAD COMMANDS ######################################################
if !exists("*ReloadVimSettings")
  function ReloadVimSettings()
    source $MYVIMRC
    if has("gui_running") && filereadable($MYGVIMRC)
      source $MYGVIMRC
    endif
  endfunction
endif

" Use syntax highlighting and color scheme when possible
if (&t_Co > 2 || has("gui_running"))
  if !exists("syntax_on")
    syntax on
  endif
endif

" Autoload vimrc
augroup update_vimrc
  au!
  au BufWritePost .vimrc,.gvimrc call ReloadVimSettings()
augroup END

" Strip trailing whitespace
au BufWritePre *.rb :%s/\s\+$//e
au BufWritePre *.py :%s/\s\+$//e

function! SortRubyMethods()
  silent '<,'>global/def/,/end/substitute/\n/§
  silent '<,'>sort
  silent '<,'>global/def/substitute/§/\r/g
endfunction

function! SortLines() range
  execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
  execute a:firstline . "," . a:lastline . 'sort n'
  execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction

if executable('ag')
  set grepprg=ag

  " Use Ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  let g:ctrlp_use_caching = 0
endif


" Global match and replace
function! Replace(pattern, replacement, grep_flags, s_flags)
  let original_grep_format=&grepformat
  let original_buffer_id=bufnr('%')
  set grepformat+=%f

  tabnew
  execute 'silent! grep! --files-with-matches ' . a:grep_flags . ' ' . a:pattern
  cfdo execute '%s/\v' . a:pattern . '/' . a:replacement . '/gc' . a:s_flags . ' | write'
  tabclose

  let &grepformat=original_grep_format
  execute 'buffer ' . original_buffer_id
endfunction

command! -nargs=+ -bar Replace call Replace(<f-args>, '', '')
command! -nargs=+ -bar IReplace call Replace(<f-args>, '--ignore-case', 'i')



let g:slime_target = "tmux" " Setting up vim_slime to use tmux sessions
let g:syntastic_javascript_checkers = ['jslint']
let g:cssColorVimDoNotMessMyUpdatetime = 1
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'ruby', 'rb=ruby', 'html']

" Enables JSX filetype plugin for `.js` files
let g:jsx_ext_required = 0


" ##### KEYMAPPINGS ############################################################
let mapleader = " "

nnoremap Q <nop>

" insert timestamp
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

vnoremap <Leader>sm :call SortRubyMethods()<CR>
vnoremap <Leader>sl :call SortLines()<CR>

" System clipboard copy/paste
xnoremap <C-c> "*y
nnoremap <Leader>p :set paste expandtab<CR>"*]p:set nopaste<CR>

" Better shortcut for navigating between split windows
nnoremap <Leader>w <C-w>w
nnoremap <Leader>i mmgg=G`m
nnoremap <Leader>ac :sp app/controllers/application_controller.rb<cr>
nnoremap <Leader>bb :!bundle install<cr>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <Leader>h :nohlsearch<CR>

" Copy current path into the system clipboard
nnoremap <Leader>% :let @+ = expand("%")<CR>

" Grep for the current word
nnoremap <Leader>k :Ag <C-R><C-W><CR>
vnoremap <Leader>k y<CR>:Ag <C-R>"<CR>

" Quickly open vim
nnoremap <Leader>v :vsplit $MYVIMRC<CR>

" Hotkey for NERDTree toggle
nnoremap <Leader><C-n> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <D-F> :Ag<Space>

" Copy current path into the system clipboard
nnoremap <Leader>% :let @+ = expand("%")<CR>

" Keyword.vim
let g:keyword_command = 'Ag --fixed-strings {keyword}'

" Substitute for CTRL-P
nnoremap <C-p> :call PickFile()<CR>

command! -nargs=+ -complete=file -bar Ag silent! grep! <args> | redraw! | cwindow

" let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = { 'javascript': ['eslint'], 'javascript.jsx': ['eslint'], 'ruby': ['rubocop'] }
" let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_use_local_config = 1

" ##### PLUGINS ################################################################
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ##### COLOR SCHEME ###########################################################
if filereadable(expand("~/.vimrc.colors"))
  source ~/.vimrc.colors
endif

" ##### LOCAL CONFIG ###########################################################
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif
