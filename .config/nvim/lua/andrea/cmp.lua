local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("Something went wrong loading cmp")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Something went wrong loading luasnip")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = " ",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = " ",
    Misc = " ",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- Old "<C-k>"
        ["<C-n>"] = cmp.mapping.select_next_item(), -- Old "<C-j>"
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(), -- toggle completion list

        ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Old "<CR>"

        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        -- In snippes jump to the next/previous placeholder
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),

        -- Old tab completion
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then cmp.select_next_item()
        --     elseif luasnip.expandable() then luasnip.expand()
        --     elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
        --     else fallback()
        --     end
        -- end, {"i", "s",}),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then luasnip.jump(-1)
        --     else fallback()
        --     end
        -- end, {"i", "s",}),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
})
