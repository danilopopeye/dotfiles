return {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'gbrlsnchs/telescope-lsp-handlers.nvim',
  },
  init = function()
    require('telescope').load_extension('lsp_handlers')
  end
}
