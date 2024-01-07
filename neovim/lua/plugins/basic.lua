return {
  -- A useful plugin that can comment out your code with keybindings
  -- { 'shoukoo/commentary.nvim' },

  -- Smart and Powerful commenting plugin for neovim
  { 'numToStr/Comment.nvim', 
    event = "VeryLazy",
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
  { 'lewis6991/gitsigns.nvim',
    opts = {
      attach_to_untracked = false,
    },
  },
}

-- Lightweight yet powerful formatter plugin for Neovim
-- stevearc/conform.nvim
