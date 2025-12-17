-- barbar.nvim: Buffer 标签栏
-- LazyVim 默认未安装 barbar，可直接添加
return {
  "romgrk/barbar.nvim",
  version = "^1.0.0",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- 关闭自动配置，由自己配置 keymaps
    vim.g.barbar_auto_setup = false
  end,
  lazy = false,
  keys = {
    { "<A-<>", "<CMD>BufferMovePrevious<CR>", desc = "移动 Buffer 左" },
    { "<A->>", "<CMD>BufferMoveNext<CR>",     desc = "移动 Buffer 右" },
    { "<A-1>", "<CMD>BufferGoto 1<CR>",       desc = "切换到 Buffer 1" },
    { "<A-2>", "<CMD>BufferGoto 2<CR>",       desc = "切换到 Buffer 2" },
    { "<A-3>", "<CMD>BufferGoto 3<CR>",       desc = "切换到 Buffer 3" },
    { "<A-4>", "<CMD>BufferGoto 4<CR>",       desc = "切换到 Buffer 4" },
    { "<A-5>", "<CMD>BufferGoto 5<CR>",       desc = "切换到 Buffer 5" },
    { "<A-6>", "<CMD>BufferGoto 6<CR>",       desc = "切换到 Buffer 6" },
    { "<A-7>", "<CMD>BufferGoto 7<CR>",       desc = "切换到 Buffer 7" },
    { "<A-8>", "<CMD>BufferGoto 8<CR>",       desc = "切换到 Buffer 8" },
    { "<A-9>", "<CMD>BufferGoto 9<CR>",       desc = "切换到 Buffer 9" },
    { "<A-h>", "<CMD>BufferPrevious<CR>",     desc = "上一个 Buffer" },
    { "<A-l>", "<CMD>BufferNext<CR>",         desc = "下一个 Buffer" },
  },
  opts = {
    animation = false,
    auto_hide = 1, -- buffer 少于 1 时自动隐藏 tabline
    sidebar_filetypes = { NvimTree = true }, -- 避免 sidebar 重叠
  },
}
