" vim:fdm=marker:fdl=3
" vim options {{{
set number          " Print the line number in front of each line
set relativenumber  " Show the line number relative to the cursor
set hidden          " When off a buffer is unloaded when it is abandoned
set splitbelow      " Put the new window below the current one
set splitright      " Put the new window right of the current one
set lazyredraw      " Do not redrawn while executing commands that have not been typed

let mapleader = ","	" Map `,` to <Leader>

" indentation
set smartindent     " Do smart autoindenting when starting a new line
set autoindent      " Copy indent from current line when starting a new line
set expandtab       " Use the appropriate number of spaces to insert a <Tab>
set tabstop=2       " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set softtabstop=2   " Number of spaces that a <Tab> counts for in editing operations

" Enable persistent undo so that undo history persists across vim sessions
set undofile

" A comma separated list of options for Insert mode completion
set completeopt=menu

" color and theme
set background=dark
try
  colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

" folding
set foldenable
set foldlevel=1
set foldmethod=syntax

highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" ignore stuff
set wildignore+=.git/**,.gitkeep,*.BACKUP.*,*.BASE.*,*.LOCAL.*,*.REMOTE.*
set wildignore+=vendor/**,coverage/**,tmp/**,*/tmp/*,*.so,*.swp,*.zip,log/**
set wildignore+=backup/**,*.sql,*.dump,*.tmp,*.min.js
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
" }}}
" vim mappings {{{
" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" don't mess with wrap movement
nnoremap j gj
nnoremap k gk

" dont use arrow keys :)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" tab navigation
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Copy to system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" Paste from system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

" window navigation
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" terminal navigation
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" search helpers
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" }}}
" vim-plug - plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat' " not sure
Plug 'tpope/vim-abolish' " not sure
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" languages and stuff
Plug 'pearofducks/ansible-vim'

" Golang land
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'jodosha/vim-godebug'

" complete and stuff
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

" Function argument completion for Deoplete
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'fszymanski/deoplete-emoji'

" session management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'edkolev/tmuxline.vim'

" Initialize plugin system
call plug#end()
" }}}
" fzf {{{
set rtp+=~/Homebrew/opt/fzf

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nmap <silent> <leader>f :FZF<CR>
nmap <silent> <leader>G :GFiles<CR>
nmap <silent> <leader>h :Helptags<CR>

nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>F :Files ~<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>r :Rg 

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"" }}}
" airline {{{
" Use powerline fonts on airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
" }}}
" deoplete {{{

" Enable deoplete when InsertEnter.
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
let g:neosnippet#enable_completed_snippet = 1

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Expand the completed snippet trigger by <CR>.
imap <expr><CR>
  \ (pumvisible() && neosnippet#expandable()) ?
  \ "\<Plug>(neosnippet_expand)" : "\<CR>"

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
  \ pumvisible() ? "\<C-n>" :
  \ neosnippet#expandable_or_jumpable() ?
  \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}
" Golang + vim-go {{{
let g:go_auto_type_info = 1
let g:go_autodetect_gopath = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_metalinter_command = "golangci-lint"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1

augroup go
  autocmd!
  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoDoc as vertical split
  autocmd FileType go nmap K <Plug>(go-doc-vertical)
  " Goto declaration/definition. Results are shown in a vertical split window.
  autocmd FileType go nmap <Leader>g <Plug>(go-def-vertical)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
"" }}}
