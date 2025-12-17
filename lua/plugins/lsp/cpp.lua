-- cpp.lua
-- C/C++ 开发环境插件配置
-- 集成 clangd、formatter、lint、Treesitter 等工具
local M = {}

-- ======================
-- LSP: clangd
-- ======================
M[#M + 1] = {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        -- clangd 启动参数
        cmd = {
          "clangd",
          "--background-index",            -- 启用后台索引
          "--clang-tidy",                  -- 启用 clang-tidy
          "--completion-style=detailed",   -- 详细补全
          "--header-insertion=iwyu",       -- 自动添加头文件
          "--header-insertion-decorators", -- 添加装饰器
          "--pch-storage=memory",          -- 使用内存存储 PCH
          "--function-arg-placeholders",  -- 补全函数占位参数
          "--fallback-style=LLVM",         -- 默认编码风格
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- 支持文件类型
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "compile_commands.json",
            ".clangd",
            ".git"
          )(fname)
        end,
        init_options = {
          clangdFileStatus = true,       -- 显示文件状态
          usePlaceholders = true,        -- 补全占位符
          completeUnimported = true,     -- 补全未导入符号
          semanticHighlighting = true,   -- 启用语义高亮
          offsetEncoding = { "utf-16" }, -- 避免 LSP 偏移问题
        },
        single_file_support = true,      -- 单文件支持
      },
    },
  },

  -- ===== 可扩展示例（教学）=====
  -- opts = function(_, opts)
  --   -- 关闭语义高亮
  --   opts.servers.clangd.init_options.semanticHighlighting = false
  -- end,
}

-- ======================
-- Treesitter: C/C++ 语法解析
-- ======================
M[#M + 1] = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ft = { "c", "cpp", "objc", "cuda" },
  opts = {
    ensure_installed = { "c", "cpp", "cuda", "cmake" }, -- 自动安装语法支持
    highlight = {
      enable = true, -- 启用高亮
    },
  },
  opts_extend = { "ensure_installed" },
}

-- ======================
-- Formatter: clang-format
-- ======================
M[#M + 1] = {
  "stevearc/conform.nvim",
  optional = true,
  ft = { "c", "cpp", "cuda" },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      cuda = { "clang_format" },
    },
  },
}

-- ======================
-- Linter: clang-tidy
-- ======================
M[#M + 1] = {
  "mfussenegger/nvim-lint",
  optional = true,
  ft = { "c", "cpp", "cuda" },
  opts = {
    linters_by_ft = {
      c = { "clang_tidy" },
      cpp = { "clang_tidy" },
      cuda = { "clang_tidy" },
    },
  },
}

-- ======================
-- CMake 支持插件（可选）
-- ======================
M[#M + 1] = {
  "Civitasv/cmake-tools.nvim",
  optional = true,
  ft = { "c", "cpp", "cuda" },
  cmd = { "CMakeOpen", "CMakeConfigure", "CMakeBuild" },
  opts = {
    cmake_command = "cmake",
    build_dir = "build",
    configure_args = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
  },
}

-- ======================
-- Debug Adapter Protocol (DAP) for C/C++
-- ======================
M[#M + 1] = {
  "mfussenegger/nvim-dap",
  optional = true,
  ft = { "c", "cpp" },
  dependencies = { "rcarriga/nvim-dap-ui" },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    -- 配置 gdb 调试器
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "OpenDebugAD7", -- vscode-cpptools 的调试器
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}

return M
