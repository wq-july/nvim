return {
  {
    -- Catppuccin 主题
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          LineNr     = { fg = colors.surface2 },
          CursorLineNr = { fg = colors.mauve, bold = true },
          CursorLine = { bg = colors.none },
          Visual     = { bg = colors.overlay0 },
          Search     = { bg = colors.surface2 },
          IncSearch  = { bg = colors.mauve },
          CurSearch  = { bg = colors.mauve },
          MatchParen = { bg = colors.mauve, fg = colors.base, bold = true },
          NormalFloat   = { bg = colors.none },
          FloatBorder   = { fg = colors.mauve, bg = colors.none },
          Pmenu      = { bg = colors.none },
          PmenuSel   = { bg = colors.surface1 },
          NvimTreeNormal       = { bg = colors.none },
          NvimTreeEndOfBuffer  = { bg = colors.none },
          NvimTreeVertSplit    = { bg = colors.none },
          BufferLineBackground = { bg = colors.none },
          BufferLineFill       = { bg = colors.none },
          BufferLineSeparator  = { fg = colors.surface2 },
        }
      end,
      integrations = {
        barbar = true,
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        noice = true,
        nvimtree = true,
        rainbow_delimiters = true,
        snacks = { enabled = true, indent_scope_color = "flamingo" },
        which_key = true,
        flash = true,
        lsp_trouble = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight VertSplit guibg=NONE
        highlight SignColumn guibg=NONE
      ]])
    end,
  },
}
