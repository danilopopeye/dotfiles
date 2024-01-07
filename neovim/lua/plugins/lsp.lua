return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "bashls", "dockerls", "golangci_lint_ls", "gopls", "html", "jsonls",
        "lua_ls", "prosemd_lsp", "quick_lint_js", "spectral", "sqlls", "taplo",
        "yamlls",

        -- markdownlint
        -- yamllint
        -- eslint_d
        -- yaml-language-server yamlls, yamlls
        -- gopls
        -- json-lsp jsonls, jsonls
        -- vim-language-server vimls, vimls
        -- tflint
        -- shfmt
        -- terraform-ls terraformls, terraformls
        -- shellcheck
        -- jq
        -- hadolint
        -- golangci-lint
        -- dockerfile-language-server dockerls, dockerls
        -- bash-language-server bashls, bashls
        -- gofumpt
        -- editorconfig-checker
        -- eslint-lsp eslint, eslint
        -- fixjson
        -- gitlint
        -- goimports
        -- golangci-lint-langserver golangci_lint_ls, golangci_lint_ls
        -- golines
        -- html-lsp html, html
        -- lua-language-server lua_ls, lua_ls
        -- prosemd-lsp prosemd_lsp, prosemd_lsp
        -- quick-lint-js quick_lint_js, quick_lint_js
        -- spectral-language-server spectral, spectral
        -- sqlls
        -- taplo

      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    }
  },
  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config =function ()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-emoji' },
      { 'ray-x/cmp-treesitter' },
    },
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function(_)
      local lspconfig = require('lspconfig')
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- mason
      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
          end,
          gopls = function ()
            lspconfig.gopls.setup({
              settings = {
                symbolScope = "workspace",
                gopls = {
                  gofumpt = true,
                  staticcheck = true,
                  analyses = {
                    fieldalignment = true,
                    nilness = true,
                    shadow = true,
                    unusedparams = true,
                    unusedvariable = true,
                    unusedwrite = true,
                    useany = true,
                  },
                  hints = {
                    assignVariableTypes = true,
                    constantValues = true,
                    -- parameterNames = true,
                  },
                },
              },
            })
          end,
        },
      })

      -- cmp
      local lspkind = require('lspkind')
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip', max_item_count = 5 }, -- For luasnip users.
          { name = 'treesitter', max_item_count = 5, },
          { name = 'nvim_lsp' },
          { name = 'buffer', keyword_length = 3, max_item_count = 3 }, -- Only complete words > 5 chars
          { name = 'path', max_item_count = 10 },
          { name = 'emoji', max_item_count = 10 }, -- nvim-cmp source for emojis
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            menu = ({
              lua = "",
              buffer = "",
              nvim_lsp = "", -- 
              luasnip = "", -- 
              treesitter = "",
            }),
          })
        },

        mapping = cmp.mapping.preset.insert({
          -- Accept currently selected item. 
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                })
              else
                fallback()
              end
            end,
          }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = 'insert' })
            else
              cmp.complete()
            end
          end),
          ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = 'insert' })
            else
              cmp.complete()
            end
          end),

          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        })
      })

      -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' }
        }, {
          { name = 'buffer' }
        })
      })

      -- Use cmdline & path source for `:`
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline', keyword_length = 2 }
        })
      })
    end,
  },
}

--[[
-- lspkind {{{
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
-- }}}
]]
