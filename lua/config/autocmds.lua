-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 自动恢复工作目录到上次退出时的位置
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- 如果通过命令行参数指定了文件，则不恢复目录
    if vim.fn.argc() == 0 then
      local cwd = vim.fn.getcwd()
      -- 如果当前目录是家目录，则尝试恢复上次的工作目录
      if cwd == vim.fn.expand("~") or cwd == "/" then
        local last_cwd = vim.fn.expand("~/.local/state/nvim/last_cwd")
        if vim.fn.filereadable(last_cwd) == 1 then
          local lines = vim.fn.readfile(last_cwd)
          if #lines > 0 and vim.fn.isdirectory(lines[1]) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(lines[1]))
          end
        end
      end
    end
  end,
  desc = "自动恢复到上次退出时的工作目录",
})

-- 保存当前工作目录到文件
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    local cwd = vim.fn.getcwd()
    -- 只在非系统目录时保存
    if cwd ~= vim.fn.expand("~") and cwd ~= "/" then
      vim.fn.mkdir(vim.fn.expand("~/.local/state/nvim"), "p")
      vim.fn.writefile({cwd}, vim.fn.expand("~/.local/state/nvim/last_cwd"))
    end
  end,
  desc = "保存当前工作目录",
})
