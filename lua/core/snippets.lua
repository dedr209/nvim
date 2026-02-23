-- ============================================================================
-- 1. HIGHLIGHTING & APPEARANCE
-- ============================================================================
-- Prevent LSP from overwriting treesitter color settings
vim.hl.priorities.semantic_tokens = 95

-- Appearance of diagnostics (LSP errors/warnings)
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		-- Custom format function: shows error codes to learn the "essence"
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "▎",
			[vim.diagnostic.severity.WARN] = "▎",
			[vim.diagnostic.severity.INFO] = "▎",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
})

-- Transparent background for diagnostic virtual text
for _, type in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. type, { bg = "NONE" })
end

-- ============================================================================
-- 2. AUTOMATION & UTILITIES
-- ============================================================================
-- Highlight on yank: Visual feedback when copying text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Universal Organize Imports (Supports Go/TS)
local function organize_imports()
	local bufnr = vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result)
		if err or not result or not result[1] then
			return
		end
		local action = result[1]
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
		elseif action.command then
			vim.lsp.buf.execute_command(action.command)
		end
	end)
end
vim.keymap.set("n", "<leader>oi", organize_imports, { desc = "LSP: Organize Imports" })

-- DETECTED DUPLICATE CONFIGURATION
-- This file contains logic (Diagnostics, TextYankPost, Organize Imports)
-- that is already present in `lua/core/autocommands.lua`.
--
-- keeping two sources of truth leads to erratic behavior.
-- Please DELETE this file and remove `require("core.snippets")` from your init.lua.

