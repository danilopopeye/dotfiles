set nocompatible

" pathogen
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

syntax on

" options
set showmode
set showmatch
set hidden
set number
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab
set ignorecase
set smartcase
set hlsearch
set incsearch
set visualbell
set noerrorbells
set nobackup
set noswapfile
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist
set backspace=indent,eol,start
set scrolloff=3
set pastetoggle=<F2>

" remove unnecessary whitespace
autocmd BufRead * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead * match BadWhitespace /^\t\+/
autocmd BufRead * match BadWhitespace /\s\+$/
" autocmd BufWritePre * :%s/\s\+$//e

" html js css complete ruby xml
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" save on lost focus
au FocusLost * :wa

" make ; act like a :
nnoremap ; :

" dont use arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" don't fuck with arrow keys
set t_ku=OA
set t_kd=OB
set t_kr=OC
set t_kl=OD

" tab navigation
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-d> :tabclose<CR>
nnoremap <C-o> :tabnew<CR>

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" powerstatus
set laststatus=2
let g:Powerline_symbols = 'fancy'

" Command-T
let g:CommandTMaxHeight = 15
set wildignore+=.git,node_modules
nmap <silent> <C-T> :CommandT<CR>
nmap <silent> <C-B> :CommandTBuffer<CR>
nmap <silent> <C-F12> :CommandTFlush<CR>

" solarized
set t_Co=256
set background=dark
colorscheme solarized
