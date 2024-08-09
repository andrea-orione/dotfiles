return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
        delay = 100,
        large_file_cutoff = 3000, -- Number of lines after which is disabled
        min_count_to_highlight = 1, -- Minimum number of matches to highlight
    },
    config = function(LazyPackage, opts)
        local illuminate = require("illuminate")
        illuminate.configure(opts)

        -- Lsp on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("orion-illuminate", { clear = true }),
            callback = function(event)

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                illuminate.on_attach(client)
            end,
        })
    end
}
