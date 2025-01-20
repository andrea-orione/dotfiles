-- Status line
local evil_icon = false
local global_bar = false

local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
    black    = '#000000',
}

local mode_color = {
    n = colors.green,
    i = colors.blue,
    v = colors.magenta,
    [''] = colors.blue,
    V = colors.blue,
    c = colors.red,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}

local mode_icon = {
    n = "󰰓",
    i = "󰰄",
    v = "󰰫",
    [''] = "󰰫",
    V = "󰰫",
    c = "󰯲",
    no = "󰰓",
    s = "󰰢",
    S = "󰰢",
    [''] = "󰰢",
    ic = "󰰄",
    R = "󰰟",
    Rv = "󰰟",
    cv = "󰯲",
    ce = "󰯲",
    r = "󰰟",
    rm = "󰰟",
    ['r?'] = "󰰟",
    ['!'] = "󰯲",
    t = "󰰥",
}

local section_a = {
    {
        function() return '▊' end,
        color = { fg = colors.cyan },
        padding = { left = 0, right = 1 },
    },
    {
        function()
            return evil_icon and '' or mode_icon[vim.fn.mode()]
        end,
        color = function()
           return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
    },

}
local section_b = {
    {
        'filename',
        cond = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        color = { fg = colors.magenta, gui = 'bold' },
    },
    {
        'filesize',
        cond = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
    },
    {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
    },
}

local section_b_inactive = {
    {
        'filename',
        cond = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        color = { fg = colors.fg, gui = 'bold' },
        padding = { left = 5, right = 1 },
    },
    {
        'filesize',
        cond = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
    },
    {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
    },
}
local section_c = {
    {
        function()
            return '%=' -- Insert mid section
        end,
    },
    {
        function()
            local msg = 'no active lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', {})
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end,
        icon = '  LSP:',
        color = { fg = colors.cyan, gui = 'bold' },
    },
}
local section_x = {
    {
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = function()
            return vim.fn.winwidth(0) > 80
        end,
        color = { fg = colors.green, gui = 'bold' },
    },
    {
        'fileformat',
        fmt = string.upper,
        icons_enabled = true,
        color = { fg = colors.green, gui = 'bold' },
    },
}
local section_y = {
    { 'location' },
    {
        'progress',
        color = { fg = colors.fg, gui = 'bold' }
    },
}
local section_z = {
    {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
    },
    {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
        },
        cond = function()
            return vim.fn.winwidth(0) > 80
        end,
    },
    {
        function()
            return '▊'
        end,
        color = { fg = colors.cyan },
        padding = { left = 1 },
    },
}

local tab_a = {
    {
        "filename",
        color = function(section)
            return {
                fg = vim.bo.modified and colors.orange or colors.fg,
                gui = 'bold'
            }
        end,
        file_status = true,
        newfile_status = true,
        path = 3, -- 0: just filename, 1: relative, 2: absolute, 3: absolute with tilde
        shorting_target = 40,
        symbols = {
            modified = ' ',
            readonly = '[󰌾 Readonly]',
            unnamed = '[No Name]',
            newfile = '[󰎔 New]',
        },
    },
}

local tab_z = {
    {
        'tabs',
        tab_max_length = 40,
        mode = 0, -- 0: tab_nr, 1: tab_name, 2: tab_nr + tab_name
        path = 0, -- 0: just filename, 1: relative path and tilde, 2: full path, 3: full path and tilde

        -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
        use_mode_colors = false,

        tabs_color = {
            active = { fg = colors.cyan, gui = "bold"},
            inactive = { fg = colors.fg },
        },

        show_modified_status = false,
    },
}

local tab_void = {
    {
        function ()
            return ""
        end,
        color = { bg = colors.black }
    }
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
        options = {
            component_separators = '',
            section_separators = '',
            theme = {
                normal = {
                    a = { fg = colors.fg, bg = colors.bg },
                    b = { fg = colors.fg, bg = colors.bg },
                    c = { fg = colors.fg, bg = colors.bg }
                },
                inactive = {
                    a = { fg = colors.fg, bg = colors.bg },
                    b = { fg = colors.fg, bg = colors.bg },
                    c = { fg = colors.fg, bg = colors.bg }
                },
            },
            globalstatus = global_bar,
        },
        sections = {
            lualine_a = section_a,
            lualine_b = section_b,
            lualine_c = section_c,
            lualine_x = section_x,
            lualine_y = section_y,
            lualine_z = section_z,
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = section_b_inactive,
            lualine_c = {},
            lualine_x = {},
            lualine_y = section_y,
            lualine_z = {},
        },
        tabline = {
            lualine_a = tab_a,
            lualine_b = tab_void,
            lualine_c = tab_void,
            lualine_x = tab_void,
            lualine_y = tab_void,
            lualine_z = tab_z,
        },
        extensions = { "nvim-tree", },
    },

    config = function(_, opts)
        local original_theme = require("lualine.themes.auto")
        opts.options.theme.normal.c.bg = original_theme.normal.c.bg
        opts.options.theme.normal.a.bg = original_theme.normal.c.bg
        opts.options.theme.normal.b.bg = original_theme.normal.c.bg
        require("lualine").setup(opts)
    end,
}

