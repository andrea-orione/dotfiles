return {
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
