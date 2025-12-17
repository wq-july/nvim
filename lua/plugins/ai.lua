return {

  ----------------------------------------------------------------------
  -- Copilot（只作为 AI provider，不接管 UI）
  ----------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- cmd 本身就会 lazy-load
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },

      -- 仅在文档类文件中启用
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  ----------------------------------------------------------------------
  -- CodeCompanion（Chat / Inline AI）
  ----------------------------------------------------------------------
  {
    "olimorris/codecompanion.nvim",

    -- 明确 lazy-load 触发条件
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.diff",
      "j-hui/fidget.nvim",
    },

    ------------------------------------------------------------------
    -- 提前初始化 spinner（避免 UI 问题）
    ------------------------------------------------------------------
    init = function()
      require("codecompanion_fidget_spinner"):init()
    end,

    ------------------------------------------------------------------
    -- 快捷键（Lazy.nvim 风格，去冗余）
    ------------------------------------------------------------------
    keys = {
      { "<leader>cca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Actions" },
      { "<leader>cci", "<cmd>CodeCompanion<cr>",        mode = { "n", "v" }, desc = "CodeCompanion: Inline" },
      { "<leader>ccc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Chat Toggle" },
      { "<leader>ccp", "<cmd>CodeCompanionChat Add<cr>",    mode = "v", desc = "CodeCompanion: Add selection to chat" },
    },

    ------------------------------------------------------------------
    -- 插件配置
    ------------------------------------------------------------------
    opts = {

      -- Diff 显示（与 LazyVim 生态兼容）
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },

      -- AI 策略：统一走 Copilot
      strategies = {
        chat   = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },

      -- CodeCompanion 自身配置（命名略奇怪，这是插件设计）
      opts = {
        language = "English", -- 可改为 "Chinese"
      },
    },
  },
}
