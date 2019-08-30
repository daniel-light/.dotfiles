set expandtab
set softtabstop=4
set shiftwidth=4

setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e

let b:ale_linters = ['pylint']
let b:ale_fixers = ['yapf']

" From google_python_style.vim

setlocal indentexpr=ftplugin#python#GetGooglePythonIndent(v:lnum)
