" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

"required for vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Bundle 'FredKSchott/CoVim'
"Plugin 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
"Bundle 'Lokaltog/vim-powerline'

call vundle#end()            " required
filetype plugin indent on    " required

" background is dark
set bg=dark
color delek

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
  
autocmd FileType make setlocal noexpandtab

set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set expandtab
set number 
set hlsearch
set backspace=2
set ruler

set complete-=i

function! ToggleCPPHeader()
    let current=expand("%")
    let header=substitute(current, "\.cpp$", ".h", "")
    if header==current
        let header=substitute(current, "\.h$", ".cpp", "")
    endif
    if filereadable(header)
        exec "edit " . header
    endif
endfunction

map <C-H>  :call ToggleCPPHeader()<CR>

noremap <F3> :call Svndiff("prev")<CR> 
noremap <F4> :call Svndiff("next")<CR> 
noremap <F5> :call Svndiff("clear")<CR>
nmap <CR> _A<Enter><Esc>
nmap <Space> i<Space><ESC>

"Show trailing whitespace:
"match ExtraWhitespace /\s\+$/

" Show trailing whitepace and spaces before a tab:
" match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
" match ExtraWhitespace /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
" match ExtraWhitespace /^\t*\zs \+/

" Switch off :match highlighting.
" match
let c_space_errors = 1

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"mappings
let mapleader = "\\"
inoremap <c-u> <esc>l~i
inoremap <c-d> <esc>ddi
nnoremap <leader>rs :s/[ ]\+$//<cr>
nnoremap <leader>rg :%s/[ ]\+$//<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sf :1,$ !gawk -v ORS='\t' '{split($0, a, "\t+"); n=asort(a); for(i=1;i<=n;++i){print a[i]}; printf "\n"; }'<cr>
nnoremap <leader>d ^y$OCerr << "pA" << Endl;<ESC>
nnoremap <leader>p :set paste<cr>
nnoremap <leader>np :set nopaste<cr>
nnoremap <leader><leader> I//<ESC>

" for cursorline 
highlight CursorLine guibg=lightblue ctermbg=lightgray

autocmd vimenter * NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>

"set statusline=%t       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
set laststatus=2   " Always show the statusline
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set term=xterm-256color
set termencoding=utf-8


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" syntastic need checkers
" install one using e.g. (for python) pip install flake8

" needs powerline installed, pip install powerline-status
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
