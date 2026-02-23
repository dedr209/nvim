-- ============================================================================
-- AUTOCOMMANDS & LSP UTILITIES
-- ============================================================================

-- Highlight on yank (visual feedback when copying)
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.hl.on_yank() -- Fixed: vim.highlight.on_yank is deprecated
	end,
})

-- ============================================================================
-- LSP UTILITIES
-- ============================================================================

-- Universal Organize Imports (supports Go/TypeScript/JavaScript)
local function organize_imports()
	local bufnr = vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result)
		-- Fixed: Use standard length check instead of possible nil access in tbl_isempty
		if err or not result or #result == 0 then
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

vim.keymap.set("n", "<leader>oi", organize_imports, { desc = "LSP: Organize imports" })

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

-- Prevent LSP from overwriting treesitter colors
vim.hl.priorities.semantic_tokens = 95

-- Diagnostic appearance and behavior
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
		-- Show error codes to learn the "essence"
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "▎",
			[vim.diagnostic.severity.WARN] = "▎",
			[vim.diagnostic.severity.INFO] = "▎",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
	underline = true,
	update_in_insert = false, -- Don't show while typing (less distraction)
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Transparent background for diagnostic virtual text
for _, type in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. type, { bg = "NONE" })
end

