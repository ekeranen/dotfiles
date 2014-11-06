behave mswin    " subtle - selected areas are deleted when you start typing

set backspace=indent,eol,start
set number      " enable line numbers
set ruler
syntax enable

" --- Search ---
set incsearch   " incremental search (match while typing)
set hlsearch    " highlight search matches
set ignorecase  " ignore case when searching
set smartcase   " using a capital letter while searching will enable case-sensitive
                " searching
set nowrapscan  " disable wrapping around when searching

" --- Replace (substitute) ---
set gdefault    " replace all occurrences on a line by default

" --- Code completion ---
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" --- Indentation ---
filetype on
filetype plugin on
filetype indent on

set omnifunc=syntaxcomplete#Complete

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <
vnoremap <Tab> >

autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType css,html,xhtml,xml setlocal shiftwidth=2 softtabstop=2

" --- Strip trailing whitespace ---
autocmd FileType c,cpp,java,php,ruby,python,html,xhtml,xml,css autocmd BufWritePre <buffer> :%s/\s\+$//e

if has('gui_running')
    if has('gui_win32')
        set guifont=consolas:h10
    endif
endif

" --- Format json ---
command Formatjson %!python -m json.tool
