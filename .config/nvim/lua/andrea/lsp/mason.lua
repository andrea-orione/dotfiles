local servers = {
    lua_ls = require("andrea.lsp.settings.lua_ls"),
    clangd = {
        settings = {
            ["clangd"] = {
                excludeArgs = { "-frounding-math" },
                includeDirs = { "./include" },
            },
        },
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "off",
                },
            },
        },
    },
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                diagnostics = {
                    enable = false;
                }
            }
        }
    },
    texlab = {} ,
    jsonls = require("andrea.lsp.settings.jsonls"),
    -- gopls = {},
    -- cssls = {},
    -- html = {},
    -- tsserver = {},
    -- bashls = {},
    -- yamlls = {} ,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require("mason").setup({
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

local ensure_installed_list = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed_list, { 'stylua', })-- Used to format Lua code
require('mason-tool-installer').setup({ ensure_installed = ensure_installed_list })

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed by the server configuration above.
            -- Useful when disabling certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
    ensure_installed = servers,
    automatic_installation = true,
})
