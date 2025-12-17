return {
  ----------------------------------------------------------------------
  -- TODO / FIXME 注释管理
  ----------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>st", function() require("snacks").picker.todo_comments({ keywords = { "TODO","FIX","FIXME","BUG","FIXIT","HACK","WARN","ISSUE" } }) end, desc = "[TODO] 仅选取重要待办" },
      { "<leader>sT", function() require("snacks").picker.todo_comments() end, desc = "[TODO] 显示所有待办" },
    },
    config = true,
  },
}
