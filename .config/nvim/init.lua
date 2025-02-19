require("config.lazy")
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("set")
require("opts")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


--require("mason").setup()

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end
