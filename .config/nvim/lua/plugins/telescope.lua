return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  dependencies = { 'nvim-lua/plenary.nvim', 'LinArcX/telescope-changes.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pp', builtin.registers, { desc = 'Telescope registers' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fe', builtin.oldfiles, { desc = 'Telescope old files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jumplist' })
    vim.keymap.set('n', '<leader>fc', require('telescope').extensions.changes.changes, { desc = 'Telescope changes' })
    vim.keymap.set('n', '<leader>fC', builtin.commands, { desc = 'Telescope commands' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymap' })
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope marks' })
    vim.keymap.set('n', '<leader>f*', builtin.current_buffer_fuzzy_find, { desc = 'Telescope fuzzy find' })
    vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = '[g]it buffer [c]ommits' })
    vim.keymap.set('n', '<leader>gC', builtin.git_commits, { desc = '[g]it [C]ommits' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[g]it [s]tatus' })
    vim.keymap.set('x', '<leader>gc', function()
      require('telescope.builtin').git_bcommits_range({ from = s_start, to = s_end })
    end, { desc = '[g]it buffer [c]ommits' })
  end,
}
