return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'arkav/lualine-lsp-progress' },

  opts = {
    options = {
      theme = "base16",
      -- Disable sections and component separators
      component_separators = '|',
      section_separators = '',
    },
    extensions = {
      'lazy',
      'mason',
      'quickfix',
      'trouble',
    },
    sections = {
      lualine_c = {
        'filename',
        'lsp_progress',
      },
    },
  },
}
