return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			-- Add spaces after comment delimiters
			padding = true,
			-- Whether the cursor should stay at its position
			sticky = true,
			-- Lines to be ignored while (un)comment
			ignore = nil,
			-- LHS of toggle mappings in NORMAL mode
			toggler = {
				line = "gcc", -- Toggle comment on current line
				block = "gbc", -- Toggle block comment
			},
			-- LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				line = "gc", -- Comment operator for line
				block = "gb", -- Comment operator for block
			},
			-- LHS of extra mappings
			extra = {
				above = "gcO", -- Add comment on the line above
				below = "gco", -- Add comment on the line below
				eol = "gcA", -- Add comment at end of line
			},
			-- Enable keybindings
			-- NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				basic = true, -- Operators like `gc`
				extra = true, -- Extra operators like `gco`, `gcO`, etc.
			},
			-- Function to call before (un)comment
			pre_hook = nil,
			-- Function to call after (un)comment
			post_hook = nil,
		})
	end,
}
