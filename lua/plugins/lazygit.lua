return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim", -- optional, adds :Telescope lazygit
	},
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
		{ "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit file history" },
		{ "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit current file history" },
	},
	config = function()
		-- open lazygit in a floating window
		vim.g.lazygit_floating_window_winblend = 0 -- transparency (0 = opaque)
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen size
		vim.g.lazygit_floating_window_border_chars = {
			"╭",
			"─",
			"╮",
			"│",
			"╯",
			"─",
			"╰",
			"│", -- rounded border
		}
		vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary for the window
		vim.g.lazygit_use_neovim_remote = 1 -- open files from lazygit in current nvim instance

		-- if you have telescope, register the extension
		require("telescope").load_extension("lazygit")
	end,
}
