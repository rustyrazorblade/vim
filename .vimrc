colorscheme wombat
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

set scrolloff=12

filetype on
filetype plugin on


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

let g:pyflakes_use_quickfix = 0


call pathogen#runtime_append_all_bundles() 

autocmd BufNewFile,BufRead *.py compiler nose

	
