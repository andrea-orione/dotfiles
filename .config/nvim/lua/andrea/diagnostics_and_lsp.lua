local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true, -- disable virtual text
    signs = {
        active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- Lsp on attach set keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("orion-lsp-keymaps", { clear = true }),
    callback = function(event)
        local telescope = require("telescope.builtin")

        local keymap = function(keys, func, description)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = description, noremap = true, silent = true })
        end

        keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        keymap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        keymap("<leader>lD", telescope.lsp_type_definitions, "Type [D]efinition")
        keymap("<leader>lds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
        keymap("<leader>lws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        keymap("K", vim.lsp.buf.hover, "Hover Documentation")

        keymap("<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, "[L]SP [F]ormat")
        keymap("<leader>li", "<cmd>LspInfo<cr>", "[I]nfo")
        keymap("<leader>lI", "<cmd>LspInstallInfo<cr>", "[I]nstall info")
        keymap("<leader>la", vim.lsp.buf.code_action, "code [A]ction")
        keymap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
        keymap("<leader>ls", vim.lsp.buf.signature_help, "[S]ignature help")
        keymap("<leader>lq", vim.diagnostic.setloclist, "[S]et local list")

        keymap("<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, "[F]ormat")
        keymap("<leader>ll", vim.lsp.codelens.run, "CodeLens Action")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            keymap("<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, "[L]SP toggle inlay [H]ints")
        end

    end,
})
