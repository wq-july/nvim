return {
  ----------------------------------------------------------------------
  -- 自动补全括号、引号等
  ----------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      -- 如果下一个字符是字母、数字或`.`，则不自动补全
      ignored_next_char = "[%w%.]",
    },
  },

  ----------------------------------------------------------------------
  -- undo 树可视化
  ----------------------------------------------------------------------
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "切换 Undo 树" }, -- 中文注释
    },
    init = function()
      vim.cmd([[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')

          " 如果目录不存在，递归创建
          if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
      endif
      ]])
    end,
  },

  ----------------------------------------------------------------------
  -- 注释插件
  ----------------------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    keys = {
      -- 行注释 / 取消注释
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "[Comment] 注释当前行" },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "[Comment] 注释选中行" },
      -- Ctrl + / 快捷键，同上
      { "<C-_>", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "[Comment] 注释当前行" },
      { "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "[Comment] 注释选中行" },
    },
    config = true, -- 使用默认配置
  },

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

  ----------------------------------------------------------------------
  -- TODO / FIXME 注释管理
  ----------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>st", function() require("snacks").picker.todo_comments({ keywords = { "TODO","FIX","FIXME","BUG","FIXIT","HACK","WARN","ISSUE" } }) end, desc = "[TODO] 仅选取重要待办" },
      { "<leader>sT", function() require("snacks").picker.todo_comments() end, desc = "[TODO] 显示所有待办" },
    },
    config = true,
  },

  ----------------------------------------------------------------------
  -- 扩展文本对象：surround
  ----------------------------------------------------------------------
  {
    "nvim-mini/mini.surround",
    version = "*",
    event = "BufReadPost",
    config = true,
    keys = {
      { "s", "<NOP>", mode = { "n", "x", "o" } }, -- 禁用默认 s 快捷键
    },
  },

  ----------------------------------------------------------------------
  -- 扩展文本对象：mini.ai
  ----------------------------------------------------------------------
  {
    "nvim-mini/mini.ai",
    version = "*",
    event = "BufReadPost",
    config = true,
  },

  ----------------------------------------------------------------------
  -- 多光标编辑
  ----------------------------------------------------------------------
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "BufReadPost",
    keys = {
      { "mI", function() require("multicursor-nvim").insertVisual() end, mode = "x", desc = "在选中区域插入多光标" },
      { "mA", function() require("multicursor-nvim").appendVisual() end, mode = "x", desc = "在选中区域追加多光标" },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      -- 多光标模式下，Esc 清除所有光标
      mc.addKeymapLayer(function(layerSet)
        layerSet("n", "<esc>", function() mc.clearCursors() end)
      end)
    end,
  },

  ----------------------------------------------------------------------
  -- Wakatime 统计代码时长
  ----------------------------------------------------------------------
  { "wakatime/vim-wakatime", lazy = false },
}
