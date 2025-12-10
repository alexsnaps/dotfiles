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

		local map = function(keys, func, desc, mode)
			mode = mode or { "n", "v" }
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
		map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>dd", require("fzf-lua").lsp_document_diagnostics, "[D]ocument [D]iagnostics")
		map("<leader>fd", require("fzf-lua").lsp_workspace_diagnostics, "[F]ind [D]iagnostics")
		map("<leader>fr", require("fzf-lua").lsp_references, "[F]ind [R]eferences")
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
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
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
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			--require('lspconfig').gopls.setup {
			vim.lsp.config["gopls"] = {
				--cmd = "~/go/bin/gopls",
				root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						["ui.inlayhint.hints"] = {
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							parameterNames = true,
							functionTypeParameters = true,
							assignVariableTypes = true,
						},
					},
				},
			}
			vim.lsp.config["luals"] = {}
			vim.lsp.config["clangd"] = {}
			vim.lsp.config["zls"] = {}
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
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
	{
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
	},
}
