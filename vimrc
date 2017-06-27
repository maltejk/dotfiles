call plug#begin('~/.vim/plugged')
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim2hs'
Plug 'dhruvasagar/vim-table-mode'
Plug 'eagletmt/neco-ghc'
Plug 'eiiches/vim-rainbowbrackets'
Plug 'jhradilek/vim-rng'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'rodjek/vim-puppet'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dpc/vim-smarttabs'
call plug#end()

set textwidth=100
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent copyindent
set mouse=a clipboard=unnamedplus
set nu background=dark hidden
set ruler cursorline
set foldmethod=indent foldlevel=9999 foldcolumn=3
set iskeyword-=_ 
"set cryptmethod=blowfish2
syntax on

inoremap <C-@> <C-x><C-o>

let $RUST_SRC_PATH="/usr/local/src/rust/src/"
let g:neocomplete_enable_at_startup = 1

let g:haskellmode_completion_ghc = 0
let g:haskell_conceal = 0
let g:haskell_conceal_enumerations = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"let g:table_mode_corner_corner = '+'
"let g:table_mode_header_fillchar = '='
let g:table_mode_corner="|"

let g:pandoc#formatting#mode = "h"
let g:pandoc#spell#enabled = 0

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
let g:rainbowbrackets_enable_angle_brackets = 1

augroup vimrc-rainbowbrackets
	autocmd!
	autocmd FileType haskell let b:rainbowbrackets_enable_angle_brackets = 0
	autocmd FileType haskell let b:rainbowbrackets_enable_curly_brackets = 0
augroup END

map <Leader>n <plug>NERDTreeTabsToggle<CR>

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

