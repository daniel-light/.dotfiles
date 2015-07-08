" I think this needs configured above the call to pathogen
let g:go_disable_autoinstall = 1

call pathogen#infect()
call pathogen#helptags()

" you have to set both of these together to get the expected behavior
set ignorecase
set smartcase
set incsearch
set hlsearch

set hidden " automatically hide modified buffers ons switch

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
noremap ;; ;

" tmux navigator plugin settings and mappings
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 0 " 0 is default

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" automatically expand %% to the current buffer's directory
cnoremap <expr>	%% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

runtime macros/matchit.vim
