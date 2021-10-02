" use dracula as colorscheme
packadd! dracula
colorscheme dracula
" set transparent dracula background
let g:dracula_colorterm = 0
" disable italic to prevent weird word highlights if italic is not supported by the terminal 
let g:dracula_italic = 0
syntax enable

" enable line numeration
set nu

" sets how many lines of history VIM has to remember
set history=1000

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" turn on wildmenu with completion preference to the longest, most common command
set wildmenu
set wildmode=longest:full,full

" always show current position
set ruler

" case-insensitive search
set ignorecase

" highlight search results
set hlsearch

" better search behaviour
set incsearch

" show matching brackets
set showmatch
" set blinking speed of matching bracket (in tenth of sec)
set mat=2

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" use Unix as the standard file type
set ffs=unix,dos,mac

" disable backup
set nobackup
set nowb
set noswapfile

" use 2 spaces instead of tab
set expandtab
set shiftwidth=2
set tabstop=2

" be smart with indets and tabs
set smarttab
set ai
set si

" always show the status line
set laststatus=2

" format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
