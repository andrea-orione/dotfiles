-- PLUGINS
-- This file sets up lazy and installs all the needed packages

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    print("Installing lazy close and reopen Neovim...")
end
vim.opt.rtp:prepend(lazypath)

-- a protected call so we don't error out on first
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify("Something went wrong loading lazy")
    return
end

-- Install your plugins here
lazy.setup({
    spec = {
        { import = "andrea.plugins" },
    },
    checker = {
        enabled = true,
        notify = true,
    },
    change_detection = {
        notify = false,
    }
})
