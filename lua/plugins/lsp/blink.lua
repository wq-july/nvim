return {
  {
    "saghen/blink.cmp",
    -- version = "1.*",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
      "fang2hou/blink-copilot",
      "folke/lazydev.nvim",
      -- "rafamadriz/friendly-snippets",
    },

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {

      ------------------------------------------------------------------
      -- 1. 键位：自定义 Tab 键补全
      ------------------------------------------------------------------
      keymap = {
        preset = "none",  -- 关闭默认预设，自定义按键

        -- j/k 键进行补全选择
        ["j"] = { "select_next", "fallback" },
        ["k"] = { "select_prev", "fallback" },

        -- Tab 键确认补全
        ["<Tab>"] = { "accept", "fallback" },

        -- 其他快捷键
        ["<C-e>"] = { "hide", "fallback" },      -- 隐藏补全菜单
        ["<C-Space>"] = { "show", "fallback" },  -- 手动触发补全
      },

      ------------------------------------------------------------------
      -- 2. 外观（安全）
      ------------------------------------------------------------------
      appearance = {
        nerd_font_variant = "normal",
      },

      ------------------------------------------------------------------
      -- 3. 补全来源（你这部分设计是“对的”）
      ------------------------------------------------------------------
      sources = {
        default = function()
          local ok, node = pcall(vim.treesitter.get_node)
          if ok and node and vim.tbl_contains(
            { "comment", "line_comment", "block_comment" },
            node:type()
          ) then
            return { "buffer" }
          end
          return {
            "lazydev",
            "copilot",
            "lsp",
            "path",
            "snippets",
            "buffer",
          }
        end,

        per_filetype = {
          codecompanion = { "codecompanion" },
        },

        providers = {
          ----------------------------------------------------------------
          -- LazyDev（Lua / Neovim API）
          ----------------------------------------------------------------
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 95,
          },

          ----------------------------------------------------------------
          -- Copilot
          ----------------------------------------------------------------
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              kind_icon = "",
              kind_hl = "DevIconCopilot",
            },
          },

          ----------------------------------------------------------------
          -- LSP
          ----------------------------------------------------------------
          lsp = {
            score_offset = 60,
            fallbacks = { "buffer" },

            -- 过滤 Text（非常推荐保留）
            transform_items = function(_, items)
              local kinds = require("blink.cmp.types").CompletionItemKind
              return vim.tbl_filter(function(item)
                return item.kind ~= kinds.Text
              end, items)
            end,
          },

          ----------------------------------------------------------------
          -- Path / Buffer / Snippet
          ----------------------------------------------------------------
          path = {
            score_offset = 90,
          },

          snippets = {
            score_offset = 70,
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
          },

          buffer = {
            score_offset = 20,
          },
        },
      },

      ------------------------------------------------------------------
      -- 4. 补全行为（保留核心）
      ------------------------------------------------------------------
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },

        menu = {
          border = "rounded",
          max_height = 15,
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },

        ghost_text = {
          enabled = true,
        },
      },

      ------------------------------------------------------------------
      -- 5. Signature Help（C++ / clangd 强相关）
      ------------------------------------------------------------------
      signature = {
        enabled = true,
        window = {
          border = "single",
        },
      },

      ------------------------------------------------------------------
      -- 6. Fuzzy（默认即可）
      ------------------------------------------------------------------
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },

      ------------------------------------------------------------------
      -- 7. cmdline：完全交给 LazyVim
      ------------------------------------------------------------------
      -- cmdline = nil
    },

    opts_extend = { "sources.default" },
  },
}
