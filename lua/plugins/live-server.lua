return {
	"barrett-ruth/live-server.nvim",
	cmd = { "LiveServerStart", "LiveServerStop" },
	-- Use 'init' for global variables (vim.g) so they are set before the plugin loads
	init = function()
		vim.g.live_server = {
			port = 8080,
			host = "127.0.0.1",
			open = true,
			browser = "default",
		}
	end,
}
