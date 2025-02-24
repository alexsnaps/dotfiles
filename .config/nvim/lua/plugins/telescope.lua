return {
  'nvim-telescope/telescope.nvim', branch = 'master',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fT', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope tags' })
    vim.keymap.set('n', '<leader>ft', builtin.lsp_document_symbols, { desc = 'Telescope tags' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymap' })
    vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = '[g]it buffer [c]ommits' })
    vim.keymap.set('n', '<leader>gC', builtin.git_commits, { desc = '[g]it [C]ommits' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[g]it [s]tatus' })
    vim.keymap.set('x', '<leader>gc', function()
      require('telescope.builtin').git_bcommits_range({from = s_start, to = s_end})
    end, { desc = '[g]it buffer [c]ommits' })
  end,
}

