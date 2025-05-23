--vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank

vim.opt.nu = true  -- set line numbers
vim.opt.rnu = true -- use relative line numbers
vim.opt.cursorline = true
vim.opt.showcmd = false

-- set tab size to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.opt.laststatus = 3

vim.cmd([[
  let g:vimspector_sidebar_width = 85
  let g:vimspector_bottombar_height = 15
  let g:vimspector_terminal_maxwidth = 70
]])
