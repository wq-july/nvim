-- nvim-colorizer.lua: 代码内颜色高亮
-- LazyVim 默认未自带
return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
}
