-- =============================================================================
-- Note: Leader keys are set in core/options.lua
-- =============================================================================

-- Disable spacebar default behavior
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- =============================================================================
-- General Editing & Files
-- =============================================================================
-- File operations (normal + insert mode)
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "File: Save" })

-- Quitting
vim.keymap.set("n", "<leader>qq", "<cmd>confirm q<CR>", { desc = "Quit: Window" })
vim.keymap.set("n", "<leader>qa", "<cmd>confirm qall<CR>", { desc = "Quit: All" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })

-- Duplicate lines/selections
vim.keymap.set("n", "<C-S-d>", "<cmd>t.<CR>", { desc = "Duplicate line down" })
vim.keymap.set("v", "<C-S-d>", ":t '><CR>gv", { desc = "Duplicate selection down" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Toggle: Line wrap" })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank: To clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank: Line to clipboard" })

-- =============================================================================
-- Movement & Centering
-- =============================================================================
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down + center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up + center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search + center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search + center" })

-- Disable arrow keys (enforce hjkl)
vim.keymap.set("n", "<left>", '<cmd>echo "Use h!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j!!"<CR>')

-- =============================================================================
-- Window & Buffer Management
-- =============================================================================
-- Navigate windows (normal mode)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window: Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window: Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window: Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window: Right" })

-- Navigate windows (terminal mode)
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Window: Left" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Window: Down" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Window: Up" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Window: Right" })

-- Split windows
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window: Split vertical" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Window: Split horizontal" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Window: Equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Window: Close" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Buffer: Previous" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Buffer: Next" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Buffer: Delete" })

-- =============================================================================
-- Visual Mode Improvements
-- =============================================================================
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Keep yanked text when pasting over selection
vim.keymap.set("v", "p", '"_dP', { silent = true })

-- Move text blocks up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- =============================================================================
-- Terminal Mode
-- =============================================================================
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit mode" })
vim.keymap.set("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "Terminal: Open split" })

-- =============================================================================
-- Diagnostics
-- =============================================================================
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostic: Previous" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostic: Next" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic: Show float" })
vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, { desc = "Diagnostic: Project Quickfix List" })

-- =============================================================================
-- Quickfix Navigation
-- =============================================================================
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Quickfix: Next" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Quickfix: Prev" })
