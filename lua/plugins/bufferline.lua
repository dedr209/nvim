return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"moll/vim-bbye", -- Provides :Bdelete to close buffers without closing splits
		"nvim-tree/nvim-web-devicons",
	},
	-- Keymaps moved here for better lazy-loading performance
	keys = {
		{ "<Tab>", ":bnext<CR>", desc = "Next Buffer", silent = true },
		{ "<S-Tab>", ":bprev<CR>", desc = "Previous Buffer", silent = true },
		{ "<leader>bd", ":Bdelete<CR>", desc = "Delete Buffer (keep splits)", silent = true },
		{ "<leader>bD", ":Bdelete!<CR>", desc = "Force Delete Buffer", silent = true },
		{ "<leader>bo", ":BufOnly<CR>", desc = "Close All But Current", silent = true },
		{ "<leader>bn", ":enew<CR>", desc = "New Empty Buffer", silent = true },
		{ "<leader>bl", ":ls<CR>", desc = "List Buffers", silent = true },
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				-- Use Bbye's Bdelete for the UI close button as well
				close_command = "Bdelete! %d",
				right_mouse_command = "Bdelete! %d",

				-- Visuals
				indicator = { style = "none" },
				buffer_close_icon = "✗",
				modified_icon = "●",
				close_icon = "✗",
				left_trunc_marker = "",
				right_trunc_marker = "",
				separator_style = { "│", "│" },

				-- Behavior
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
				persist_buffer_sort = true,
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				sort_by = "insert_at_end",
			},
			highlights = {
				separator = { fg = "#434C5E" },
				buffer_selected = { bold = true, italic = false },
			},
		})
	end,
}
