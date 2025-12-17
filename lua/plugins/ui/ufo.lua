-- nvim-ufo: 折叠增强
-- LazyVim 默认未自带，可结合 treesitter 使用
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    vim.o.foldenable = true
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.opt.fillchars = {
      fold = " ",
      foldopen = "▾",
      foldsep = "│",
      foldclose = "▸",
    }
  end,
  opts = {
    provider_selector = function() return { "treesitter", "indent" } end,
    open_fold_hl_timeout = 0,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          table.insert(newVirtText, { chunkText, chunk[2] })
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)

    local set_buf_foldlevel = function(num)
      vim.b.ufo_foldlevel = num
      require("ufo").closeFoldsWith(num)
    end

    local change_buf_foldlevel_by = function(num)
      local foldlevel = vim.b.ufo_foldlevel or 0
      foldlevel = math.max(foldlevel + num, 0)
      set_buf_foldlevel(foldlevel)
    end

    -- Keymaps
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end)

    vim.keymap.set("n", "zM", function() set_buf_foldlevel(0) end, { desc = "关闭所有折叠" })
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "展开所有折叠" })
    vim.keymap.set("n", "zm", function()
      local count = vim.v.count == 0 and 1 or vim.v.count
      change_buf_foldlevel_by(-count)
    end, { desc = "折叠更多" })
    vim.keymap.set("n", "zr", function()
      local count = vim.v.count == 0 and 1 or vim.v.count
      change_buf_foldlevel_by(count)
    end, { desc = "折叠更少" })
    vim.keymap.set("n", "zS", function()
      if vim.v.count == 0 then vim.notify("未提供 foldlevel!", vim.log.levels.WARN)
      else set_buf_foldlevel(vim.v.count) end
    end, { desc = "设置折叠等级" })

    -- 禁用默认不兼容 keymaps
    vim.keymap.set("n", "zE", "<NOP>")
    vim.keymap.set("n", "zx", "<NOP>")
    vim.keymap.set("n", "zX", "<NOP>")
  end,
}
