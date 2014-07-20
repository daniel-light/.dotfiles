let g:go_highlight_trailing_whitespace_error = 0
setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e
