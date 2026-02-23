return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- auto-close tags as you type <div> → <div></div>
				enable_rename = true, -- rename closing tag when you change opening tag
				enable_close_on_slash = true, -- auto-close when you type </
			},

			-- filetypes that autotag will activate on
			-- these are the defaults, you can remove ones you don't use
			per_filetype = {
				["html"] = { enable_close = true },
				["xml"] = { enable_close = true },
				["jsx"] = { enable_close = true },
				["tsx"] = { enable_close = true },
				["javascript"] = { enable_close = true },
				["typescript"] = { enable_close = true },
				["javascriptreact"] = { enable_close = true },
				["typescriptreact"] = { enable_close = true },
				["vue"] = { enable_close = true },
				["svelte"] = { enable_close = true },
				["php"] = { enable_close = true },
				["astro"] = { enable_close = true },
			},
		})
	end,
}
