local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    vim.notify("Something went wrong loading project")
    return
end
project.setup({
    active = true,
    on_config_done = nil,
    manual_mode = false, -- if true it disables setting the current directory to root
    detection_methods = { "pattern", "lsp" }, -- order matters
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = true, --show hidden files in telescope

    silent_chdir = true, -- if false, you get a message when project changes your directory.
    datapath = vim.fn.stdpath("data"), -- path to store the project history for use in telescope
})
