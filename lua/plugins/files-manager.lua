return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		local mf = require("mini.files")

		mf.setup({
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 30,
			},
			options = {
				permanent_delete = false,
			},
		})

		-- Enter to open file/directory
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				vim.keymap.set("n", "<CR>", function()
					mf.go_in({ close_on_file = true })
				end, { buffer = args.data.buf_id })
			end,
		})

		-- Toggle: open at current file, or close if already open
		vim.keymap.set("n", "<leader>e", function()
			if not mf.close() then
				local file = vim.api.nvim_buf_get_name(0)
				local path = file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.fn.getcwd()
				mf.open(path)
			end
		end, { desc = "Toggle Mini Files" })
	end,
}
