-- showkeys: 显示最近按键
-- LazyVim 默认未自带
return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    maxkeys = 5, -- 显示最近 5 个按键
  },
}
