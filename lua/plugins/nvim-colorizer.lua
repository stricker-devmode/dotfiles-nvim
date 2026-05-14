return {
    "catgoose/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            filetypes = {
                "*",
                css = { mode = "background", names = { enable = true } },
                html = { mode = "background", names = { enable = true } },
                scss = { mode = "background", names = { enable = true } },
            },
            options = {
                display = {
                    mode = "virtualtext",
                    virtualtext = { position = "after" },
                },
                parsers = { css = true, names = { enable = false } },
            },
        })
    end,
}
