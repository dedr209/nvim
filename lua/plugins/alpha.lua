return { "goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		dashboard.section.top_buttons.val = {
			dashboard.button("c", "⚙️  Configuration", function()
				vim.cmd("e $MYVIMRC")
				vim.schedule(function()
					vim.cmd("lcd %:p:h")
					if vim.fn.exists(":Neotree") == 2 then
						vim.cmd("Neotree reveal")
					end
				end)
			end),
			dashboard.button("p", "📂  Projects", ":Telescope projects<CR>"),
		}

		alpha.setup(dashboard.opts)
		vim.keymap.set("n", "<leader>a", ":Alpha<CR>", { noremap = true, silent = true, desc = "Dashboard" })
	end,
}
