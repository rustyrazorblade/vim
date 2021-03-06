" Vim compiler file
" Compiler:	PHP
" Maintainer:	Doug Kearns <djkea2@gus.gscit.monash.edu.au>
" URL:		http://gus.gscit.monash.edu.au/~djkea2/vim/compiler/php.vim
" Last Change:	2004 Nov 27

if exists("current_compiler")
  finish
endif
let current_compiler = "erlang"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=erlc\ -pa src -o ebin

CompilerSet errorformat=%E<b>Parse\ error</b>:\ %m\ in\ <b>%f</b>\ on\ line\ <b>%l</b><br\ />,
			       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
