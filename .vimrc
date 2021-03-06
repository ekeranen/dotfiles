set nocompatible
behave xterm

filetype plugin indent on
syntax enable

if has('gui_running')
    set lines=45 columns=120
    if has('gui_win32')
        set guifont=consolas:h10
    else
        set guifont=Ubuntu\ Mono\ 12
    endif
endif

set backspace=indent,eol,start
set encoding=utf-8
set mouse=a
set noswapfile
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
" Allow Tab and Shift+Tab for indent and de-indent.
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <
vnoremap <Tab> >


autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2
autocmd FileType clojure setlocal shiftwidth=2 softtabstop=2
autocmd FileType css,html,xhtml setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
autocmd BufNewFile,BufRead wscript* set filetype=python
autocmd BufNewFile,BufRead *.aidl set filetype=java
autocmd BufNewFile,BufRead *.qml set filetype=javascript

func! StripTrailingWhitespace()
    " Do not strip on these filetypes (we already run clang-format).
    if &ft =~ 'c\|cpp'
        return
    endif
    %s/\s\+$//e
endfunc
" Strip trailing whitespace. Use 'noautocmd' to temporarily disable.
autocmd BufWritePre * call StripTrailingWhitespace()

func! Clangformat()
    let b:winview = winsaveview()
    %!clang-format -style=file
    call winrestview(b:winview)
    unlet b:winview
endfunc

" cindent options
set cinoptions=g1,N-s,t0,cs

" Run clang-format on C/C++ code.
autocmd FileType c,cpp autocmd BufWritePre <buffer> call Clangformat()
autocmd FileType c,cpp nnoremap <buffer> <C-i> :call Clangformat()<CR>

" Switch between C++ header and source files with F4.
noremap <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

" command Clangformat %!/opt/tri/llvm/8.0.0/bin/clang-format -style=file

command Formatjson %!python -m json.tool

" Always show all files with ctrlp.vim.
let g:ctrlp_max_files=0
