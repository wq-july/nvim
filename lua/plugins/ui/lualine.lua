-- lualine.nvim: 状态栏
-- LazyVim 默认已自带 lualine，可覆盖配置
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "AndreM222/copilot-lualine", -- Copilot 状态显示
  },
  opts = {
    options = {
      theme = "vscode", -- 使用 vscode 主题
      always_divide_middle = false,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      -- lualine_x = {},
      lualine_y = { "encoding", "fileformat", "filetype", "progress" },
      lualine_z = { "location" },
    },
    winbar = {
      lualine_a = { "filename" },
      lualine_b = { { function() return " " end, color = "Comment" } },
      lualine_x = { "lsp_status" },
    },
    inactive_winbar = {
      lualine_b = { function() return " " end },
    },
  },
  config = function(_, opts)
    -- 使用 VSCode 主题的颜色
    -- VSCode 主题的颜色定义
    local vscode_colors = {
      red = "#f48771",
      green = "#89d185",
      yellow = "#dcdcaa",
      blue = "#569cd6",
      purple = "#c586c0",
      cyan = "#4ec9b0",
      orange = "#ce9178",
      gray = "#808080",
      dark_gray = "#3c3c3c",
    }

    -- 宏录制状态显示
    local function show_macro_recording()
      local reg = vim.fn.reg_recording()
      return reg ~= "" and "󰑋 " .. reg or ""
    end

    local macro_recording = {
      show_macro_recording,
      color = { fg = "#ffffff", bg = vscode_colors.red },
      separator = { left = "", right = "" },
      padding = 0,
    }

    -- Copilot 状态栏显示
    local copilot = {
      "copilot",
      show_colors = true,
      symbols = {
        status = {
          hl = {
            enabled = vscode_colors.green,
            sleep = vscode_colors.gray,
            disabled = vscode_colors.dark_gray,
            warning = vscode_colors.orange,
            unknown = vscode_colors.red,
          },
        },
        spinner_color = vscode_colors.blue,
      },
    }

    -- 插入自定义组件
    table.insert(opts.sections.lualine_x, 1, macro_recording)
    table.insert(opts.sections.lualine_c, copilot)

    require("lualine").setup(opts)
  end,
}
