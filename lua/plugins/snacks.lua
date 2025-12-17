return {
  ----------------------------------------------------------------------
  -- Snacks.nvim - 全能工具插件（状态栏、picker、终端、动画、LSP 等）
  ----------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    -- LazyVim 默认已安装，设置 lazy=false 覆盖默认配置
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      -- 文件管理/性能
      bigfile = { enabled = true },      -- 支持大文件处理
      dashboard = { enabled = true },    -- 启动仪表盘
      explorer = { enabled = false },    -- 文件浏览器（禁用，使用 nvim-tree 或 neo-tree）
      
      -- 图片显示
      image = {
        enabled = true,
        doc = { inline = false, float = false, max_width = 80, max_height = 40 },
        math = { latex = { font_size = "small" } },
      },

      -- 缩进高亮
      indent = {
        enabled = true,
        animate = { enabled = false },     -- 禁用缩进动画
        indent = { only_scope = true },    -- 只显示作用域缩进线
        scope = { enabled = true, underline = true }, -- 当前作用域高亮并下划线
        chunk = { enabled = true },        -- 多行块渲染
      },

      -- 输入、终端和工具
      input = { enabled = true },
      terminal = { enabled = true },
      lazygit = { enabled = true, configure = false },
      notifier = { enabled = true, style = "notification" },
      quickfile = { enabled = true },
      scroll = { enabled = false }, -- 可选：滚动动画

      -- 文本对象和状态栏
      scope = { enabled = true, cursor = false }, 
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = { open = true, git_hl = false },
        refresh = 50,
      },

      -- 单词跳转
      words = { enabled = true },

      -- 弹窗风格
      styles = {
        terminal = {
          relative = "editor",
          border = "rounded",
          position = "float",
          backdrop = 60,
          height = 0.9,
          width = 0.9,
          zindex = 50,
        },
      },

      -- picker 配置
      picker = {
        enabled = true,
        previewers = {
          diff = { builtin = false, cmd = { "delta" } }, -- diff 外部工具 delta
          git  = { builtin = false, args = {} },        -- git 输出使用外部工具
        },
        sources = { spelling = { layout = { preset = "select" } } },
        layout = { preset = "telescope" },
        win = {
          input = {
            keys = {
              ["<Tab>"]    = { "select_and_prev", mode = { "i", "n" } },
              ["<S-Tab>"]  = { "select_and_next", mode = { "i", "n" } },
              ["<A-Up>"]   = { "history_back", mode = { "n", "i" } },
              ["<A-Down>"] = { "history_forward", mode = { "n", "i" } },
              ["<A-j>"]    = { "list_down", mode = { "n", "i" } },
              ["<A-k>"]    = { "list_up", mode = { "n", "i" } },
              ["<C-u>"]    = { "preview_scroll_up", mode = { "n", "i" } },
              ["<C-d>"]    = { "preview_scroll_down", mode = { "n", "i" } },
              ["<A-u>"]    = { "list_scroll_up", mode = { "n", "i" } },
              ["<A-d>"]    = { "list_scroll_down", mode = { "n", "i" } },
            },
          },
        },
      },
    },

    keys = {
      ------------------------------------------------------------------
      -- Buffer/Terminal/Image/Zen/Notifications
      ------------------------------------------------------------------
      { "<A-w>", function() require("snacks").bufdelete() end, desc = "[Snacks] 删除 buffer" },
      { "<leader>si", function() require("snacks").image.hover() end, desc = "[Snacks] 显示图片" },
      { "<A-i>", function() require("snacks").terminal() end, desc = "[Snacks] 切换终端", mode = {"n",  "t"} },
      { "<leader>sn", function() require("snacks").picker.notifications() end, desc = "[Snacks] 通知历史" },
      { "<leader>n",  function() require("snacks").notifier.show_history() end, desc = "[Snacks] 通知历史" },
      { "<leader>un", function() require("snacks").notifier.hide() end, desc = "[Snacks] 清除通知" },
      { "<leader>z",  function() require("snacks").zen() end, desc = "[Snacks] 切换禅模式" },
      { "<leader>Z",  function() require("snacks").zen.zoom() end, desc = "[Snacks] Zen 放大模式" },

      ------------------------------------------------------------------
      -- 文件、缓冲区、搜索
      ------------------------------------------------------------------
      { "<leader><space>", function() require("snacks").picker.smart() end, desc = "[Snacks] 智能搜索文件" },
      { "<leader>,",      function() require("snacks").picker.buffers() end, desc = "[Snacks] Buffers" },
      { "<leader>sf",     function() require("snacks").picker.files() end, desc = "[Snacks] 查找文件" },
      { "<leader>sp",     function() require("snacks").picker.projects() end, desc = "[Snacks] Projects" },
      { "<leader>sr",     function() require("snacks").picker.recent() end, desc = "[Snacks] 最近文件" },
      { "<leader>sg",     function() require("snacks").picker.grep() end, desc = "[Snacks] 全局搜索" },

      ------------------------------------------------------------------
      -- Git 功能
      ------------------------------------------------------------------
      { "<C-g>", function() require("snacks").lazygit() end, desc = "[Snacks] Lazygit" },
      { "<leader>ggl", function() require("snacks").picker.git_log() end, desc = "[Snacks] Git 日志" },
      { "<leader>ggd", function() require("snacks").picker.git_diff() end, desc = "[Snacks] Git diff" },
      { "<leader>ggb", function() require("snacks").git.blame_line() end, desc = "[Snacks] Git blame 当前行" },
      { "<leader>ggB", function() require("snacks").gitbrowse() end, desc = "[Snacks] Git 仓库浏览" },

      ------------------------------------------------------------------
      -- LSP 功能
      ------------------------------------------------------------------
      { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "[Snacks] 跳转到定义" },
      { "gD", function() require("snacks").picker.lsp_declarations() end, desc = "[Snacks] 跳转到声明" },
      { "gr", function() require("snacks").picker.lsp_references() end, desc = "[Snacks] LSP References" },
      { "gI", function() require("snacks").picker.lsp_implementations() end, desc = "[Snacks] 跳转到实现" },
      { "<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "[Snacks] LSP Symbols" },
    },

    init = function()
      local Snacks = require("snacks")
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- 全局调试工具
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd -- print 重载

          -- 核心 toggle 映射示例
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
          Snacks.toggle.option("wrap", { name = "换行" }):map("<leader>tw")
          Snacks.toggle.option("relativenumber", { name = "相对行号" }):map("<leader>tL")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "深色背景" }):map("<leader>tb")
        end,
      })
    end,
  },
}
