return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	opts = {
		-- ============================================================================
		-- KEYMAP CONFIGURATION
		-- ============================================================================
		keymap = {
			preset = "default",
			-- Accept completion
			["<CR>"] = { "accept", "fallback" },
			-- Show/hide completion menu
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			-- Navigate completions
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			-- Navigate within snippets
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
			-- Scroll documentation
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},

		-- ============================================================================
		-- APPEARANCE CONFIGURATION
		-- ============================================================================
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = true,
			kind_icons = {
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",
				Field = "󰜢",
				Variable = "󰆓",
				Class = "󰌗",
				Interface = "󰜰",
				Module = "󰏗",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "󰎨",
				Keyword = "󰌋",
				Snippet = "󰄴",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "󰎡",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "󰉁",
				Operator = "󰆕",
				TypeParameter = "󰊄",
			},
		},

		-- ============================================================================
		-- COMPLETION CONFIGURATION
		-- ============================================================================
		completion = {
			menu = {
				-- Don't show scrollbar
				scrollbar = false,
				-- Limit menu height
				max_height = 10,
				-- Pretty borders
				border = "rounded",
				-- Transparency (0 = opaque, 100 = transparent)
				winblend = 0,
				-- Draw configuration
				draw = {
					-- Padding inside menu
					padding = 1,
					-- Gap between icon and text
					gap = 1,
					-- What to display in columns
					columns = { { "kind_icon" }, { "label", "label_description" } },
					-- Treesitter context display
					treesitter = { "lsp" },
				},
			},

			-- Documentation window
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winblend = 0,
					max_width = 80,
					max_height = 20,
				},
			},

			-- Ghost text (preview completion before accepting)
			ghost_text = {
				enabled = true,
			},
		},

		-- ============================================================================
		-- SOURCES CONFIGURATION
		-- ============================================================================
		sources = {
			-- Default sources in priority order
			default = { "lsp", "path", "snippets", "buffer" },

			-- Per-filetype source configuration
			per_filetype = {
				-- Lua: no buffer completion (LSP is enough)
				lua = { "lsp", "path", "snippets" },
				-- Go: standard stack
				go = { "lsp", "path", "snippets", "buffer" },
				-- Shell: simpler completion
				sh = { "path", "buffer" },
				-- Command line completion
				vim = { "path", "buffer" },
			},
		},

		-- ============================================================================
		-- COMMAND-LINE COMPLETION (Moved to new location)
		-- ============================================================================
		cmdline = {
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					-- Search: use buffer
					return { "buffer" }
				end
				if type == ":" then
					-- Command: use path
					return { "path" }
				end
				return {}
			end,
		},

		-- ============================================================================
		-- SIGNATURE HELP
		-- ============================================================================
		signature = {
			enabled = true,
		},

		-- ============================================================================
		-- SNIPPETS
		-- ============================================================================
		snippets = {
			preset = "default",
		},

		-- ============================================================================
		-- FUZZY MATCHING
		-- ============================================================================
		fuzzy = {
			-- Use prebuilt binaries for speed
			prebuilt_binaries = {
				download = true,
			},
		},
	},

	-- Allow extending sources from other plugins
	opts_extend = { "sources.default" },
}
