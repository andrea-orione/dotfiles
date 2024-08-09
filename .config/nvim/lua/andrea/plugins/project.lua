-- Project management
return {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {
        manual_mode = false, -- if true it disables setting the current directory to root
        detection_methods = { "lsp", "pattern" }, -- order matters
        show_hidden = true, -- show hidden files in telescope
        silent_chdir = true, -- if false, you get a message when project changes your directory.
        datapath = vim.fn.stdpath("data"), -- path to store the project history for use in telescope
    }
}
