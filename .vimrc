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
else
    " Set the background to dark so the color scheme is more readable.
    set background=dark
endif

let mapleader=","

set backspace=indent,eol,start
set encoding=utf-8
set laststatus=2
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
autocmd FileType css,html,xhtml,yaml setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
autocmd BufNewFile,BufRead wscript* set filetype=python
autocmd BufNewFile,BufRead *.aidl set filetype=java
autocmd BufNewFile,BufRead *.qml set filetype=javascript

" C++ options.
set cinoptions=g1,N-s,t0,cs
" Switch between C++ header and source files with F4.
noremap <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

func! StripTrailingWhitespace()
    %s/\s\+$//e
endfunc

func! StripTrailingWhitespaceFileType()
    " Do not strip on these filetypes.
    "   C/C++ - we already run clang-format
    "   Markdown - trailing spaces may be significant
    if &ft =~ 'c\|cpp\|markdown\|rust'
        return
    endif
    %s/\s\+$//e
endfunc
" Strip trailing whitespace. Use 'noautocmd' to temporarily disable.
autocmd BufWritePre * call StripTrailingWhitespaceFileType()


command Formatjson %!python -m json.tool

" ctrlp.vim settings
let g:ctrlp_max_files=0  " Always show all files.

" vim-clang-format settings.
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
autocmd FileType c,cpp nnoremap <C-i> :ClangFormat<CR>
nnoremap <Leader>cf :ClangFormatAutoToggle<CR>

" vim-lsc settings
let g:lsc_server_commands = {
    \ 'cpp': 'clangd --log=error',
    \}
let g:lsc_auto_map = {
    \ 'defaults': v:true,
    \ 'GoToDefinition': 'gd',
    \ 'NextReference': '<Leader>nr',
    \ 'PreviousReference': '<Leader>pr'
    \}

let g:rustfmt_autosave = 1
