vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("dev-lsp-attach", { clear = true }),
  callback = function(event)
    local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        vim.lsp.buf.format()
      end,
      group = format_sync_grp,
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = vim.api.nvim_get_current_buf() })

    vim.keymap.set("n", "]x", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Previous warning" })

    vim.keymap.set("n", "[x", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Previous warning" })

    vim.keymap.set("i", "<M-CR>", vim.lsp.buf.code_action, { desc = "Code Actions" })
    vim.keymap.set("", "<M-CR>", vim.lsp.buf.code_action, { desc = "Code Actions" })

    local map = function(keys, func, desc, mode)
      mode = mode or { "n", "v" }
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
    map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>dd", require("fzf-lua").lsp_document_diagnostics, "[D]ocument [D]iagnostics")
    map("<leader>fd", require("fzf-lua").lsp_workspace_diagnostics, "[F]ind [D]iagnostics")
    map("<leader>fr", require("fzf-lua").lsp_references, "[F]ind [R]eferences")
    map("<leader>fI", require("fzf-lua").lsp_implementations, "[F]ind [I]mplementations")
    map("<leader>fi", require("fzf-lua").lsp_incoming_calls, "[F]ind [I]ncoming calls")
    map("<leader>fo", require("fzf-lua").lsp_outgoing_calls, "[F]ind [O]utgoing calls")
    map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ft", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>rr", require("fzf-lua").lsp_code_actions, "Code Actions")
    map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  end,
})

return {
  -- { "folke/which-key.nvim", lazy = true },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "git [h]unks: " .. desc })
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']h', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, "next")

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[h', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, "previous")

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, "[s]tage")
      map('n', '<leader>hr', gitsigns.reset_hunk, "[r]eset")

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, "[s]tage")

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, "[r]eset")

      map('n', '<leader>hR', gitsigns.reset_buffer, "[R]eset buffer")
      map('n', '<leader>hp', gitsigns.preview_hunk, "[p]review")
      map('n', '<leader>hi', gitsigns.preview_hunk_inline, "preview [i]line")

      map('n', '<leader>hd', gitsigns.diffthis, "[d]iff")

      map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, "set [Q]flist all")
      map('n', '<leader>hq', gitsigns.setqflist, "set [q]flist")

      -- Toggles
      map('n', '<leader>hw', gitsigns.toggle_word_diff, "toggle [w]ord diff")
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
      message_template = " <summary> 󱇻 <date>  <author> 󰜘<sha>",
      date_format = "%m-%d-%Y %H:%M",
      virtual_text_column = 40,
    },
    keys = {
      {
        "<leader>gb",
        function()
          require("gitblame").toggle()
        end,
        { desc = "[g]it [b]lame" },
      },
    },
  },
  {
    "m4xshen/autoclose.nvim",
    opts = {
      options = {
        disabled_filetypes = { "text", "mail" },
      },
      keys = {
        ["("] = { escape = false, close = true, pair = "()" },
        ["["] = { escape = false, close = true, pair = "[]" },
        ["{"] = { escape = false, close = true, pair = "{}" },

        [">"] = { escape = true, close = false, pair = "<>" },
        [")"] = { escape = true, close = false, pair = "()" },
        ["]"] = { escape = true, close = false, pair = "[]" },
        ["}"] = { escape = true, close = false, pair = "{}" },

        ['"'] = { escape = true, close = true, pair = '""' },
        ["'"] = { escape = true, close = false, pair = "''" },
        ["`"] = { escape = true, close = true, pair = "``" },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = false,
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("gopls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("zls")
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^8',
    lazy = false, -- This plugin is already lazy
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
