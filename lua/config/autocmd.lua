-- Shorthand because I'm not writing all of that every single time
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- UI highlighting
local group_ui_highlight = augroup("UIHighlight", { clear = true })

-- Incremental search highlighting fix
autocmd("CmdLineEnter", {
    desc = "Activate highlighting when entering search",
    group = group_ui_highlight,
    pattern = { "/", "?" },
    callback = function() vim.opt.hlsearch = true end,
})
autocmd("CmdLineLeave", {
    desc = "Deactivate highlighting when exiting search",
    group = group_ui_highlight,
    pattern = { "/", "?" },
    callback = function() vim.opt.hlsearch = false end,
})

-- Flash yanked text briefly as confirmation
autocmd("TextYankPost", {
    desc = "Briefly flash yanked section",
    group = group_ui_highlight,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})


-- LSP Autocommands
local group_lsp = augroup("LSPCommands", {})

-- Load LSP keymap
autocmd("LspAttach", {
    desc = "Load LSP keybindingds on attaching",
    group = group_lsp,
    callback = function(e)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { buffer = e.buf, desc = "LSP: Go to symbol definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "LSP: Show hover" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
            { buffer = e.buf, desc = "LSP: Query workspace symbol" })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
            { buffer = e.buf, desc = "LSP: Open diagnostics float" })
        vim.keymap.set("n", "<leader>vN", function() vim.diagnostic.goto_prev() end,
            { buffer = e.buf, desc = "LSP: Go to next diagnostic" })
        vim.keymap.set("n", "<leader>vn", function() vim.diagnostic.goto_next() end,
            { buffer = e.buf, desc = "LSP: Go to previous diagnostic" })
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
            { buffer = e.buf, desc = "LSP: Trigger code action prompt" })
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
            { buffer = e.buf, desc = "LSP: List symbol references in buffer" })
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
            { buffer = e.buf, desc = "LSP: Rename symbol in buffer" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = e.buf, desc = "LSP: Show code signature help float" })
    end
})

-- Fix detection of docker compose files
autocmd({ "BufReadPost", "BufNewFile" }, {
    desc = "Docker compose filetype matching for LSP autostart",
    group = group_lsp,
    pattern = { "docker-compose*.yaml", "compose*.yaml", "docker-compose*.yml", "compose*.yml" },
    callback = function()
        vim.bo.filetype = "yaml.docker-compose"
    end
})
