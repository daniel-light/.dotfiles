setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup file_type_markdown
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END
