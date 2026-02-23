-- =============================================================================
-- Globals (Must be set before plugins load)
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- =============================================================================
-- UI & Appearance
-- =============================================================================
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Use relative numbering
vim.opt.numberwidth = 4 -- Set column width for numbers
vim.opt.signcolumn = "yes" -- Always show sign column (prevents "jumping" text)
vim.opt.cursorline = true -- Highlight current line
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmode = false -- Mode handled by statusline
vim.opt.pumheight = 10 -- Max items in popup menu
vim.opt.conceallevel = 0 -- Keep text visible
vim.opt.showtabline = 2 -- Always show tab bar
vim.opt.cmdheight = 1 -- Command line height
vim.opt.laststatus = 3 -- Global statusline (optional, but looks cleaner)

-- Whitespace display
vim.opt.list = true -- Enable list mode (show invisible characters)
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- =============================================================================
-- Behavior & Logic
-- =============================================================================
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.undofile = true -- Persistent undo history
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequences
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backups
vim.opt.writebackup = false -- Disable backup when writing
vim.opt.confirm = true -- Raise dialog for unsaved changes
vim.opt.inccommand = "split" -- Preview substitutions live
vim.opt.fileencoding = "utf-8" -- Encoding written to file
vim.opt.autoread = true -- Automatically re-read file if it changes on disk
vim.opt.autowrite = true -- Automatically save before switching buffers

-- Prevent window layout destruction when closing splits (important for Neo-tree)
vim.opt.equalalways = false

-- Clipboard: Scheduled to improve startup time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- =============================================================================
-- Tabs & Indentation
-- =============================================================================
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Indent size
vim.opt.tabstop = 4 -- Width of a tab character
vim.opt.softtabstop = 4 -- Tab width while editing
vim.opt.autoindent = true -- Keep indentation
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.breakindent = true -- Wrapped lines keep indentation

-- =============================================================================
-- Search & Navigation
-- =============================================================================
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Case-sensitive if caps are used
vim.opt.hlsearch = false -- Clear highlight after search
vim.opt.splitbelow = true -- New horizontal splits go below
vim.opt.splitright = true -- New vertical splits go right
vim.opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right
vim.opt.whichwrap:append("bs<>[]hl") -- Keys that can move to next/prev line

-- =============================================================================
-- Wrapping & Text Handling
-- =============================================================================
vim.opt.wrap = false -- Disable line wrapping
vim.opt.linebreak = true -- Don't break words
vim.opt.iskeyword:append("-") -- Treat hyphenated words as one word
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Stop auto-commenting new lines

-- =============================================================================
-- Autocommands
-- =============================================================================
-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Save when focus is lost or when switching buffers
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = "*",
	command = "silent! wall",
})
