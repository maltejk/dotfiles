" https://github.com/junegunn/vim-plug/blob/master
call plug#begin('~/.vim/plugged')
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
" https://github.com/dhruvasagar/vim-table-mode
Plug 'dhruvasagar/vim-table-mode'
" https://github.com/eiiches/vim-rainbowbrackets
Plug 'eiiches/vim-rainbowbrackets'
" https://github.com/vim-syntastic/syntastic
Plug 'vim-syntastic/syntastic'
" https://github.com/dpc/vim-smarttabs
Plug 'dpc/vim-smarttabs'
" https://github.com/NLKNguyen/papercolor-theme
Plug 'NLKNguyen/papercolor-theme'
call plug#end()


set t_Co=256
colorscheme PaperColor

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

set magic
" set textwidth=100
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent copyindent
set number background=light laststatus=2
set clipboard=unnamedplus
set hlsearch
set ruler cursorline
set foldmethod=indent foldlevel=9999 foldcolumn=3
set iskeyword-=_

set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set list

syntax on

" don't override that. seriously
filetype plugin indent off

inoremap <C-@> <C-x><C-o>

let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='
let g:table_mode_corner="|"

set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au BufRead,BufNewFile *.asm set filetype=nasm
au BufRead,BufNewFile *.nix set filetype=yaml
au BufRead,BufNewFile *.pp  set filetype=puppet

let g:rainbowbrackets_enable_round_brackets = 1
let g:rainbowbrackets_enable_curly_brackets = 1
let g:rainbowbrackets_enable_square_brackets = 1
let g:rainbowbrackets_enable_angle_brackets = 0

augroup gentoo
	au!

	au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
	au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

	autocmd BufReadPost *
		\ if ! exists("g:leave_my_cursor_position_alone") |
		\     if line("'\"") > 0 && line ("'\"") <= line("$") |
		\         exe "normal! g'\"" |
		\     endif |
		\ endif

	autocmd FileType crontab set backupcopy=yes

	autocmd BufReadPost *
		\ if exists("g:added_fenc_utf8") && &fileencoding == "utf-8" &&
		\    ! &bomb && search('[\x80-\xFF]','nw') == 0 && &modifiable |
		\       set fileencoding= |
		\ endif
augroup END

let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(400,999),",")
