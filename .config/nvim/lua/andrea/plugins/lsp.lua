local servers = {
    "bashls",
    "clangd",
    "html",
    "jsonls",
    "lua_ls",
    "ltex_plus",
    "pyright",
    "rust_analyzer",
    "texlab",
    "zls"
}
local formatters = {}

local ensure_installed_list = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed_list, formatters)

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "j-hui/fidget.nvim", opts = {} },
        },
    },

    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            ui = {
                check_outdated_packages_on_open = true,
                border = "none",
                icons = {
                    package_installed = " ",
                    package_pending = "➜ ",
                    package_uninstalled = " ",
                },
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        event = "VeryLazy",
        opts = {
            ensure_installed = servers,
        },
    },
}
