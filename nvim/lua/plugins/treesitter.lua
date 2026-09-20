return {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,

    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        local languages = {
            "c",
            "cpp",
            "lua",
            "python",
            "bash",
            "json",
            "yaml",
            "markdown",
        }

        treesitter.setup()

        -- Install required parsers.
        -- Already-installed parsers are skipped.
        treesitter.install(languages)

        -- Enable Treesitter highlighting.
        vim.api.nvim_create_autocmd("FileType", {
            pattern = languages,
            callback = function(args)
                vim.treesitter.start(args.buf)
            end,
        })
    end,
}
