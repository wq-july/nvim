return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "NvimTreeToggle", -- 懒加载触发
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>f", ":NvimTreeFocus<CR>",  desc = "Focus NvimTree" },
    },
    opts = {
      ------------------------------------------------------------------
      -- 基础外观
      ------------------------------------------------------------------
      hijack_netrw = true,      -- 接管 netrw
      open_on_tab = false,      -- 打开新 tab 时不自动打开
      sync_root_with_cwd = true, -- 文件树跟随 cwd
      respect_buf_cwd = true,   -- 新建窗口使用当前 buffer 的 cwd

      ------------------------------------------------------------------
      -- 视图设置
      ------------------------------------------------------------------
      view = {
        width = 35,
        side = "left",
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        preserve_window_proportions = true,
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
      -- 行为设置
      ------------------------------------------------------------------
      update_focused_file = {
        enable = true,          -- 光标移动时自动定位到文件
        update_root = true,     -- 更新树根到当前文件夹
      },
      hijack_cursor = true,      -- 打开文件时光标移动到文件
      reload_on_bufenter = true, -- 自动刷新

      ------------------------------------------------------------------
      -- 文件过滤
      ------------------------------------------------------------------
      filters = {
        dotfiles = true,    -- 隐藏 . 开头文件
        custom = { ".git", "node_modules", "__pycache__" },
        exclude = {},       -- 排除隐藏（可选）
      },

      ------------------------------------------------------------------
      -- 图标
      ------------------------------------------------------------------
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_modifier = ":t", -- 仅显示文件夹名
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
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
      -- 快捷键与搜索栏
      ------------------------------------------------------------------
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- 搜索栏（类似旧版本顶部栏）
        vim.keymap.set("n", "/", api.tree.search_node, opts("Search Node"))

        -- 打开文件/关闭树
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))

        -- 刷新
        vim.keymap.set("n", "R", api.tree.reload, opts("Reload"))
      end,

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
