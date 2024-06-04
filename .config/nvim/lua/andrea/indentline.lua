local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
    vim.notify("Something went wrong loading indentline")
    return
end

indent_blankline.setup({
    enabled = true,
    indent = {
        char = "▏", -- other possible options are "▎" or "│"
        smart_indent_cap = true,
    },
    whitespace = {
        remove_blankline_trail = true,
    },
    scope = {
        enabled = true,
        char = "▎",
        show_start = false,
        show_end = false,
    },
    exclude = {
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
        filetypes = { "help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble" },
    },
})
