-- Treesitter folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    -- check if treesitter has parser
    --    if require("nvim-treesitter.parsers") then
    -- use treesitter folding
    --      vim.opt.foldmethod = "expr"
    --      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    --    else
    -- use alternative foldmethod
    vim.opt.foldmethod = "syntax"
    --    end
  end,
})
vim.opt.foldenable = false
vim.opt.colorcolumn = "+0"
vim.opt.textwidth = 120

vim.g.rust_recommended_style = 0
vim.g.have_nerd_font = true
vim.cmd("FzfLua register_ui_select")
