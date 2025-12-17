return {
  {
    -- VSCode 主题
    "Mofiqul/vscode.nvim",
    name = "vscode",
    priority = 1000,
    lazy = false,
    opts = {
      -- 启用透明背景
      transparent = false,
      -- 启用斜体注释
      italic_comments = true,
      -- 禁用 nvim-tree 背景色
      disable_nvimtree_bg = true,
      -- 应用主题颜色到终端
      terminal_colors = true,
      -- 自定义高亮
      color_overrides = {
        -- 可以在这里自定义颜色
      },
      group_overrides = {
        -- 可以在这里覆盖特定高亮组
      },
    },
    config = function(_, opts)
      -- 设置背景为深色
      vim.o.background = "dark"
      
      -- 加载并配置 vscode 主题
      require("vscode").setup(opts)
      
      -- 应用主题
      vim.cmd.colorscheme("vscode")
      
      -- VSCode 主题颜色覆盖（使用不透明背景）
      vim.cmd([[
        " 主背景色（VSCode 标准背景色）
        highlight Normal guibg=#1e1e1e ctermbg=234
        highlight NormalNC guibg=#1e1e1e ctermbg=234
        
        " 分割线
        highlight VertSplit guibg=#3e3e42 ctermbg=237 guifg=#3e3e42 ctermfg=237
        
        " 符号列
        highlight SignColumn guibg=#1e1e1e ctermbg=234
        
        " NvimTree
        highlight NvimTreeNormal guibg=#252526 ctermbg=235
        highlight NvimTreeEndOfBuffer guibg=#252526 ctermbg=235
        highlight NvimTreeVertSplit guibg=#252526 ctermbg=235
        
        " BufferLine
        highlight BufferLineBackground guibg=#1e1e1e ctermbg=234
        highlight BufferLineFill guibg=#1e1e1e ctermbg=234
        
        " 弹出菜单
        highlight Pmenu guibg=#252526 ctermbg=235
        highlight PmenuSel guibg=#094771 ctermbg=24
        
        " 浮动窗口
        highlight NormalFloat guibg=#252526 ctermbg=235
        highlight FloatBorder guibg=#252526 ctermbg=235 guifg=#3e3e42 ctermfg=237
        
        " Barbar 使用 VSCode 主题颜色
        highlight BufferCurrent guibg=#1e1e1e guifg=#ffffff
        highlight BufferCurrentIndex guibg=#1e1e1e guifg=#569cd6
        highlight BufferCurrentMod guibg=#1e1e1e guifg=#dcdcaa
        highlight BufferCurrentSign guibg=#1e1e1e guifg=#569cd6
        highlight BufferCurrentTarget guibg=#1e1e1e guifg=#f48771
        highlight BufferVisible guibg=#252526 guifg=#cccccc
        highlight BufferVisibleIndex guibg=#252526 guifg=#569cd6
        highlight BufferVisibleMod guibg=#252526 guifg=#dcdcaa
        highlight BufferVisibleSign guibg=#252526 guifg=#569cd6
        highlight BufferVisibleTarget guibg=#252526 guifg=#f48771
        highlight BufferInactive guibg=#2d2d30 guifg=#858585
        highlight BufferInactiveIndex guibg=#2d2d30 guifg=#858585
        highlight BufferInactiveMod guibg=#2d2d30 guifg=#dcdcaa
        highlight BufferInactiveSign guibg=#2d2d30 guifg=#858585
        highlight BufferInactiveTarget guibg=#2d2d30 guifg=#f48771
        highlight BufferTabpageFill guibg=#1e1e1e guifg=#1e1e1e
        highlight BufferTabpages guibg=#1e1e1e guifg=#569cd6
      ]])
    end,
  },
}
