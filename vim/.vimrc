set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
filetype plugin indent on
set expandtab " On pressing tab, insert 4 spaces
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set paste
set pastetoggle=<F2>
set hlsearch
syntax on
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
