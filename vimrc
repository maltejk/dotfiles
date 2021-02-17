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
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'
" https://github.com/NLKNguyen/papercolor-theme
Plug 'NLKNguyen/papercolor-theme'
" https://github.com/stevearc/vim-arduino
Plug 'stevearc/vim-arduino'
" https://vimawesome.com/plugin/vim-ansible-yaml
Plug 'chase/vim-ansible-yaml'
" https://github.com/hashivim/vim-terraform
Plug 'hashivim/vim-terraform'
" https://github.com/mustache/vim-mustache-handlebars
Plug 'mustache/vim-mustache-handlebars'
" https://github.com/tpope/vim-vinegar
Plug 'tpope/vim-vinegar'
" airline
"Plug 'vim-airline/vim-airline'
" nerdtree
"Plug 'scrooloose/nerdtree'
call plug#end()

set backspace=indent,eol,start
set splitright

set cursorcolumn

set t_Co=256
colorscheme PaperColor
let g:PaperColor_Theme_Options = {
	\   'theme': {
		\     'default': {
			\       'transparent_background': 1
				\     }
		\   }
	\ }

let g:lightline = {
	\ 'colorscheme': 'PaperColor_light',
	\ }

set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set laststatus=1

set magic
" set textwidth=100
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab autoindent copyindent
set number background=light laststatus=2
set clipboard^=unnamed,unnamedplus
set hlsearch
set ruler cursorline
set foldmethod=indent foldlevel=9999 foldcolumn=3
set iskeyword-=_

set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set list

au VimLeave * :!clear

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
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_ansible_checkers = ['ansible_lint']

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

set modeline
set modelines=5

" set the undo directory and disable swap files
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set backup
set swapfile

""""""" nerdtree configuration """""""
" open nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>
" open nerdtree if no file was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim automatically if nerdtree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" close nerdtree after opening a file
let NERDTreeQuitOnOpen = 0
" automatically delete buffer when deleting a file with nerdtree
let NERDTreeAutoDeleteBuffer = 1
" show hidden files by default
let NERDTreeShowHidden=1
" change default arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

""""""" nerdtree git configuration """""""
" hide brackets around symbols
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0
" custom symbols
"let g:NERDTreeGitStatusIndicatorMapCustom = {
            "\ 'Modified'  :'✹',
            "\ 'Staged'    :'✚',
            "\ 'Untracked' :'✭',
            "\ 'Renamed'   :'➜',
            "\ 'Unmerged'  :'═',
            "\ 'Deleted'   :'✖',
            "\ 'Dirty'     :'✗',
            "\ 'Ignored'   :'☒',
            "\ 'Clean'     :'✔︎',
            "\ 'Unknown'   :'?',
            "\ }

