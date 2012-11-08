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
set foldmethod=syntax
set nofoldenable
set wildignore+=.DS_Store,node_modules,live-dump

" mark unnecessary whitespace
autocmd BufRead * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead * match BadWhitespace /^\t\+/
autocmd BufRead * match BadWhitespace /\s\+$/

" html js css complete ruby xml
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setl omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
autocmd FileType ruby setl omnifunc=rubycomplete#Complete
autocmd FileType php setl omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
autocmd FileType coffee setl foldmethod=indent|setl foldlevel=1

" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" map leader
let mapleader = ","

" save on lost focus
au FocusLost * :wa

" make ; act like a :
nnoremap ; :

" don't mess with wrap movement
nnoremap j gj
nnoremap k gk

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
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" powerstatus
set laststatus=2
let g:Powerline_symbols = 'fancy'

" ctrlp
nmap <silent> <leader>b :CtrlPBuffer<CR>
nmap <silent> <leader>m :CtrlPMRU<CR>
let g:ctrlp_working_path_mode = ''
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_max_height = 15

" syntastic
let g:syntastic_coffee_lint_options='max_line_length=0'

" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>

" tagbar
nmap <silent> <leader>g :TagbarToggle<CR>
nmap <silent> <leader>G :TagbarOpenAutoClose<CR>

" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" solarized
set t_Co=256
set background=dark
colorscheme tomorrow-night

" Vim functions to run RSpec and Cucumber on the current file and optionally on
" the spec/scenario under the cursor.

function! RailsScriptIfExists(name)
  " Bundle exec
  if isdirectory(".bundle") || (exists("b:rails_root") && isdirectory(b:rails_root . "/.bundle"))
    return "bundle exec " . a:name
    " System Binary
  else
    return a:name
  end
endfunction

function! RunSpec(args)
  let spec = RailsScriptIfExists("rspec --drb")
  let cmd = spec . " " . a:args . " -fn -c " . @%
  execute ":! echo " . cmd . " && " . cmd
endfunction

function! RunCucumber(args)
  let cucumber = RailsScriptIfExists("cucumber --drb")
  let cmd = cucumber . " " . @% . a:args
  execute ":! echo " . cmd . " && " . cmd
endfunction

function! RunTestFile(args)
  if @% =~ "\.feature$"
    call RunCucumber("" . a:args)
  elseif @% =~ "\.rb$"
    call RunSpec("" . a:args)
  end
endfunction

function! RunTest(args)
  if @% =~ "\.feature$"
    call RunCucumber(":" . line('.') . a:args)
  elseif @% =~ "\.rb$"
    call RunSpec("-l " . line('.') . a:args)
  end
endfunction

map <Leader>r :call RunTest("")<CR>
map <Leader>t :call RunTestFile("")<CR> 
