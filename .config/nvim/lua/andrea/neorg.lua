local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    vim.notify("Something went wrong loading neorg")
    return
end

neorg.setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/Varie/Notes",
                    todo = "~/Varie/Todo",
                },
            },
        },
    },
}
