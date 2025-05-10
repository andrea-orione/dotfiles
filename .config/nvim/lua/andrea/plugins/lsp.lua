local servers = require("andrea.servers")
local formatters = {}

local ensure_installed_list = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed_list, formatters)

local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "j-hui/fidget.nvim", opts = {} },
        },
        event = "VeryLazy",
        config = function(_, _)
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            for server_name, server in pairs(servers) do
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end
        end,
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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
        },
        event = "VeryLazy",
        opts = {
            ensure_installed = ensure_installed_list,
            auto_update = true
        }

    }
}
