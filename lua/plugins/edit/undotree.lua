return {
  ----------------------------------------------------------------------
  -- undo 树可视化
  ----------------------------------------------------------------------
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "切换 Undo 树" }, -- 中文注释
    },
    init = function()
      vim.cmd([[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')

          " 如果目录不存在，递归创建
          if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
      endif
      ]])
    end,
  },


}
