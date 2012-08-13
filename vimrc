set nocompatible

" pathogen
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
filetype plugin on

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
set expandtab
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
set title
set cursorline
set foldenable

autocmd VimEnter * call Pl#Load()

" remove unnecessary whitespace
autocmd BufRead * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead * match BadWhitespace /^\t\+/
autocmd BufRead * match BadWhitespace /\s\+$/

" html js css complete ruby xml
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setl omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
autocmd FileType ruby setl omnifunc=rubycomplete#Complete
autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
autocmd FileType coffee setl tabstop=2|setl shiftwidth=2|setl softtabstop=2|setl foldmethod=indent|setl foldlevel=1

" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" map leader
let mapleader = ","

" save on lost focus
au FocusLost * :wa

" make ; act like a :
nnoremap ; :

" clear search highlighting
nnoremap <silent> <leader>/ :nohlsearch<CR>

" window splitting
nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>

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
nmap <silent> <leader>t :CommandT<CR>
nmap <silent> <leader>b :CommandTBuffer<CR>
nmap <silent> <C-F12> :CommandTFlush<CR>

" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>

" tagbar
nmap <silent> <leader>g :TagbarToggle<CR>
nmap <silent> <leader>G :TagbarOpenAutoClose<CR>

" solarized
set t_Co=256
set background=dark
colorscheme solarized
