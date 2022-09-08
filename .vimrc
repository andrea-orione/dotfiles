"    ____     ____
"  /  __  \ /  __  \
" |  |__|  |  |  |  |  Andrea Orione
" |   __   |  |  |  |  https://www.github.com/andrea-orione
" |  |  |  |  |__|  |
" |__|  |__|\ ____ / 
"
"
" Customisation of Vim

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

    Plug 'preservim/nerdtree'   " For browsing the filesystem
    Plug 'dense-analysis/ale'   " For checking spell

call plug#end()

" }}}

" VARIOUS SETTINGS ------------------------------------------------------- {{{

" TODO add spell check
" TODO add spell languages
" TODO check syntax languages
set nocompatible    " Disable compatibility with vi that can cause issues
set number          " Show linenumber. Add relative to make so
"set noswapfile     " Disable the creation of swap files
"set nobackup       " Disable the creation of backup files
filetype on         " Enable file type detection
filetype plugin on  " Enable and load plugins for the specific filetype
filetype indent on  " Not shure what it does. I think is smart indentation
syntax on           " Enable syntax highlighting 
                    " (See /usr/share/vim/vim84/syntax 
                    " to see supported languages)
"colorscheme orion_blue
                    " Set the colorscheme
                    " To see which schemes are available see
                    " ~/.vim/colors and /usr/share/vim/vim84/colors
set linebreak       " Wraps (new line) without breaking the words
"set list           " See non printable characters (quite ugly)
"set nowrap         " Long lines don't wrap and continue as far as they go
set cursorline      " See cursor line
"set cursorcolumn   " See cursor column
set showcmd         " Show partial command in the las line
set clipboard=unnamedplus
                    " Copy/paste between vim and other applications
set showmode        " Show the mode on the last line
set history=1000    " Increase the history of commands (default=20)
set mouse=a         " Enable mouse when use in terminal emulator
set wildmenu        " Enable autocomplition (press TAB)
set wildmode=list:longest
                    "Make wildmenu behave like Bash complition
set wildignore=*.docs,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
                    " Makes wildmenu ignore these filetypes that you can't edit in vim

"}}}

" SEARCH SETTINGS -------------------------------------------------------- {{{

set incsearch       " Use incremental search
set ignorecase      " Ignore capital during search
set smartcase       " Ovverrides previous to consider capital only if used
set showmatch       " Highlights all the matches
set hlsearch        " Use hightlighting while searching

" }}}

" TEXT, TAB AND INDENT RELATED ------------------------------------------- {{{

set expandtab       " Use spaces instead of tabs
set smarttab        " Tab smartly (complites the previous tab)
set shiftwidth=4    " One shift = 4 spaces
set tabstop=4       " One tab = 4 spaces

" }}}

" KEYMAPPING ------------------------------------------------------------- {{{
" nnoremap maps normal mode
" inoremap maps in insert mode
" vnoremap maps in visual mode

" let mapleader = "\"
                    " Set the leader, the key to create new shortcuts
" noremap <leader>\ accent accent
                    " Remaps \\ to jump to the last cursor position
" nnoremap <silent> <leader>p :%w !lp<CR>
                    " Remaps \p to print current file to the default printer
                    " <silent> means do not dispalay output
                    " <CR> is like pressing Enter
                    " To view available printers    lpstat -v
                    " To set default printer        lpoptions -d <printer_name>
" inoremap jj <Esc> " Remaps jj to exit from insert mode
" nnoremap <space> :
                    " Remaps <space> to type in command line
" nnoremap o o<esc> " Exit the insert mode when creating a new line below
" nnoremap O O<esc> " Exit the insert mode when creating a new line above
" nnoremap n nzz    " Centers the cursor when moving through search results
" nnoremap N Nzz    " Same as above
" nnoremap Y y$     " Yank (copy) from cursor to the end of the line
" noremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>
                    " Remaps F5 to run a Python script inside vim

" Remapping navigation through splitted windows with CTRL+j,k,h,l
" To split the window in Vim use :split (horiz) or :vsplit (vertical)
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l

" Remapping resizing split window with CTRL+UP,DOWN,LEFT,RIGHT
" nnoremap <c-up> <c-w>+
" nnoremap <c-down> <c-w>-
" nnoremap <c-left> <c-w>>
" nnoremap <c-right> <c-w><

" NERDTree mappings
nnoremap <f3> :NERDTreeToggle<CR>
                    " Remaps F3 to toggle NERDTree to open and close
" let NERDTreeIgnore =
" ['\.git$','\.jpg$','\.mp4$','\.ogg$','\.iso$','\.pdf$','\.pyc$','\.odt', '\.png$','\.gif$','\.db$']
                    " Makes NERDTree ignore these files/directories


" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This scrpt enable code foding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" This script sets indentations to 2 if the filetype is HTML 
" (to convert to spaces uncomment expandtab)
autocmd FileType html setlocal tabstop=2 shiftwidth=2 "expantab

" If Vim version is equal or greater than 7.3 enable undofile 
" (undo changes even after saving)
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" This script makes that cursor line is displayed only in active split window
" (uncomment cursorcolumn and nocursorcolumn if it is activated)
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline "nocursorcolumn
    autocmd WinEnter * set cursorline "cursorcolumn
augroup END

" This script configure the GUI version if it is active
if has('gui_running')
    "set background=dark    " Set the background tone (usually is already in the color scheme)
    "colorscheme molokai    " Set the color scheme
                            " The color scheme must be in ~/.vim/colors
    "set guifont=Monospace\ Regular\ 12
                            " Set a custom font
                            " set guifont=<font_name>\ <font_weight>\ <size>

    set guioptions-=T       " Hide the toolbar
    set guioptions-=L       " Hide the left side scroll bar
    set guioptions-=r       " Hide the right side scroll bar
    set guioptions-=m       " Hide the menubar
    set guioptions-=b       " Hide the bottom scroll bar

    " Remaps F4 to toggle the menu, tool bar and scroll bar
    nnoremap <f4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif
endif

" }}}

" STATUS LINE ------------------------------------------------------------ {{{
" %F Display the full path of the file
" %M Modified flag shows whether the file is saved or unsaved
" %Y Type of file in the buffer
" %R Shows if the file is read-only
" %b Shows the ASCII/Unicode character under cursor
" 0x%B Shows the hexadecimal character under cursor
" %l line number
" %c column number
" %p%% percentage from the top of the file

" Clear the status line when vimrc is reloaded
set statusline=

" Status line left side
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side
set statusline+=%=

" Status line right side
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the statuts on the second to last line
set laststatus=2

" }}}
