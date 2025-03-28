return {
    -- tools
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "stylua",
                "selene",
                "luacheck",
                "shellcheck",
                "shfmt",
                "tailwindcss-language-server",
                "typescript-language-server",
                "css-lsp",
                "java-debug-adapter",
                "java-test",
                "cmakelang",
                "cmakelint",
                "goimports",
                "gofumpt",
                "gomodifytags",
                "impl",
                "delve",
                "clangd",  -- clangd already here
                "ktlint",
                "phpcs",
                "php-cs-fixer",
                "codelldb",
                "rust-analyzer",  -- rust-analyzer already here
                "gopls",  -- Add gopls here
            })
        end,
    },

    -- lsp servers
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            servers = {
                cssls = {},
                tailwindcss = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                },
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = {
                                    enabled = true,
                                    ignore = { "E501", "E302", "E303", "W191", "E226", "W291", "E305", "W293" },
                                    maxLineLength = 100,
                                },
                            },
                        },
                    },
                },
                tsserver = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                    single_file_support = false,
                    settings = {
                        typescript = { inlayHints = { ... } },
                        javascript = { inlayHints = { ... } },
                    },
                },
                html = {},
                yamlls = {
                    settings = {
                        yaml = { keyOrdering = false },
                    },
                },
                lua_ls = {
                    single_file_support = true,
                    settings = { Lua = { workspace = { checkThirdParty = false } } },
                },

                -- Rust Analyzer configuration (already added)
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { loadOutDirsFromCheck = true },
                            procMacro = { enable = true },
                        },
                    },
                },

                -- clangd configuration (already added)
                clangd = {
                    settings = {
                        clangd = {
                            compilationDatabaseDirectory = "build",  -- Adjust the directory if needed
                            fallbacks = { "clang" },
                            extraArgs = { "--header-insertion=iwyu" },  -- Optional: Improve header inclusion
                            diagnostics = {
                                enable = true,
                                clazy = true,  -- Optional for Qt development
                            },
                        },
                    },
                },

                -- gopls configuration
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,  -- Enable linting for unused parameters
                                nilness = true,  -- Check for potential nil dereferencing
                                shadow = true,  -- Warn on shadowing of variables
                            },
                            staticcheck = true,  -- Enable advanced static checks
                            completionDocumentation = true,  -- Include documentation in completions
                            usePlaceholders = true,  -- Enable code placeholders in completions
                            symbolMatcher = "Fuzzy",  -- Use fuzzy matching for symbols
                        },
                    },
                },
            },
            setup = {},
        },
    },

    -- Key mappings (unchanged)
    {
        "neovim/nvim-lspconfig",
        opts = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            vim.list_extend(keys, {
                {
                    "gd",
                    function()
                        require("telescope.builtin").lsp_definitions({ reuse_win = false })
                    end,
                    desc = "Goto Definition",
                    has = "definition",
                },
            })
        end,
    },
}
