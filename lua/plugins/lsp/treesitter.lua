return {
  {
    "nvim-treesitter/nvim-treesitter",

    -- LazyVim 已经声明并安装了 nvim-treesitter
    -- 这里只是对 opts 进行覆盖 / 补充
    opts = {
      -- =========================
      -- Parser 安装策略
      -- =========================
      auto_install = true,

      ensure_installed = {
        -- 基础
        "lua",
        "vim",
        "vimdoc",

        -- C / C++
        "c",
        "cpp",

        -- 脚本 / 配置
        "bash",
        "cmake",

        "python",
      },

      -- =========================
      -- 功能开关
      -- =========================
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },
      
      sync_install = false,

      incremental_selection = {
        enable = true,
        -- keymaps = {
        --    -- <CR>  : 初始化选区（当前 AST 节点）
        --   -- <CR>  : 继续向上扩展选区（父 AST 节点）
        --   init_selection = "<CR>",
        --   node_incremental = "<CR>",
        --   -- <BS>  : 回退到更小的 AST 节点
        --   node_decremental = "<BS>",
        --   -- <TAB> : 扩展到当前语法作用域（如函数 / 类）
        --   scope_incremental = "<TAB>",
        -- },
      },
    },

    -- ===== 追加写法示例（教学用，默认不启用）=====
    -- opts = function(_, opts)
    --   vim.list_extend(opts.ensure_installed, {
    --     "python",
    --     "json",
    --     "yaml",
    --   })
    -- end,
  },
}
