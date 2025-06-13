return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
        "mfussenegger/nvim-lint",
        "saadparwaiz1/cmp_luasnip",
        "stevearc/conform.nvim",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        "windwp/nvim-autopairs"
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        local luasnip = require("luasnip")

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "gopls",
                "jedi_language_server",
                "lua_ls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                -- stop screaming in nvim config
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        require("nvim-autopairs").setup({})
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-a>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.complete(),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select)
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-j>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item(cmp_select)
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
        local inlay_hints = {
            enabled = true
        }
    end
}
