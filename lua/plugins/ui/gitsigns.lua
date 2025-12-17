-- gitsigns.nvim: Git 变动标记
-- LazyVim 默认已自带 gitsigns，可覆盖 keymaps 和 toggle 配置
return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  opts = {
    signcolumn = false,
    numhl = true,
    current_line_blame = true,
    attach_to_untracked = true,
    preview_config = { border = "rounded" },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Git hunk 导航
      map("n", "]h", function()
        if vim.wo.diff then vim.cmd.normal({ "]h", bang = true })
        else gitsigns.nav_hunk("next") end
      end, { desc = "下一个 hunk" })
      map("n", "[h", function()
        if vim.wo.diff then vim.cmd.normal({ "[h", bang = true })
        else gitsigns.nav_hunk("prev") end
      end, { desc = "上一个 hunk" })

      -- Git stage/reset 操作
      map("n", "<leader>ggs", gitsigns.stage_hunk, { desc = "Stage 当前 hunk" })
      map("v", "<leader>ggs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage 当前 hunk (Visual)" })
      map("n", "<leader>ggr", gitsigns.reset_hunk, { desc = "Reset 当前 hunk" })

      -- Toggle 功能示例（使用 snacks.nvim）
      require("snacks")
        .toggle({
          name = "line blame",
          get = function() return require("gitsigns.config").config.current_line_blame end,
          set = function(enabled) gitsigns.toggle_current_line_blame(enabled) end,
        })
        :map("<leader>tgb")
    end,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
