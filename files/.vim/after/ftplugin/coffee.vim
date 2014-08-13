set expandtab
set softtabstop=2
set shiftwidth=2

set foldmethod=indent nofoldenable

setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e
