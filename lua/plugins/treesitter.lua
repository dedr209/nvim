return {
	-- 1. Main Treesitter Configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter")

			configs.setup({
				ensure_installed = {
					"lua",
					"python",
					"javascript",
					"typescript",
					"vimdoc",
					"vim",
					"regex",
					"terraform",
					"sql",
					"dockerfile",
					"toml",
					"json",
					"java",
					"groovy",
					"go",
					"gitignore",
					"graphql",
					"yaml",
					"make",
					"cmake",
					"markdown",
					"markdown_inline",
					"bash",
					"tsx",
					"css",
					"html",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},

	-- 2. Sticky Context Configuration
	-- This adds the "Comfort" feature that keeps function headers pinned at the top
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true, -- Enable this plugin
			max_lines = 3, -- Limit to 3 lines to keep the workspace clean
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20, -- Maximum lines to show for a single context
			trim_scope = "outer", -- Discard outer scope if max_lines is exceeded
			mode = "cursor", -- Use cursor position to calculate context
			separator = nil, -- You can set this to "─" for a visual divider
			zindex = 20, -- The Z-index of the context window
		},
		config = function(_, opts)
			require("treesitter-context").setup(opts)

			-- Keymap to jump to the current context (useful for navigating up)
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true, desc = "Jump to upper context" })
		end,
	},
}
