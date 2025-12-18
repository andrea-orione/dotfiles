return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash", "bibtex",
            "c", "cmake", "comment", "cpp", "css", "csv",
            "diff", "doxygen",
            "gitcommit", "gitignore", "glsl", "gnuplot",
            "html", "hyprlang",
            "javascript", "json", "jsonc",
            "latex", "lua", "luadoc",
            "make", "markdown", "markdown_inline",
            "norg",
            "org",
            "python",
            "rasi", "rust",
            "toml",
            "vim", "vimdoc"
        },
        sync_install = false, -- install languages syncronously
        auto_install = true,

        -- Modules
        highlight = {
            enable = true,
            disable = { "latex", }
        },
        indent = {
            enable = true,
        },
    },

    config = function(_, opts)
        local treesitter = require("nvim-treesitter")
        require("nvim-treesitter.install").prefer_git = true
        local config = require("nvim-treesitter.configs")

        vim.filetype.add({
            pattern = {[".*/hypr/.*%.conf"] = "hyprlang" },
        })

        treesitter.setup()
        config.setup(opts)
    end,
}
