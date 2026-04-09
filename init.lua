vim.o.number = true
vim.o.mouse = 'a'
vim.o.confirm = true

-- leader config
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use 2 spaces for tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 0
vim.o.expandtab = true

-- Hide command line
vim.o.cmdheight = 0

-- Clear highlighting by pressing esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.cursorword").setup()
require("mini.statusline").setup()
require("fidget").setup({})

require("blink-cmp").setup({
  completion = {
    menu = {
      border = "rounded",
      winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded"
      }

    },
    signature = {
      enabled = true,
    },
  }
})


local function set_colorscheme(background)
  if background == "dark" then
    require("mini.hues").setup({
      background = "#101418",
      foreground = "#e0e2e8",
      saturation = "lowmedium",
      accent = "blue",
    })
  else
    require("mini.hues").setup({
      background = "#d6d8df",
      foreground = "#343B58",
      saturation = "lowmedium",
      accent = "blue",
    })
  end
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    set_colorscheme(vim.o.background)
  end,
})

set_colorscheme(vim.o.background)

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("nixd")
