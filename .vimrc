colorscheme mayansmoke

set cindent
set number
set ci
set hls is
map <C-d> :NERDTreeToggle <CR>

map <D-p> :TlistToggle<CR>

set tabstop=4
set nobackup
set noswapfile
set shiftwidth=4
set scrolloff=3
set splitright
set ruler
set wildmenu
set smarttab

set scrolloff=12

filetype on
filetype plugin on
filetype plugin indent on


let g:CommandTMaxHeight=20

map <D-B> :!erlc -I includes -o ebin %  <CR>

map <Leader>a :Ack 

map <Leader>p :Tlist<CR>

set guifont=Inconsolata:h16  

let tlist_php_settings = 'php;c:class;f:function'

let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 40
let Tlist_Sort_Type = "name"
let NERDTreeChDirMode = 2

set expandtab

let g:pyflakes_use_quickfix = 0


call pathogen#runtime_append_all_bundles() 

" autocmd BufNewFile,BufRead *.py compiler nose
	
" inoremap <c-space> <c-x><c-o>


if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


