return {
	"stevearc/conform.nvim",
	opts = {
		-- Increased timeout to 3000ms to prevent failures on large files or cold starts
		format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
		javascript = { "prettierd", "eslint_d" },
typescript = { "prettierd", "eslint_d" },
javascriptreact = { "prettierd", "eslint_d" },
typescriptreact = { "prettierd", "eslint_d" },
			json = { "prettierd", "prettier", stop_after_first = true },
			python = { "black" },
			go = { "goimports", "gofumpt" },
		},
	},
}
