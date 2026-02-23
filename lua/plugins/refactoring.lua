return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = { go = true },
			prompt_func_param_type = { go = true },
			show_success_message = true,
		})

		-- 1. Selection-based Refactors (Visual Mode)
		-- These use Ex Commands to provide a live preview of the change
		vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract Function" })
		vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to File" })
		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract Variable" })

		-- 2. Inline Refactors (Normal Mode)
		vim.keymap.set("n", "<leader>ri", "<cmd>Refactor inline_var<CR>", { desc = "Inline Variable", silent = true })
		vim.keymap.set("n", "<leader>rI", "<cmd>Refactor inline_func<CR>", { desc = "Inline Function", silent = true })

		-- 3. Block Refactors (Normal Mode)
		vim.keymap.set("n", "<leader>rb", "<cmd>Refactor extract_block<CR>", { desc = "Extract Block", silent = true })
		vim.keymap.set("n", "<leader>rbf", "<cmd>Refactor extract_block_to_file<CR>", { desc = "Extract Block to File", silent = true })

		-- 4. The "Master Menu"
		-- This is the most stable way to handle complex Go refactors
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("refactoring").select_refactor()
		end, { desc = "Refactor Menu" })
	end,
}
