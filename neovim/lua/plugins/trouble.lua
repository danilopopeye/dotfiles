return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle<cr>" },
    {
      "<leader>tw",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      desc = "workspace diagnostics from the builtin LSP client"
    },
    {
      "<leader>td",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "document diagnostics from the builtin LSP client"
    },
  },
  opts = {
    severity = "ERROR",          -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    auto_open = true,            -- automatically open the list when you have diagnostics
    auto_close = true,           -- automatically close the list when you have no diagnostics
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  },
}
