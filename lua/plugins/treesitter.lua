return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            -- indent = {
            --     enable = true
            -- },
            --
            -- highlight = {
            --     -- `false` will disable the whole extension
            --     enable = true,
            --     disable = function(lang, buf)
            --         local max_filesize = 100 * 1024 -- 100 KB
            --         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --         if ok and stats and stats.size > max_filesize then
            --             vim.notify(
            --                 "File larger than 100KB treesitter disabled for performance",
            --                 vim.log.levels.WARN,
            --                 {title = "Treesitter"}
            --             )
            --             return true
            --         end
            --     end,
            --
            --     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            --     -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
            --     -- Using this option may slow down your editor, and you may see some duplicate highlights.
            --     -- Instead of true it can also be a list of languages
            --     additional_vim_regex_highlighting = { "markdown" },
            -- },
        })
    end,
    init = function ()
        -- A list of parser names, or "all"
        local ensureInstalled = {
            "bash",
            "c",
            "javascript",
            "json",
            "lua",
            "markdown",
            "rust",
            "typescript",
            "vimdoc",
            "yaml",
        }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim.iter(ensureInstalled):filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
        end):totable()
        require('nvim-treesitter').install(parsersToInstall)
        
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
          })
    end
}
