-- old VimL stuff {{{
vim.cmd([[
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
set completeopt=menu,menuone,noselect

" folding
" set foldenable
set foldlevel=3
set foldmethod=syntax

" trailing whitespace
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" ignore stuff
set wildignore+=.git/**,.gitkeep,*.BACKUP.*,*.BASE.*,*.LOCAL.*,*.REMOTE.*
set wildignore+=vendor/**,coverage/**,tmp/**,*/tmp/*,*.so,*.swp,*.zip,log/**
set wildignore+=backup/**,*.sql,*.dump,*.tmp,*.min.js
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF

" Spell check
set spelllang=pt,en  " Use a mix of Português+English for spell check

" neovim providers
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
" }}}
" filetypes options {{{
" Spell-check Markdown files and Git Commit Messages
autocmd FileType markdown,gitcommit setlocal spell

" Enable dictionary auto-completion in Markdown files and Git Commit Messages
autocmd FileType markdown,gitcommit setlocal complete+=kspell
" }}}
" vim mappings {{{
" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" Yank from the cursor to the end of the line, to be consistent with C and D
" nnoremap Y y$

" don't mess with wrap movement
nnoremap j gj
nnoremap k gk
nnoremap zV zMzv

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

" terminal navigation
tnoremap <Esc> <C-\><C-n>

" search helpers
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
" }}}
]])
-- }}}
-- mise {{{
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
-- }}}
-- lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  change_detection = {
    notify = false -- get a notification when changes are found
  },
})
-- }}}
-- map helper {{{
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- }}}
-- telescope {{{
map('n', '<leader>f', '<cmd>Telescope find_files<cr>')
map('n', '<leader>g', '<cmd>Telescope git_files<cr>')
map('n', '<leader>lg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

-- telescope-terraform-doc.nvim
-- map('n', '<leader>ott', ':Telescope terraform_doc<cr>')
-- map('n', '<leader>otm', ':Telescope terraform_doc modules<cr>')
-- }}}

-- try these
-- koenverburg/minimal-tabline.nvim
-- dstein64/vim-startuptime
-- catppuccin/nvim
-- magidc/nvim-config -- DAP config seems nice
-- https://github.com/ofirgall/cmp-lspkind-priority

-- Disable built-in statusline in Quickfix window
-- vim.g.qf_disable_statusline = 1

-- vim:fdm=marker:fdl=0
