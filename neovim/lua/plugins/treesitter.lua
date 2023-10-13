return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-refactor",
  },

  event = { "VeryLazy" },
  build = ":TSUpdate",

  opts = {
    auto_install = true,
    ensure_installed = {
      "bash", "csv", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitignore", "go", "gomod", "gosum",
      "gowork", "html", "javascript", "json", "lua", "markdown", "markdown_inline", "query", "sql", "ssh_config",
      "terraform", "toml", "vim", "vimdoc", "xml", "yaml",
    },
    highlight = {
      enable = true,
      disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
    },
    autotag = { enable = true },
    context_commentstring = { enable = true },
    -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
