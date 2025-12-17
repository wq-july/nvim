return {
  ----------------------------------------------------------------------
  -- 启动时间分析插件
  ----------------------------------------------------------------------
  {
    "dstein64/vim-startuptime",
    -- 仅在手动调用命令时加载，避免启动慢
    cmd = "StartupTime",
    config = function()
      -- 分析启动时间时重复尝试的次数，默认是 10 次
      -- 可以根据机器性能调整，次数多可以得到更稳定的平均启动时间
      vim.g.startuptime_tries = 10

      -- 可选：自定义输出路径（默认是当前目录）
      -- vim.g.startuptime_output_file = "~/.cache/nvim/startuptime.log"
    end,
    -- 使用方法：
    -- :StartupTime   -> 显示 Neovim 启动耗时统计
    -- 适合用于调试 LazyVim 或自定义插件启动慢的问题
  },
}
