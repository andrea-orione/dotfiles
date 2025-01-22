local servers = {
    bashls = {},
    clangd = {
        settings = {
            ["clangd"] = {
                excludeArgs = { "-frounding-math" },
                includeDirs = { "./include" },
                tabsize = 2,
            },
        },
    },
    html = {},
    jsonls = require("andrea.servers.jsonls"),
    lua_ls = require("andrea.servers.lua_ls"),
    pyright = {
        settings = { python = { analysis = { typeCheckingMode = "on", }, }, },
    },
    rust_analyzer = {
        settings = { ['rust_analyzer'] = { diagnostics = false, }, }
    },
    texlab = {},
    zls = {},
}

local formatters = {}
local ensure_installed_list = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed_list, formatters)

return {
    "williamboman/mason.nvim", -- language server installer
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
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
    config = function(_, opts)
        require("mason").setup(opts)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed_list })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
            ensure_installed = servers,
            automatic_installation = true,
        })
    end,
}
