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
vim.api.nvim_create_user_command('RustFeatures', function(opts)
  local client = vim.lsp.get_clients({ name = "rust-analyzer" })[1]
  if client then
    if client.config.settings["rust-analyzer"].cargo == nil then
      client.config.settings["rust-analyzer"].cargo = { features = opts.fargs }
    else
      client.config.settings["rust-analyzer"].cargo.features = opts.fargs
    end
    client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
end, { nargs = '*' })

vim.opt.foldenable = false
vim.opt.colorcolumn = "+0"
vim.opt.textwidth = 120

vim.g.rust_recommended_style = 0
vim.g.have_nerd_font = true
vim.cmd("FzfLua register_ui_select")
