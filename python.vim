" The magical turn-Vim-into-a-Python-IDE vim resource file!
"
" Mostly taken from http://www.sontek.net/category/Vim.aspx
" Other bits culled from various sources, Canonical guys, or made up by me.
"
" Julian Edwards 2008-05-30
" Modified by Jonathan Haddad 2011-10-21

" More syntax highlighting.
" let python_highlight_all = 1

" Smart indenting
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
" set omnifunc=pythoncomplete#Complete
" inoremap <Nul> <C-x><C-o>
" Get this plugin from http://www.vim.org/scripts/script.php?script_id=1112
" Pressing "K" takes you to the documentation for the word under the cursor.
" autocmd filetype python source ~/.vim/pydoc.vim

set complete=.,w,b,u,t

" `gf` jumps to the filename under the cursor.  Point at an import statement
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Generate tags with: ctags -R -f ~/.vim/tags/python27.ctags /usr/lib/python2.7/
" ctrl-[ to go to the tag under the cursor, ctrl-T to go back.
"set tags+=$HOME/.vim/tags/python27.ctags

" Use :make to see syntax errors. (:cn and :cp to move around, :dist to see
" all errors)
" set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()

" Use F7/Shift-F7 to add/remove a breakpoint (ipdb.set_trace)
" Totally cool.
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sipdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import ipdb":
            break
    else:
        vim.current.buffer.append( 'import ipdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import ipdb" or strLine.lstrip()[:16] == "ipdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "map <s-f7> :py RemoveBreakpoints()<cr>")
EOF


