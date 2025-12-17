-- 禁用 netrw 插件（LazyVim 或 nvim-tree 等文件管理器会用到自己的文件浏览器）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 显示行号
vim.opt.number = true

-- 高亮当前行
vim.wo.cursorline = true

-- 显示制表符和行尾空格
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "-" }
-- 解释：
-- tab = ">-" ：制表符显示为 >-
-- trail = "-" ：行尾空格显示为 -

-- 搜索时忽略大小写
vim.opt.ignorecase = true

-- 当搜索包含大写字母时，启用大小写敏感
vim.opt.smartcase = true

-- 高亮搜索结果
vim.opt.hlsearch = true

-- 滚动时，光标上下保留至少 5 行
vim.opt.scrolloff = 5

-- 横向滚动时，光标左右保留至少 10 列
vim.opt.sidescrolloff = 10

-- 光标移动时，不强制跳到行首
vim.opt.startofline = false

-- conceallevel 控制隐藏文本标记（如 markdown 中的 ** 或 html 标签）
vim.opt.conceallevel = 2

-- 显示 sign column（用于 git、lint 或 lsp 等标记列）
vim.o.signcolumn = "yes:1"

-- 禁止自动换行
vim.wo.wrap = false

-- Tab / 缩进相关配置
vim.opt.softtabstop = 2    -- 插入时 tab 键占用空格数
vim.opt.shiftwidth = 2     -- 自动缩进占用空格数
vim.opt.expandtab = true   -- 使用空格替代制表符
vim.opt.smartindent = true -- 智能缩进，根据代码结构自动缩进

-- 新窗口默认在当前窗口下方打开
vim.opt.splitbelow = true

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


-- Snacks profiler
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end