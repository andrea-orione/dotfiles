return {
    "mbbill/undotree",
    event = { "BufNewFile", "BufReadPost", "FileReadPost" },
    config = function()
        vim.keymap.set("n", "<leader>pu", vim.cmd.UndotreeToggle, { silent = true, noremap = true, desc = "Toggle [U]ndoTree"})
    end,
}
