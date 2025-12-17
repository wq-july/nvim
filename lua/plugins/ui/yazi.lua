-- yazi.nvim: 代码可视化浏览器
-- LazyVim 默认未自带
return {
  "mikavilpas/yazi.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    { "<leader>E>", "<CMD>Yazi<CR>", desc = "当前文件打开 Yazi" },
    { "<leader>cw", "<CMD>Yazi cwd<CR>", desc = "工作目录打开 Yazi" },
    { "<C-Up>", "<CMD>Yazi toggle<CR>", desc = "恢复上一次 Yazi 会话" },
  },
  opts = {
    open_for_directories = false,
    keymaps = { show_help = "<F1>" },
  },
  init = function()
    -- 禁用 netrw 防止冲突
    vim.g.loaded_netrwPlugin = 1
  end,
}
