call plug#begin('~/.vim/plugged')
	Plug 'artanikin/vim-synthwave84'
	Plug 'elzr/vim-json'
	Plug 'cespare/vim-toml'
	Plug 'scrooloose/nerdtree'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'vim-scripts/cream-showinvisibles'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'scrooloose/syntastic'
	"Plug 'valloric/youcompleteme'
	Plug 'mattn/emmet-vim'
	Plug 'fatih/vim-go'
	Plug 'vim-scripts/DeleteTrailingWhitespace'
	Plug 'chrisbra/vim-show-whitespace'
	Plug 'vim-airline/vim-airline'
	Plug 'pangloss/vim-javascript'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'ekalinin/dockerfile.vim'
	Plug 'stephpy/vim-yaml'
	Plug 'yggdroot/indentline'
	Plug 'myusuf3/numbers.vim'
	Plug 'vim-scripts/matchit.zip'
	Plug 'luochen1990/rainbow'
	Plug 'scrooloose/nerdcommenter'
	Plug 'airblade/vim-gitgutter'
	Plug 'jiangmiao/auto-pairs'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'ryanoasis/vim-devicons'
call plug#end()

if (has('termguicolors'))
	set termguicolors
endif

syntax enable
colorscheme synthwave84

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	split term://zsh
		resize 10
		endfunction
		nnoremap <c-n> :call OpenTerminal()<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_statusline_ontop = 1

set tabstop=2
set noexpandtab
set listchars=tab:\|\ ,trail:■,extends:>,precedes:<,nbsp:+
set list
set colorcolumn=121

set nornu

let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_char = '|'
let g:indentLine_color_term = 239

let g:rainbow_active = 1

let mapleader=","

set guifont=Fira\ Code:h12
