return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle the undotree window" })
        vim.g.undotree_SetFocusWhenToggle = 1
    end
}
