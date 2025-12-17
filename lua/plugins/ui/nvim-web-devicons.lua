-- nvim-web-devicons: 文件图标显示
-- LazyVim 默认已自带此插件，这里做覆盖配置示例
return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    override = {
      -- 自定义 Copilot 图标显示
      copilot = {
        icon = "",
        color = "#cba6f7", -- Catppuccin mocha.mauve 颜色
        name = "Copilot",
      },
    },
  },
}
