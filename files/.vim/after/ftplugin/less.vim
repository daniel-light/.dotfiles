set expandtab
set softtabstop=2
set shiftwidth=2

setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e

" let g:neomake_less_enabled_makers = ['lessc']
