set nocompatible
behave mswin

" Use UTF-8
set encoding=utf-8

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

" --- Indentation ---
filetype on
filetype plugin on
filetype indent on

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <
vnoremap <Tab> >

" --- cindent options ---
" :     Don't indent case labels
" g     Don't indent public/private class modifiers
" N     Don't indent code inside namespaces
" t     Don't indent function return types
" c     Set comment indentation
set cinoptions=:0,g0,N-s,t0,cs

autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType css,html,xhtml setlocal shiftwidth=2 softtabstop=2
autocmd FileType clj setlocal shiftwidth=2 softtabstop=2

" --- Strip trailing whitespace ---
autocmd FileType c,clojure,cpp,cs,css,html,java,javascript,php,python,ruby,xhtml,xml autocmd BufWritePre <buffer> :%s/\s\+$//e

" --- Open wscript* as python ---
autocmd BufRead,BufNewFile wscript* set filetype=python

" --- Open .qml as Javascript ---
autocmd BufRead,BufNewFile *.qml set filetype=javascript

" --- Open .aidl as Java ---
autocmd BufRead,BufNewFile *.aidl set filetype=java

if has('gui_running')
    set lines=45 columns=120

    if has('gui_win32')
        set guifont=consolas:h10
    endif
endif

" --- Format json ---
command Formatjson %!python -m json.tool
