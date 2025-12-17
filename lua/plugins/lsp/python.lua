-- python.lua
-- Python 开发环境插件配置
-- 集成 LSP、Treesitter、Mason、formatter、linter、虚拟环境管理
local M = {}

-- ======================
-- LSP: pyright
-- ======================
-- LazyVim 已内置 LSP 管理，直接启用 pyright
vim.lsp.enable("pyright")

-- ======================
-- Treesitter: Python 语法解析
-- ======================
M[#M + 1] = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,  -- 如果已经 LazyVim 集成，可选择为 optional
  opts = {
    ensure_installed = { "python" }, -- 自动安装 Python 语法支持
  },
  opts_extend = { "ensure_installed" }, -- 允许扩展已有 ensure_installed
  -- 可扩展为其他语言：ensure_installed = vim.list_extend(opts.ensure_installed, { "lua", "cpp" })
}

-- ======================
-- Mason: 管理 Python LSP 和工具
-- ======================
M[#M + 1] = {
  "mason-org/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "ruff", "pyright" }, -- 自动安装 Ruff linter 和 pyright
  },
  opts_extend = { "ensure_installed" }, -- 保持可扩展性
}

-- ======================
-- Formatter: Conform.nvim + ruff_format
-- ======================
M[#M + 1] = {
  "stevearc/conform.nvim",
  optional = true,
  ft = "python",  -- 仅在 Python 文件中加载
  opts = {
    formatters_by_ft = {
      python = { "ruff_format" }, -- 使用 ruff 进行代码格式化
    },
  },
}

-- ======================
-- Linter: nvim-lint + ruff
-- ======================
M[#M + 1] = {
  "mfussenegger/nvim-lint",
  optional = true,
  ft = "python", -- 仅在 Python 文件中加载
  opts = {
    linters_by_ft = {
      python = { "ruff" }, -- 使用 ruff 进行代码检查
    },
  },
}

-- ======================
-- Virtualenv 管理: venv-selector.nvim
-- ======================
M[#M + 1] = {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp", -- 使用 regexp 分支
  cmd = "VenvSelect", -- 延迟加载命令
  ft = "python",      -- 仅在 Python 文件中加载
  keys = {
    { "<leader>cv", "<CMD>VenvSelect<CR>", desc = "选择 Python 虚拟环境", mode = "n", ft = "python" },
  },
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true, -- 激活虚拟环境时通知用户
      },
    },
  },
  config = function(_, opts)
    -- 自动加载缓存的虚拟环境
    require("venv-selector").setup(opts)
  end,
}

return M
