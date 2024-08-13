return {
    "lervag/vimtex",
    lazy = false, -- Lazy loading is handled by the plugin itself
    init = function()
        vim.g.vimtex_view_general_viewer = 'okular'
        vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

    end,
}
