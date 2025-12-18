-- 设置neovide相关的配置
if vim.g.neovide then

  -- Neovide 专属参数
  vim.g.neovide_opacity = 0.85
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animation_length = 0.2
  vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_refresh_rate = 144
  
  -- 窗口配置
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  
  -- 输入法配置（中文支持）
  vim.g.neovide_input_ime = true
  
  -- 窗口管理配置
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_remember_window_position = true
  
  -- 性能优化
  vim.g.neovide_fullscreen = false
  vim.g.neovide_scale_factor = 1.0
end

-- 工作目录记忆功能
local function setup_working_directory_memory()
  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  local session_file = session_dir .. "/last_working_dir"
  
  -- 确保会话目录存在
  vim.fn.mkdir(session_dir, "p")
  
  -- 保存当前工作目录
  local function save_working_dir()
    local current_dir = vim.fn.getcwd()
    vim.fn.writefile({current_dir}, session_file)
  end
  
  -- 恢复工作目录
  local function restore_working_dir()
    if vim.fn.filereadable(session_file) == 1 then
      local lines = vim.fn.readfile(session_file)
      if #lines > 0 then
        local last_dir = lines[1]
        if vim.fn.isdirectory(last_dir) == 1 then
          vim.cmd("cd " .. vim.fn.fnameescape(last_dir))
          print("已恢复到上次的工作目录: " .. last_dir)
        end
      end
    end
  end
  
  -- 在启动时恢复工作目录
  restore_working_dir()
  
  -- 在退出时保存工作目录
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = save_working_dir,
  })
  
  -- 在目录改变时保存工作目录
  vim.api.nvim_create_autocmd("DirChanged", {
    callback = save_working_dir,
  })
end

-- 启用工作目录记忆功能
setup_working_directory_memory()
