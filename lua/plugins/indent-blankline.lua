return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    config = function()
        -- register hooks to follow colorscheme changes
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
            -- grab colors from the current colorscheme via default highlight groups
            -- alternate between two reasonably distinct but unobtrusive main colors
            vim.api.nvim_set_hl(0, "IndentColor01", { fg = vim.api.nvim_get_hl(0, { name = "Folded" }).fg })
            vim.api.nvim_set_hl(0, "IndentColor02", { fg = vim.api.nvim_get_hl(0, { name = "NonText" }).fg })
            -- use a more vibrant color to highlight the current scope
            vim.api.nvim_set_hl(0, "IndentColorScope", { fg = vim.api.nvim_get_hl(0, { name = "Directory" }).fg })
        end)
        require("ibl").setup({
            indent = {
                highlight = {
                    "IndentColor01",
                    "IndentColor02",
                }
            },
            scope = {
                highlight = { "IndentColorScope" }
            }
        })
    end
}
