set noexpandtab
set ts=4
set shiftwidth=4

setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e
