return {
  ----------------------------------------------------------------------
  -- 跳转插件 Flash.nvim
  ----------------------------------------------------------------------
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    opts = {
      label = {
        rainbow = { enabled = true, shade = 1 }, -- 彩虹标签
      },
      modes = {
        char = { enabled = false }, -- 禁用单字符模式
      },
    },
    keys = {
      { "<leader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[Flash] 跳转" },
      { "<leader>F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[Flash] Treesitter 跳转" },
      { "<leader>F", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "[Flash] Treesitter 搜索" },
      { "<c-f>",     mode = { "c" }, function() require("flash").toggle() end, desc = "[Flash] 命令行搜索切换" },
      {
        "<leader>j",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 }, matches = false },
            jump = { pos = "end" },
            pattern = "^\\s*\\S\\?", -- 匹配非空行首第一个字符
          })
        end,
        desc = "[Flash] 行首跳转",
      },
      {
        "<leader>k",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 }, matches = false },
            jump = { pos = "end" },
            pattern = "^\\s*\\S\\?",
          })
        end,
        desc = "[Flash] 行首跳转",
      },
    },
  },
}
