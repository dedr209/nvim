return {
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

			-- ADD THIS BLOCK TO FIX YOUR REFACTORING ERRORS
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- Start selecting with Ctrl+Space
					node_incremental = "<C-space>", -- Expand selection to next logical block
					scope_incremental = false,
					node_decremental = "<bs>", -- Shrink selection with Backspace
				},
			},
		})
	end,
}
