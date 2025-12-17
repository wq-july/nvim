-- nvim-scrollbar: 缩略图式滚动条
-- LazyVim 默认未自带
return {
  "petertriho/nvim-scrollbar",
  opts = {
    handelers = {
      gitsigns = true, -- 显示 Git hunk
      search = true,   -- 与 hlslens 配合显示搜索位置
    },
    marks = {
      Search = { color = "#CBA6F7" },
      GitAdd = { text = "┃" },
      GitChange = { text = "┃" },
      GitDelete = { text = "_" },
    },
  },
}
