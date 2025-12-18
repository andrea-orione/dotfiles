return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },

    opts = {
        provider_selector = function(_, _, _)
            return{ 'lsp', 'indent'}
        end
    },


    config = function(_, options)
        vim.opt.foldcolumn = "1"
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true

        require("ufo").setup(options)

        vim.keymap.set('n', 'zR', require("ufo").openAllFolds,
            { desc = "Open all folds" })
        vim.keymap.set('n', 'zM', require("ufo").closeAllFolds,
            { desc = "Close all folds" })
        vim.keymap.set('n', 'zK', function()
            local winid = require("ufo").peekFoldedLineUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { desc = "Peek Fold" })
    end,
}
