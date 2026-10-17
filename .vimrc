filetype plugin indent on
syntax on

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    " Enable true color.
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

set background=light
colorscheme PaperColor

let mapleader=","

set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set laststatus=2
set mouse=a
set noswapfile
set number      " enable line numbers
set ruler
set scrolloff=5 " # of lines to keep above and below cursor

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

autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2
autocmd FileType clojure setlocal shiftwidth=2 softtabstop=2
autocmd FileType css,html,xhtml,yaml setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
autocmd BufNewFile,BufRead wscript* set filetype=python
autocmd BufNewFile,BufRead *.aidl set filetype=java
autocmd BufNewFile,BufRead *.qml set filetype=javascript

" C++ options.
set cinoptions=g1,N-s,t0,cs

func! StripTrailingWhitespace()
    %s/\s\+$//e
endfunc

func! StripTrailingWhitespaceFileType()
    " Do not strip on these filetypes.
    "   C/C++ - we already run clang-format
    "   Markdown - trailing spaces may be significant
    if &ft =~ '^\%(c\|cpp\|markdown\|rust\)$'
        return
    endif
    %s/\s\+$//e
endfunc
" Strip trailing whitespace. Use 'noautocmd' to temporarily disable.
autocmd BufWritePre * call StripTrailingWhitespaceFileType()

" vim-clang-format settings.
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1

" rust.vim settings.
let g:rustfmt_autosave = 1
