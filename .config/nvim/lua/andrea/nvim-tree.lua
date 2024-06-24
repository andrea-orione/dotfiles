-- FILE EXPLORER

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("Something went wrong loading vim tree")
    return
end

local config_status_ok, _ = pcall(require, "nvim-tree.api")
if not config_status_ok then
    vim.notify("Something went wrong loading vim tree api")
    return
end

-- Custom bindings
-- local function my_on_attach(bufnr)
--     local function opts(desc)
--         return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--     end
--
--     -- default mappings
--     tree_api.config.mappings.default_on_attach(bufnr)
--
--     -- custom mappings
--     vim.keymap.set('n', 'l', tree_api.node.open.edit)
--     vim.keymap.set('n', 'o', tree_api.node.open.edit)
--     vim.keymap.set('n', 'h', tree_api.node.navigate.parent_close)
--     vim.keymap.set('n', 'v', tree_api.node.open.vertical)
-- end

nvim_tree.setup({
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        side = "left",
    },
    -- on_attach = my_on_attach,
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "[E]xplorer" })
