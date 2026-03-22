return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {},
  ---@diagnostics enable: missing-fields
  config = function()
    local builtin = require("fzf-lua")
    vim.keymap.set("n", "<leader>pp", builtin.registers, { desc = "fzf registers" })
    vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "fzf find files" })
    vim.keymap.set("n", "<leader>fe", builtin.oldfiles, { desc = "fzf old files" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "fzf buffers" })
    vim.keymap.set("n", "<leader>fj", builtin.jumps, { desc = "fzf jumplist" })
    vim.keymap.set("n", "<leader>fC", builtin.commands, { desc = "fzf commands" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "fzf live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "fzf buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "fzf help tags" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "fzf keymap" })
    vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "fzf marks" })
    vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "[g]it buffer [c]ommits" })
    vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "[g]it [C]ommits" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[g]it [s]tatus" })
    vim.keymap.set("n", "<leader>gh", builtin.git_hunks, { desc = "[g]it [h]unks" })
  end,
}
