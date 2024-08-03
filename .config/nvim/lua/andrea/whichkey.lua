local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    vim.notify("Something went wrong loading which-key")
    return
end

local setup = {
    preset = "classic", -- layout (false, "classic", "modern", "helix"). Use false to costumize with win
    delay = function(ctx) return ctx.plugin and 0 or 200 end,
    filter = function(mapping) return mapping.desc and mapping.desc ~= "" end, -- This excludes mappings without a description
    notify = true, -- show a warning when issues were detected with your mappings
    -- triggers = {  -- Which keys trigger the panel
    --     { "<auto>", mode = "nxsot" },
    --     { "<leader>", mode = "nxsot" },
    -- },
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
}

-- Old version
-- local mappings = {
--     ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
--     ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
--     ["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
--     ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
--     ["<leader>t"] = { name = "[T]erminal", _ = "which_key_ignore" },
-- }

-- New version
local mappings = {
    { "<leader>d", group = "[D]iagnostics" },
    { "<leader>d_", hidden = true },
    { "<leader>g", group = "[G]it" },
    { "<leader>g_", hidden = true },
    { "<leader>l", group = "[L]SP" },
    { "<leader>l_", hidden = true },
    { "<leader>s", group = "[S]earch" },
    { "<leader>s_", hidden = true },
    { "<leader>t", group = "[T]erminal" },
    { "<leader>t_", hidden = true },
}

which_key.setup(setup)
which_key.add(mappings)
