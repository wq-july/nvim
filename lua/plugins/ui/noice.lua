return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.show_line_diagnostics"] = true,
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- 关闭底部搜索栏
        command_palette = true, -- 支持命令面板
      },
      cmdline = {
        view = "cmdline_popup",  -- 弹出式命令行
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
      popupmenu = {
        backend = "nui",
      },
      -- routes = {
      --   {
      --     view = "cmdline_popup",
      --     filter = { event = "cmdline" },
      --     opts = { position = "50%", size = { width = 60, height = 1 } },
      --   },
      -- },
    },
  },
}
