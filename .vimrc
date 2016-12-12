set nocompatible
behave mswin

execute pathogen#infect()

filetype on
filetype plugin on
filetype indent on
syntax enable

set backspace=indent,eol,start
set encoding=utf-8
set number      " enable line numbers
set ruler
set scrolloff=1 " # of lines to keep above and below cursor

" Search
set hlsearch    " highlight search matches
set ignorecase  " ignore case when searching
set incsearch   " incremental search (match while typing)
set nowrapscan  " disable wrapping around when searching
set smartcase   " using a capital letter while searching will enable case-sensitive
                " searching

" Replace (substitute)
set gdefault    " replace all occurrences on a line by default

" Editing
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <
vnoremap <Tab> >

autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType css,html,xhtml setlocal shiftwidth=2 softtabstop=2
autocmd FileType clojure setlocal shiftwidth=2 softtabstop=2

autocmd BufNewFile,BufRead wscript* set filetype=python
autocmd BufNewFile,BufRead *.qml set filetype=javascript
autocmd BufNewFile,BufRead *.aidl set filetype=java

" Remove trailing whitespace
" Use 'noautocmd' to temporarily disable.
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

" cindent options
" :     Don't indent case labels
" g     Don't indent public/private class modifiers
" N     Don't indent code inside namespaces
" t     Don't indent function return types
" c     Set comment indentation
set cinoptions=:0,g0,N-s,t0,cs

if has('gui_running')
    set lines=45 columns=120

    " Display right margin.
    let &colorcolumn=join(range(101, 101), ",")
    highlight ColorColumn guibg=#efefef

    if has('gui_win32')
        set guifont=consolas:h10
    endif
endif

" Format JSON
command Formatjson %!python -m json.tool
