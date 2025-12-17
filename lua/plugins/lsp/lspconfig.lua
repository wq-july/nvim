return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },

    opts = {
      -- =========================
      -- 全局 LSP 行为
      -- =========================
      diagnostics = {
        underline = false,
        signs = false,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 2,
          prefix = "●",
        },
        float = {
          border = "rounded",
        },
      },

      -- =========================
      -- LSP servers
      -- =========================
      servers = {
        -- ⚠️ 默认全局能力写在 "*" 下
        ["*"] = {
          capabilities = require("blink.cmp").get_lsp_capabilities(),
        },

        -- 单独 server 配置（可以覆盖默认能力）
        lua_ls = {},
        clangd = {},
      },
    },
  },
}
