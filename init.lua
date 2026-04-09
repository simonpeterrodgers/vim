vim.o.number = true
vim.o.mouse = 'a'
vim.o.confirm = true

-- use 2 spaces for tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 0
vim.o.expandtab = true
vim.o.signcolumn = "yes"

-- Hide command line
vim.o.cmdheight = 0

--
-- Key binds
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("which-key").setup({
  delay = 0;
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  };
  win = { border = "rounded"; }
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

vim.keymap.set('n', '<leader>sh', ":Telescope help_tags<CR>", { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', ":Telescope keymaps<CR>", { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', ":Telescope find_files<CR>", { desc = '[S]earch [F]iles' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', ":Telescope grep_string<CR>", { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', ":Telescope live_grep<CR>", { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', ":Telescope diagnostics<CR>", { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', ":Telescope resume<CR>", { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', ":Telescope oldfiles<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', ":Telescope commands<CR>", { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', ":Telescope buffers<CR>", { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, { desc = '[T]oggle [D]iagnostic lines' })
vim.diagnostic.config({ update_in_insert = true })

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
      window = { border = "rounded" }
    },
    signature = { enabled = true, },
  }
})

--
-- Colorscheme
--
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

  vim.cmd('hi MiniCursorword gui=nocombine guibg=#504945')
  vim.cmd('hi MiniCursorwordCurrent gui=nocombine guibg=#504945')
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    set_colorscheme(vim.o.background)
  end,
})

set_colorscheme(vim.o.background)

--
-- LSP
-- 
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("nixd")
