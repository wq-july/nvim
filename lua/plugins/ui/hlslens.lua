-- nvim-hlslens: 搜索高亮增强
-- LazyVim 默认未自带
return {
  "kevinhwang91/nvim-hlslens",
  -- keys = {
  --   { "n", "nzz<Cmd>lua require('hlslens').start()<CR>", desc = "下一个匹配", noremap = true, silent = true },
  --   { "N", "Nzz<Cmd>lua require('hlslens').start()<CR>", desc = "上一个匹配", noremap = true, silent = true },
  --   { "*", "*<Cmd>lua require('hlslens').start()<CR>", desc = "下一个匹配", noremap = true, silent = true },
  --   { "#", "#<Cmd>lua require('hlslens').start()<CR>", desc = "上一个匹配", noremap = true, silent = true },
  --   { "g*", "g*<Cmd>lua require('hlslens').start()<CR>", desc = "下一个匹配", noremap = true, silent = true },
  --   { "g#", "g#<Cmd>lua require('hlslens').start()<CR>", desc = "上一个匹配", noremap = true, silent = true },
  --   { "//", "<Cmd>noh<CR>", desc = "清除高亮", noremap = true, silent = true },
  -- },
  opts = {
    nearest_only = true,
  },
  config = function(_, opts)
    -- 与 scrollbar 配合
    require("scrollbar.handlers.search").setup(opts)
    vim.api.nvim_set_hl(0, "HlSearchLens", { link = "CurSearch" })
    vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#CBA6F7" })
  end,
}
