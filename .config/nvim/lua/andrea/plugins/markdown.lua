return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ft = "markdown",
    opts = {
        enabled = true,
        max_file_size = 10.0, -- Disabled for files bigger than this size (in MB)
        debounce = 100, -- Milliseconds before updating marks (updates occur only within the visible window, not the entire buffer)
        file_types = { 'markdown' },
        render_modes = { 'n', 'c' }, -- Render will show only in these modes
        latex = {
            enabled = true,
            converter = 'latex2text',
        },
        heading = {
            enabled = true,
            sign = false, -- Signs to the sign column
            icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            signs = { '󰫎 ' },
        },
        code = {
            enabled = true,
            sign = false,
            -- Determines how code blocks & inline code are rendered:
            --  none: disables all rendering
            --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
            --  language: adds language icon to sign column if enabled and icon + name above code blocks
            --  full: normal + language
            style = 'full',
            position = 'left', -- Position of the icon
            width = 'full',
            border = 'thin',
        },
        dash = {
            enabled = true,
            icon = '─', -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
            width = 'full', -- <integer>: a hard coded width value, full: full width of the window
        },
        bullet = {
            enabled = true,
            icons = { '●', '○', '◆', '◇' },
        },
        checkbox = {
            enabled = true,
            unchecked = { icon = '󰄱 ' },
            checked = { icon = '󰱒 ' },
            custom = {
                todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
            },
        },
        quote = {
            enabled = true,
            icon = '▋', -- Replaces '>' of 'block_quote'
            repeat_linebreak = false, -- Repeat in wrapped lines
        },
        pipe_table = {
            enabled = true,
            preset = 'none', -- none: does nothing, round: use round borders
            style = 'full', -- none: not rendered, normal: no top and bottom, full: with top and bottom lines
            cell = 'padded', --  overlay: writes completely over the table, raw: replaces only the '|' characters in each row, padded: raw + cells are padded with inline extmarks
            alignment_indicator = '━',
            border = {
                '┌', '┬', '┐',
                '├', '┼', '┤',
                '└', '┴', '┘',
                '│', '─',
            },
        },
        callout = {
            note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
            tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
            important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
            warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
            caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
            abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
            todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
            success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
            question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
            failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
            danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
            bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
            example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
            quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
        },
        link = {
            enabled = true,
            image = '󰥶 ',
            hyperlink = '󰌹 ',
            custom = {
                web = { pattern = '^http[s]?://', icon = '󰖟 ', highlight = 'RenderMarkdownLink' },
            },
        },
    }
}

