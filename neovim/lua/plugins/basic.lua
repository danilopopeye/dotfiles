return {
  -- Smart and Powerful commenting plugin for neovim
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      local commentstring_avail, commentstring =
          pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return commentstring_avail
          and commentstring
          and { pre_hook = commentstring.create_pre_hook() }
          or {}
    end,
  },

  -- Super fast git decorations implemented purely in Lua
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      attach_to_untracked = false,
    },
  },

  -- Neovim plugin for make golang development easiest
  {
    "olexsmir/gopher.nvim",
    event = "VeryLazy",
    requires = { -- dependencies
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
