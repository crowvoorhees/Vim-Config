" ==============================================================================
"   __     ___
"   \ \   / (_)_ __ ___  _ __ ___
"    \ \ / /| | '_ ` _ \| '__/ __|
"     \ V / | | | | | | | | | (__
"  ____\_/  |_|_| |_| |_|_|  \___|
" |_____|
" ==============================================================================

set nocompatible

" gVim Windows Behavior{{{
if has( 'gui_running' )
  runtime mswin.vim
  behave mswin
endif

if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"}}}

"Plugins{{{
call plug#begin()
if has('gui_running')
  Plug 'bling/vim-bufferline'
  Plug 'enricobacis/vim-airline-clock'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
endif
Plug 'itchyny/calendar.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'ajmwagar/vim-deus'
"Plug 'arcticicestudio/nord-vim'
"Plug 'gruvbox/vim'
"Plug 'kkoenig/wimproved.vim'
call plug#end()

" NERDTree
"let NERDTreeQuitOnOpen = 1                     " close pane when file is opened
let NERDTreeMouseMode = 2                       " enable mouse mode
let NERDTreeShowHidden = 1                      " show hidden files
let NERDTreeKeepTreeInNewTab = 1                " keep tree in new tab

" Airline
let g:airline_theme='gruvbox'                   " set theme
let g:airline#extenstions#tabline#enabled = 1   " enable tab line

if has('gui_running')
  let g:airline_left_sep='›'                    " customize left separator
  let g:airline_right_sep='‹'                   " customize right separator
endif

" Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
"}}}

" General Settings{{{
syntax on                                       " enable sytnax
filetype plugin indent on                       " automatically detect file types
set number relativenumber                       " enable hybrid line number (VIM 7.4)
set cursorline                                  " highlight current line
set virtualedit=onemore                         " give one virtual space at end of line
set laststatus=2                                " always show statusline
set backspace=indent,eol,start                  " allow backspace to go to previous line
set hidden                                      " hide buffers instead of closing them
setlocal cm=blowfish2                           " set encryption type
"}}}

" Formatting{{{
set listchars=eol:¬,trail:·,nbsp:·,tab:>.       " format to display hidden whitespace
set list                                        " display hidden whitespace
set textwidth=0                                 " disable default text width
set nowrap                                      " disable automatic line wrap
set colorcolumn=81                              " display column at character length
set autoindent                                  " automatically indent new lines
set smartindent                                 " enable smart indenting
set softtabstop=2                               " set soft tab to 2 spaces
set shiftwidth=2                                " set shift width to 2 spaces
set tabstop=4                                   " set tab to 2 spaces
set expandtab                                   " expand tabs to spaces
set nosmarttab                                  " disable smart tabs
set formatoptions+=n                            " support for numbered/bullet lists
match ErrorMsg '\s\+$'                          " highlight empty spaces
"}}}

" UI{{{
colorscheme gruvbox                             " set syntax theme
set background=dark                             " set background tone
set shortmess+=I                                " remove splash screen
set showmatch                                   " show matching brackets/parenthesis
set mousehide                                   " hide mouse cursor while typing
set splitright                                  " split window to the right of the current
set splitbelow                                  " split window to the bottom of the current

if has( 'gui_running' )
  set visualbell t_vb=                          " disable beep and flash
  set mouse=a                                   " automatically enable mouse usage
  set guifont=Fira\ Mono:h10                    " set font type
  set guioptions-=T                             " remove toolbar
  set guioptions-=r                             " remove right scrollbar
  set guioptions-=L                             " remove left scrollbar
  set guioptions-=t                             " remove tearoff menu items
else
  set noerrorbells visualbell t_vb=             " disable beep and flash
  set t_Co=256                                  " enable color 256
endif
"}}}

" Backups{{{
set nobackup                                   " do not keep backups after close
set nowritebackup                              " do not backup while working
set noundofile                                 " disable undo files (Vim 7.3)

" set swapfile path, os specific
set directory=$HOME//
if has( "win32" )
  set directory=$HOME\\
endif
"}}}

"  Search{{{
let @/ = ""                                     " clear last search pattern on startup
set incsearch                                   " find as you type
set ignorecase                                  " case insensitive search
set smartcase                                   " case sensitive when uppercase present
set hlsearch                                    " pattern highlighting
"}}}

" Folding{{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
"}}}

" Custom Syntax{{{
autocmd BufNewFile,BufRead *.lb set syntax=limsbasic
autocmd BufRead todo set syntax=todo
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"}}}

" Leader Mapping{{{
" set mapping leader
let mapleader = ","

" todo list: insert new entry
nnoremap <leader>n A<cr>- [ ] 

" todo list: sort + save list
nnoremap <leader>s :sort<cr>:w<cr>

" remove trailing white space
nnoremap <leader>w :%s/\s*$//<cr>:noh<cr><esc>
"}}}

" Key Mapping{{{
" swap colon and semicolon
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" movement
nnoremap <PageUp> <c-b>
nnoremap <PageDown> <c-f>
nnoremap <Home> gg
nnoremap <End> G

" use ctrl-[hjkl] to select the active split
nnoremap <silent> <c-k> :wincmd k<return>
nnoremap <silent> <c-j> :wincmd j<return>
nnoremap <silent> <c-h> :wincmd h<return>
nnoremap <silent> <c-l> :wincmd l<return>

" folding
nnoremap <space> za
"}}}

" Functions{{{
" gVim fullscreen toggle (defaults to off)
let g:fullScreened = 0
function! ToggleFullScreen()
  if g:fullScreened == 0
    let g:fullScreened = 1
    simalt ~x
  else
    let g:fullScreened = 0
    simalt ~r
  endif
endfunction

" gVim menu bar toggle (defaults to off)
set guioptions-=m
let g:MenuEnabled = 0
function! ToggleGuiMenu()
  if g:MenuEnabled == 0
    set guioptions+=m
    let g:MenuEnabled = 1
  else
    set guioptions-=m
    let g:MenuEnabled = 0
  endif
endfunction
"}}}

" Function Keys{{{
" F2: toggle NERDTree starting in $HOME (requires NERDTree plugin)
nnoremap <F2> :NERDTreeToggle $HOME\<cr>

" F3: toggle Goyo view (requires Goyo plugin)
nnoremap <F3> :Goyo<cr>

" F4: toggle text wrap
nnoremap <F4> :set wrap!<cr>

" F7: toggle spell check
nnoremap <F7> :setlocal spell! spell?<cr>

" F8: refresh VIMRC
nnoremap <F8> :source $MYVIMRC<cr>

" F9: open VIMRC in vertical split panel
nnoremap <F9> :vsplit $MYVIMRC<cr>

if has( 'gui_running' )
  " F10: toggle gui menu bar
  nnoremap <F10> :call ToggleGuiMenu()<cr>

  " F11: toggle full screen mode
  nnoremap <F11> :call ToggleFullScreen()<cr>

  " ESC: clear search highlight
  nnoremap <esc> :noh<cr><esc>
endif
"}}}

  " vim:foldmethod=marker:foldlevel=0
