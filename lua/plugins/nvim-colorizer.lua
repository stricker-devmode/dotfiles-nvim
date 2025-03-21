return {
    "norcalli/nvim-colorizer.lua",
    config = function()
       require("colorizer").setup({
            'css';
            'scss';
            'conf';
        }, { css_fn = true; })
    end
}
