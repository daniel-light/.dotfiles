set modelines=0 " http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html

" set this above the call to pathogen (so it doesn't get set off)
let g:go_disable_autoinstall = 1

call pathogen#infect()
call pathogen#helptags()

" set mouse= " rodents, man

set autoread " automatically reload buffers that have changed on disk
au FocusGained,BufEnter * :checktime " hopefully notice when files do change
au FocusLost * silent! wa " hopefully save things when focus is lost
au BufWrite * silent! :Neomake

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

" indent guides settings (black / darkgrey is default for dark colorschemes)
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=lightgrey

" indentation settings
set ai
set nosi
set ts=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
if has("autocmd")
  filetype plugin indent on
endif
syntax on

map ; :
noremap ' ;
map Q <Nop>
" J for Join, K for Krack?
nnoremap K mmi<cr><esc>`m

" tmux navigator plugin settings and mappings
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 0 " 0 is default

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

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

" fugitive leader key mappings
nnoremap \g   :Git
nnoremap \gd  :Gdiff
nnoremap \gg  :Ggrep
nnoremap \gl  :Glog
nnoremap \gs  :Gstatus
nnoremap \gci :Gcommit

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

cmap w!! w !sudo tee % > /dev/null

command! ReopenInSplit call ReopenInSplit()
