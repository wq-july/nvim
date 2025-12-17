-- mini.diff: 轻量 diff overlay
-- LazyVim 默认未自带，可直接添加
return {
  "nvim-mini/mini.diff",
  event = "BufReadPost",
  keys = {
    { "<leader>to", function()
        require("mini.diff").toggle_overlay(vim.api.nvim_get_current_buf())
      end,
      desc = "切换 diff overlay",
    },
  },
  opts = {
    -- 禁用默认按键，使用 gitsigns 或自定义 keymaps
    mappings = {
      apply = "",
      reset = "",
      textobject = "",
      goto_first = "",
      goto_prev = "",
      goto_next = "",
      goto_last = "",
    },
  },
}
