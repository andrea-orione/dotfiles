"    ____     ____
"  /  __  \ /  __  \
" |  |__|  |  |  |  |  Andrea Orione
" |   __   |  |  |  |  https://www.github.com/andrea-orione
" |  |  |  |  |__|  |
" |__|  |__|\ ____ / 
"
" Vim configuration

" VARIOUS SETTINGS
set nocompatible    " Disable compatibility with vi (can cause issues)
set number
set noswapfile      " Disable the creation of swap files
set nobackup        " Disable the creation of backup files
filetype on         " Enable file type detection
filetype plugin on  " Enable and load plugins for the specific filetype
filetype indent on  " Not shure what it does. I think is smart indentation
syntax on           " Enable syntax highlighting 
"colorscheme orion_blue
                    " See ~/.vim/colors and /usr/share/vim/vim84/colors
set linebreak       " Wraps (new line) without breaking the words
set cursorline      " See cursor line
"set cursorcolumn   " See cursor column
set showcmd         " Show partial command in the last line
set clipboard=unnamedplus
set showmode        " Show the mode on the last line
set history=1000    " Increase the history of commands (default=20)
set mouse=a         " Enable mouse when use in terminal emulator
set wildmenu        " Enable autocomplition (press TAB)
set wildmode=list:longest
                    "Make wildmenu behave like Bash complition
set wildignore=*.docs,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
                    " Makes wildmenu ignore these filetypes that you can't edit in vim

" SEARCH SETTINGS
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

" TEXT, TAB AND INDENT RELATED
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" KEYMAPPING
nnoremap <f3> :NERDTreeToggle<CR>

" VIMSCRIPT
" This scrpt enable code foding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Sets indentations to 2 if HTML
autocmd FileType html setlocal tabstop=2 shiftwidth=2 "expantab

" If Vim version >= 7.3 enable undofile
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Cursor line is displayed only in active split window
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline "nocursorcolumn
    autocmd WinEnter * set cursorline "cursorcolumn
augroup END

" Configure GUI version if active
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

" STATUS LINE
" %F Full path of the file
" %M Modified flag
" %Y File Type
" %R Read-only flag
" %b Shows ASCII/Unicode char under cursor
" 0x%B Shows hexadecimal char under cursor
" %l Line number
" %c Column number
" %p%% Percentage from the top of the file

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
