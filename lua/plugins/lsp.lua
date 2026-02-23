return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "saghen/blink.cmp",
            { "folke/lazydev.nvim", ft = "lua", opts = {} },
            "yioneko/nvim-vtsls", -- Enhanced VTSLS support for commands
        },
        config = function()
            -- 1. DIAGNOSTICS CONFIGURATION
            vim.diagnostic.config({
                virtual_text = { prefix = "●", spacing = 4 },
                float = { border = "rounded", source = "if_many" },
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            })

            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋼 " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- 2. LSP ATTACH (Keymaps & Performance)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local bufnr = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local function map(keys, func, desc, mode)
                        vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                    end

                    -- Navigation & References
                    map("gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, "[G]oto [D]efinition")
                    map("grr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")
                    map("gI", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementation")

                    -- Refactoring & Actions
                    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                    -- VTSLS Specific Actions (The "VS Code" Experience)
                    if client.name == "vtsls" then
                        map("<leader>co", "VtslsOrganizeImports", "Organize Imports")
                        map("<leader>cR", "VtslsRemoveUnused", "Remove Unused Imports")
                        map("<leader>cf", "VtslsFixAll", "Fix All Diagnostics")
                    end

                    -- Automatic Inlay Hints
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end,
            })

            -- 3. SERVER CONFIGURATIONS
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local servers = {
                -- The Modern TypeScript Standard
                vtsls = {
                    settings = {
                        typescript = {
                            updateImportsOnFileMove = { enabled = "always" },
                            inlayHints = {
                                parameterNames = { enabled = "literals" },
                                variableTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                            },
                        },
                    },
                },
                gopls = {},
                lua_ls = {
                    settings = { Lua = { diagnostics = { globals = { "vim" } } } }
                },
                html = {},
                emmet_ls = { filetypes = { "html", "typescriptreact", "javascriptreact", "css" } },
            }

            -- 4. MASON TOOL INSTALLATION (Automated Persistence)
            -- We explicitly define these to ensure they are available on any machine.
            local ensure_installed = vim.tbl_keys(servers)
            vim.list_extend(ensure_installed, {
                "vtsls",               -- The primary Node server
                "js-debug-adapter",    -- For your DAP setup
                "eslint_d",            -- Lightning-fast linting
                "prettierd",           -- Non-blocking formatting
                "stylua",              -- Lua formatting
            })

            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server_config = servers[server_name] or {}
                        server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
                        require("lspconfig")[server_name].setup(server_config)
                    end,
                },
            })
        end,
    },
}
