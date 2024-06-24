return {
  settings = {
    ["clangd"] = {
      excludeArgs = { "-frounding-math" },
      includeDirs = { "./include" },
    },
  },
}
