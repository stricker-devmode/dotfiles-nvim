return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile"
    },
    config = function()
        local nl = require("lint")

        nl.linters_by_ft = {
            python = { "pylint" }
        }

        local nl_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = nl_augroup,
            callback = function()
                nl.try_lint()
            end
        })
    end
}
