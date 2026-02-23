return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = true },
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				-- Use current working directory (no static cwd)
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-l>"] = actions.select_default,
					},
				},
			},
			pickers = {
				find_files = {
					-- Go-specific ignores to keep search clean
					file_ignore_patterns = { "node_modules", "%.git", "%.venv", "vendor/", "bin/" },
					hidden = true,
				},
				live_grep = {
					file_ignore_patterns = { "node_modules", "%.git", "%.venv", "vendor/", "bin/" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- Keymaps for Grepping within the "Core Folder"
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles (CWD)" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep (CWD)" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "[B]rowse [B]uffers" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

		-- LSP Symbol search (Crucial for Go)
		vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch [S]ymbols" })
	end,
}
