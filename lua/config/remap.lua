-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Local toggle function
local function opt_toggle(option, state_on, state_off, msg_name)
    local message = msg_name
    if vim.opt[option]:get() == state_off then
        vim.opt[option] = state_on
        message = message .. " enabled"
    else
        vim.opt[option] = state_off
        message = message .. " disabled"
    end
    vim.notify(message)
end

-- Toggle line numbers for copying
vim.keymap.set("n", "<leader>tl", function()
    opt_toggle("relativenumber", true, false, "Relative line numbers")
    opt_toggle("number", true, false, "Line numbers")
end)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>tw", function()
    opt_toggle("wrap", true, false, "Line wrapping")
end)

-- GOATed remaps : Jimothy 'T(he)' Primeagen, asbjornHaland
-- Replace visual selection with stored content
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Delete visual selection or by movement without overwriting yank register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
-- Store selection (by movement)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Store selection (by movement)
vim.keymap.set("n", "<leader>Y", [["+Y]])
