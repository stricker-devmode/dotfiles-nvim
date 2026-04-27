return {
    "catgoose/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup({
            filetypes = {
                "*",
                css = { mode = "background" },
                html = { mode = "background" },
                scss = { mode = "background" },
            },
            options = {
                display = {
                    mode = "virtualtext",
                    virtualtext = { position = "after" },
                },
                parsers = { css = true },
            },
        })
    end
}
