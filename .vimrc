
set cindent
set number
set ci
set hls is


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


fun SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  "   to fetch VAM, VAM-known-repositories and the listed plugins
  "   without having to install curl, unzip, git tool chain first
  " -> BUG [4] (git-less installation)
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  " Example drop git sources unless git is in PATH. Same plugins can
  " be installed form www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

  call vam#ActivateAddons(['snipmate','snipmate-snippets','ack', 'The_NERD_tree','taglist', 'bufexplorer.zip','Conque_Shell','vim-coffee-script','pyflakes%2441','Wombat','mayansmoke'], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " where 'pluginA' could be "git://" "github:YourName" or "snipmate-snippets" see vam#install#RewriteName()
  " also see section "5. Installing plugins" in VAM's documentation
  " which will tell you how to find the plugin names of a plugin
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]


map <C-d> :NERDTreeToggle <CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <D-p> :TlistToggle<CR>

colorscheme mayansmoke


let NERDTreeIgnore=['\~$','.*\.pyc$']
let NERDTreeQuitOnOpen=1
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
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
au BufNewFile,BufRead *.coffee set ft=coffee.jquery

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['coffee'] = 'coffee,jquery'






