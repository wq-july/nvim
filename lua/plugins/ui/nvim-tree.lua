return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 移除自定义快捷键，使用 LazyVim 默认快捷键
    -- LazyVim 默认使用 <leader>e 来切换文件树
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = {
      ------------------------------------------------------------------
      -- 基础外观
      ------------------------------------------------------------------
      hijack_netrw = true,      -- 接管 netrw
      open_on_tab = false,      -- 打开新 tab 时不自动打开
      sync_root_with_cwd = false, -- 关闭自动同步根目录（性能优化）
      respect_buf_cwd = false,   -- 关闭自动跟随 buffer cwd（性能优化）

      ------------------------------------------------------------------
      -- 视图设置
      ------------------------------------------------------------------
      view = {
        width = 35,
        side = "left",
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        preserve_window_proportions = false, -- 关闭窗口比例保持（性能优化）
        -- 浮动窗口模式
        float = {
          enable = false, -- 默认侧边栏模式，如果想用浮动可以改 true
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 50,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },

      ------------------------------------------------------------------
      -- 行为设置（性能优化）
      ------------------------------------------------------------------
      update_focused_file = {
        enable = true,          -- 光标移动时自动定位到文件
        update_root = false,    -- 关闭自动更新根目录（性能优化，避免卡顿）
      },
      hijack_cursor = false,     -- 关闭光标劫持（性能优化）
      reload_on_bufenter = false, -- 关闭自动刷新（性能优化，避免卡顿）

      ------------------------------------------------------------------
      -- 文件过滤
      ------------------------------------------------------------------
      filters = {
        dotfiles = true,    -- 隐藏 . 开头文件
        custom = { ".git", "node_modules", "__pycache__" },
        exclude = {},       -- 排除隐藏（可选）
      },

      ------------------------------------------------------------------
      -- 图标（性能优化）
      ------------------------------------------------------------------
      renderer = {
        highlight_git = false,           -- 关闭 git 高亮（性能优化）
        highlight_opened_files = "none", -- 关闭打开文件高亮（性能优化）
        root_folder_modifier = ":t",     -- 仅显示文件夹名
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,                  -- 关闭 git 图标（性能优化）
          },
          glyphs = {
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
            git = {
              unstaged  = "",
              staged    = "S",
              unmerged  = "",
              renamed   = "➜",
              untracked = "U",
              deleted   = "",
              ignored   = "◌",
            },
          },
        },
      },

      ------------------------------------------------------------------
      -- 快捷键与搜索栏（使用 LazyVim 默认快捷键）
      ------------------------------------------------------------------
      -- 移除自定义 on_attach，使用 LazyVim 默认的快捷键映射
      -- 如果需要自定义，可以通过 LazyVim 的配置方式添加

      ------------------------------------------------------------------
      -- 系统配置
      ------------------------------------------------------------------
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      actions = {
        use_system_clipboard = true, -- 复制到系统剪贴板
      },
    },
  },
}
