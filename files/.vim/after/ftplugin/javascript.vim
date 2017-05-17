set expandtab
set softtabstop=2
set shiftwidth=2

setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup file_type_javascript
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

let g:neomake_javascript_enabled_makers = ['eslint']

function! LintFix()
  !eslint --fix %
endfunction

command! LintFix call LintFix()
