return {
  ----------------------------------------------------------------------
  -- 自动会话管理插件
  ----------------------------------------------------------------------
  {
    "rmagatti/auto-session",
    -- 设置为非延迟加载，启动时立即生效
    lazy = false,

    -- 快捷键映射
    keys = {
      -- <leader>ps -> 恢复最近的会话
      { "<leader>ps", "<CMD>SessionRestore<CR>", desc = "[Auto Session] Restore session" },
      -- <leader>pS -> 搜索已有会话
      { "<leader>pS", "<CMD>Autosession search<CR>", desc = "[Auto Session] Search session" },
      -- <leader>pD -> 删除会话
      { "<leader>pD", "<CMD>Autosession delete<CR>", desc = "[Auto Session] Delete session" },
    },

    --- 自动补全 opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      -- 启动 Neovim 时是否自动恢复上次会话
      auto_restore = false,
      -- 不在这些目录下创建会话
      suppressed_dirs = { "~/", "~/Downloads", "/" },
    },

    -- 初始化设置
    init = function()
      -- 配置 session 保存内容
      -- blank: 空白缓冲区
      -- buffers: 所有缓冲区
      -- curdir: 当前目录
      -- folds: 折叠信息
      -- help: 帮助页
      -- tabpages: 标签页
      -- winsize: 窗口大小
      -- winpos: 窗口位置
      -- terminal: 终端
      -- localoptions: 本地选项
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,

    -- 使用方法：
    -- :SessionRestore   -> 恢复最近保存的会话
    -- :Autosession search -> 搜索历史会话
    -- :Autosession delete -> 删除会话
  },
}
