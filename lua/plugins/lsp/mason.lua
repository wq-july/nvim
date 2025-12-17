return {
  {
    "mason-org/mason.nvim",

    -- LazyVim 已经声明了 mason.nvim
    -- 这里只是“覆盖 / 补充 opts”
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format", -- 确保 clang-format 已安装
        "lua-language-server",
      },
    },

    -- ===== 追加写法示例（教学用，默认不需要）=====
    -- opts = function(_, opts)
    --   vim.list_extend(opts.ensure_installed, {
    --     "clang-format",
    --     "cmake-language-server",
    --   })
    -- end,
  },
}
