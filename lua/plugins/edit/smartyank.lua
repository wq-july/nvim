return {
  ----------------------------------------------------------------------
  -- 高亮复制内容 & 复制到系统剪贴板
  ----------------------------------------------------------------------
  {
    "ibhagwan/smartyank.nvim",
    event = { "BufWinEnter" },
    opts = {
      highlight = {
        timeout = 500, -- 高亮消失时间，单位 ms
      },
      clipboard = {
        enabled = true, -- 同步到系统剪贴板
      },
      osc52 = {
        silent = true, -- 关闭 “n chars copied” 提示
      },
    },
  },
}
