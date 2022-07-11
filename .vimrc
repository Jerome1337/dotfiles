set nocompatible

call plug#begin(stdpath('data') . '/plugged')
	Plug 'jiangmiao/auto-pairs'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'vim-scripts/cream-showinvisibles'
	Plug 'vim-scripts/DeleteTrailingWhitespace'
	Plug 'ekalinin/dockerfile.vim'
	Plug 'mattn/emmet-vim'
	Plug 'yggdroot/indentline'
	Plug 'itchyny/lightline.vim'
	Plug 'vim-scripts/matchit.zip'
	Plug 'rose-pine/neovim', {'as': 'rose-pine', 'tag': 'v1.*'}
	Plug 'preservim/nerdcommenter'
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'myusuf3/numbers.vim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'scrooloose/syntastic'
	Plug 'preservim/tagbar'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tpope/vim-fugitive'
	Plug 'itchyny/vim-gitbranch'
	Plug 'airblade/vim-gitgutter'
	Plug 'elzr/vim-json'
	Plug 'farmergreg/vim-lastplace'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'sheerun/vim-polyglot'
	Plug 'chrisbra/vim-show-whitespace'
	Plug 'tpope/vim-surround'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

set termguicolors

set background=dark
set t_Co=256
set encoding=utf8

lua << EOF
require('rose-pine').setup({
	disable_background = true,
	disable_italics = true,
})
EOF

colorscheme rose-pine

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd BufEnter * NERDTreeMirror
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

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

set tabstop=2
set noexpandtab
set listchars=tab:\|\ ,trail:■,extends:>,precedes:<,nbsp:+
set list
set colorcolumn=120
highlight ColorColumn guibg=#524f67

let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

set nornu

set laststatus=2
set noshowmode
set guicursor=i:block

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
	\ 'colorscheme': 'rosepine',
	\ 'active': {
		\ 'left': [
			\ [ 'mode', 'paste' ],
			\ [ 'gitbranch', 'readonly', 'filename', 'modified' ]
		\ ]
	\ },
	\ 'component_function': {
		\ 'gitbranch': 'gitbranch#name'
	\ },
\ }

let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_char = '|'
let g:indentLine_color_term = 239

let mapleader=','

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set guifont=Fira\ Code:h14

lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules"}
  }
}
EOF
