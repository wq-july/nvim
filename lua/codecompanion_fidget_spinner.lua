-- 引入 fidget.nvim 的 progress 模块，用于在 Neovim 中显示异步进度条
local progress = require("fidget.progress")

-- 创建一个模块 M，用于封装 CodeCompanion 的进度处理逻辑
local M = {}

-- 初始化函数：设置自动命令监听 CodeCompanion 请求的开始和结束
function M:init()
  -- 创建一个新的自动命令组，便于统一管理
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

  -- 监听 CodeCompanion 请求开始事件
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      -- 创建一个进度 handle（fidget 用于显示进度条）
      local handle = M:create_progress_handle(request)
      -- 将 handle 存储在 M.handles 表中，以便后续更新或完成
      M:store_progress_handle(request.data.id, handle)
    end,
  })

  -- 监听 CodeCompanion 请求结束事件
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      -- 从 M.handles 表中取出对应的 handle
      local handle = M:pop_progress_handle(request.data.id)
      if handle then
        -- 根据请求状态更新进度条的显示信息
        M:report_exit_status(handle, request)
        -- 完成进度条显示
        handle:finish()
      end
    end,
  })
end

-- 用于存储所有的进度 handle，key 为 request 的 id
M.handles = {}

-- 存储一个进度 handle
function M:store_progress_handle(id, handle)
  M.handles[id] = handle
end

-- 取出并删除一个进度 handle
function M:pop_progress_handle(id)
  local handle = M.handles[id]
  M.handles[id] = nil
  return handle
end

-- 根据 CodeCompanion 的请求创建一个 fidget 进度 handle
function M:create_progress_handle(request)
  return progress.handle.create({
    -- 显示标题，例如 “Requesting assistance (strategy_name)”
    title = " Requesting assistance (" .. request.data.strategy .. ")",
    -- 显示初始信息
    message = "In progress...",
    lsp_client = {
      -- 显示 LLM 客户端名称和模型信息
      name = M:llm_role_title(request.data.adapter),
    },
  })
end

-- 构建 LLM 名称显示文本，例如 "Copilot (gpt-4)"
function M:llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name) -- 插件名
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")") -- 模型名
  end
  return table.concat(parts, " ") -- 拼接成完整字符串
end

-- 根据请求状态更新 handle 的显示信息
function M:report_exit_status(handle, request)
  if request.data.status == "success" then
    handle.message = "Completed" -- 成功
  elseif request.data.status == "error" then
    handle.message = " Error" -- 出错
  else
    handle.message = "󰜺 Cancelled" -- 被取消
  end
end

-- 返回模块
return M
