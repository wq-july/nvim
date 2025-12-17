-- which-key.nvim: 显示快捷键提示面板
-- LazyVim 默认已集成 which-key，但这里做自定义配置覆盖和优化
return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- 延迟加载，避免启动慢
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- 使用图标时依赖 web-devicons
  opts = {
    -- 可选值: false | "classic" | "modern" | "helix"
    preset = "helix", -- 使用 helix 风格提示
    win = {
      -- no_overlap = true, -- 禁止窗口重叠
      title = false,      -- 不显示标题
      width = 0.5,        -- 窗口占屏宽度比例
    },
    -- 定义快捷键分组和图标
    spec = {
      { "<leader>cc", group = "<CodeCompanion>", icon = "" }, -- 代码助手
      { "<leader>s",  group = "<Snacks>" },                     -- Snacks 插件
      { "<leader>t",  group = "<Snacks> Toggle" },             -- Snacks Toggle
    },
    -- 自动展开没有描述的节点
    expand = function(node)
      return not node.desc
    end,
  },
  keys = {
    -- 显示当前 buffer 的本地 keymaps
    {
      "<leader>?", 
      function() 
        require("which-key").show({ global = false }) 
      end,
      desc = "[Which-key] 显示当前 buffer 本地快捷键",
    },
  },
  config = function(_, opts)
    -- 直接调用 setup 初始化
    require("which-key").setup(opts)
  end,
}
