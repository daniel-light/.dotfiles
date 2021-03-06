set modelines=0 " http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html

" set this above the call to pathogen (so it doesn't get set off)
let g:go_disable_autoinstall = 1

let g:pathogen_disabled = ["neomake"]
call pathogen#infect()
call pathogen#helptags()

" set mouse= " rodents, man

set autoread " automatically reload buffers that have changed on disk
augroup autoready
  autocmd!
  au FocusGained,BufEnter * :checktime " hopefully notice when files do change
  au FocusLost * silent! wa " hopefully save things when focus is lost
  " au BufWritePost * silent! :Neomake
  " au BufRead * silent! :Neomake
augroup END

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 1 " default
" let g:ale_lint_on_save = 1 " default

" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

set ruler " the numbers in the lower right corner
set hidden " automatically hide modified buffers ons switch
set visualbell " mutes the audio bell

" you have to set both of these together to get the expected behavior
set ignorecase
set smartcase

" search / search coloring
set incsearch
set hlsearch
hi Search ctermfg=grey ctermbg=0
nnoremap n //<return>
nnoremap N ??<return>

" indent guides settings (black / darkgrey is default for dark colorschemes)
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=lightgrey

" active rainbow parentheses in case of emergency
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,clojurescript,scheme RainbowParenthesesActivate
augroup END
let g:rainbow#blacklist = [0]

" indentation settings
set ai
set nosi
set ts=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
augroup all_file_types
  autocmd!
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
if has("autocmd")
  filetype plugin indent on
endif
syntax on


" colors
highlight Pmenu ctermbg=brown
highlight PmenuSel ctermbg=lightgray cterm=bold ctermfg=darkred

" mappings
map ; :
noremap ' ;

" Never used it
nnoremap Q <Nop>

" I prefer cc and mostly hit this when I mean C
nnoremap S <Nop>

" J for Join, K for Krack?
nnoremap K mmi<cr><esc>`m

" nmap <Up> <c-y>k
" nmap <Down> <c-e>j

" tmux navigator plugin settings and mappings
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 0 " 0 is default

nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>

if has("nvim")
  tnoremap <silent> <m-h> <c-\><c-n>:TmuxNavigateLeft<cr>
  tnoremap <silent> <m-j> <c-\><c-n>:TmuxNavigateDown<cr>
  tnoremap <silent> <m-k> <c-\><c-n>:TmuxNavigateUp<cr>
  tnoremap <silent> <m-l> <c-\><c-n>:TmuxNavigateRight<cr>
end

runtime macros/matchit.vim

" map * in visual mode to search for the current selection
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" configure fzf
set rtp+=~/.dotfiles/build/fzf
nnoremap \t :FZF<cr>

" fugitive config
nnoremap \g   :G
:command Gs Gstatus
:command Gd Gdiff
:command Gci Gcommit

" autocomplete stuff
let g:SuperTabContextDefaultCompletionType = "<c-n>"

if has("nvim")
  " terminal mode!
  tnoremap <c-\> <c-\><c-n>
end

function! ReopenInSplit()
  execute "normal! \<c-^>"
  execute "vsplit #"
endfunction

" custom commands

cnoremap w!! w !sudo tee '%' > /dev/null

command! ReopenInSplit call ReopenInSplit()

" TODO I think we only need this in after/ftplugin/javascript.vim, but I'm not sure
let g:jsx_ext_required = 0 " allow jsx syntax in js files
