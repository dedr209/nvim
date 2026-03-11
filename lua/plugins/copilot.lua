return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<Tab>",
						accept_word = "<C-Right>",
						accept_line = "<C-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				filetypes = {
					markdown = true,
					yaml = true,
					["*"] = true, -- enable for all filetypes
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
		build = "make tiktoken", -- Only on MacOS or Linux, helps with token counting
		opts = {
			debug = false,
		},
		keys = {
			-- Chat and General Actions
			{ "<leader>zc", "<cmd>CopilotChat<cr>", mode = "n", desc = "Chat with Copilot" },
			{ "<leader>zm", "<cmd>CopilotChatCommit<cr>", mode = "n", desc = "Generate Commit Message" },
			-- Visual Mode Actions (Selection Based)
			{ "<leader>ze", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "Explain Code" },
			{ "<leader>zr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "Review Code" },
			{ "<leader>zf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "Fix Code Issues" },
			{ "<leader>zo", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "Optimize Code" },
			{ "<leader>zd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "Generate Docs" },
			{ "<leader>zt", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "Generate Tests" },
			{ "<leader>zs", "<cmd>CopilotChatCommit<cr>", mode = "v", desc = "Generate Commit for Selection" },
		},
	},
}
