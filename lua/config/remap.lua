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
    end,
    { desc = "Toggle all line numbers" }
)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>tw", function()
        opt_toggle("wrap", true, false, "Line wrapping")
    end,
    { desc = "Toggle line wrapping" }
)

-- GOATed remaps : Jimothy 'T(he)' Primeagen, asbjornHaland
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace visual selection with content of yank register" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]],
    { desc = "Delete visual selection or movement without overwriting yank register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Store selection (or movement) in yank register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Store current line in yank register" })

-- Make current file executable
vim.keymap.set("n", "<leader>x", [[:!chmod +x %<CR>]], { silent = true })

-- Trigger formatting with conform.nvim
-- Jimothy 'T(he)' Primeagen feat. https://www.josean.com/posts/neovim-linting-and-formatting
vim.keymap.set({ "n", "v" }, "<leader>f", function()
        require("conform").format({ lsp_fallback = true })
    end,
    { desc = "Format current file or visual range" }
)

-- Trigger linting with nvim-lint
vim.keymap.set("n", "<leader>l", function()
        require("lint").try_lint()
    end,
    { desc = "Trigger linting of current file" })
