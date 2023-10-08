return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  dependencies = { 'arkav/lualine-lsp-progress' },

  opts = {
    options = {
      theme = "base16",
      -- Disable sections and component separators
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        'filename',
        'lsp_progress',
      },
    },
  },
}
