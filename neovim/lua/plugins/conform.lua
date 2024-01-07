return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<Space>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gci", "gofumpt" },
      javascript = { { "prettierd", "prettier" } },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
