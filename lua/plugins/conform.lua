return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatter_by_ft = {
                go = { "gofmt" },
                lua = { "stylua" },
                python = { "black" }
            }
        })
    end
}
