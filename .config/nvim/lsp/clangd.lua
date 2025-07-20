return {
    settings = {
        ["clangd"] = {
            excludeArgs = { "-frounding-math" },
            includeDirs = { "./include", "./lib" },
            tabsize = 2,
        },
    },
}
