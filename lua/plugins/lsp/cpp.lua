-- cpp.lua
-- C/C++ 开发环境插件配置
-- 只做最小配置，使用 Mason 的 clangd 并确保格式化使用 clang-format
local M = {}

-- ======================
-- LSP: clangd
-- ======================
M[#M + 1] = {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- 只配置 clangd 使用 Mason 安装的版本
    opts.servers = opts.servers or {}
    opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
      -- 使用 Mason 安装的 clangd（版本 21.1.0），而不是系统版本（12.0.0）
      cmd = {
        vim.fn.stdpath("data") .. "/mason/bin/clangd",
      },
      -- 配置诊断，减少误报
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
        offsetEncoding = { "utf-16" },
        -- 禁用某些可能产生误报的诊断
        fallbackFlags = {},
      },
      -- 注意：诊断过滤最好在项目的 .clangd 配置文件中进行
      -- 这里只做基本配置
    })
    return opts
  end,
}

-- ======================
-- Formatter: clang-format
-- ======================
M[#M + 1] = {
  "stevearc/conform.nvim",
  optional = true,
  ft = { "c", "cpp", "cuda" },
  opts = function(_, opts)
    -- 扩展 formatters_by_ft，而不是覆盖
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.c = { "clang_format" }
    opts.formatters_by_ft.cpp = { "clang_format" }
    opts.formatters_by_ft.cuda = { "clang_format" }
    
    -- 配置 clang_format 格式化器选项
    opts.formatters = opts.formatters or {}
    opts.formatters.clang_format = {
      prepend_args = {
        "--style=file", -- 使用项目根目录的 .clang-format 文件
        "--fallback-style=Google", -- 如果没有 .clang-format，使用 Google 风格
      },
    }
    
    return opts
  end,
}

return M

