local general_group = vim.api.nvim_create_augroup("orion-general-settings", { clear = true })
local yanking_group = vim.api.nvim_create_augroup("orion-highlight-yank", { clear = true })

-- General autocommands. They run each time a condition is met. See :help lua-guide-autocommands
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" , "help", "man", "lsp_info" },
    desc = "Use q to close temporary buffers",
    group = general_group,
    callback = function(event)
        vim.keymap.set("n", "q", ":close<CR>", { noremap = true, silent = true, buffer = event.buf })
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    group = general_group,
    command = "set nobuflisted",
})
vim.api.nvim_create_autocmd("VimResized", {
    group = general_group,
    command = "tabdo wincmd = ",
})
-- TODO: Add spell checking

-- Highlighth when yanking text (e.g. when yap is used)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("orion-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
