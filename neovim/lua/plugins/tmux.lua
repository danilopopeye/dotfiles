-- .tmux.conf syntax highlighting and setting check

return {
  "tmux-plugins/vim-tmux",

  enabled = function()
    return vim.fn.executable("tmux") > 0
  end,

  ft = { "tmux" },
}
