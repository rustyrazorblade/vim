
set number
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
set ignorecase

set scrolljump=5

filetype on
filetype plugin on
filetype plugin indent on

map <leader>s g<c-]>

set textwidth=0

set linebreak
colorscheme wombat

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg
    echomsg "No VAM found!"
    echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  " call vam#ActivateAddons([], {'auto_install' : 1})
  call vam#ActivateAddons(['ack', 'The_NERD_tree','Tagbar', 'bufexplorer.zip','Conque_Shell','vim-coffee-script','Wombat','mayansmoke','SuperTab%182'], {'auto_install' : 1})
  call vam#ActivateAddons(['Syntastic'], {'auto_install' : 1})
  " call vam#ActivateAddons(['Markdown'], {'auto_install' : 1})
  call vam#ActivateAddons(['instant-markdown'], {'auto_install' : 1})

  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()


map <C-d> :NERDTreeToggle <CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <D-p> :TlistToggle<CR>


let NERDTreeIgnore=['\~$','.*\.pyc$']
let NERDTreeQuitOnOpen=0
let g:CommandTMaxHeight=20

map <Leader>a :Ack! 

map <Leader>p :TagbarToggle<CR>
let g:tagbar_autofocus = 1


set guifont=Inconsolata:h16  

"let tlist_php_settings = 'php;c:class;f:function'
" let Tlist_WinWidth = 40
" let Tlist_Sort_Type = "name"
" let Tlist_Auto_Highlight_Tag = 0
"
let NERDTreeChDirMode = 2

set expandtab

let g:pyflakes_use_quickfix = 0

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
let g:snipMate.scope_aliases['coffee'] = 'coffee,jquery,html'


let $MACOSX_DEPLOYMENT_TARGET = "10.7"


let $ACKRC=".ackrc"

" buf explorer
let g:bufExplorerDetailedHelp=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='name'
let g:bufExplorerFindActive=0

let g:CommandTMaxFiles=20000
let g:CommandTMaxDepth=20




