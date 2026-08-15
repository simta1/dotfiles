return {
    "folke/noice.nvim",
    opts = function(_, opts)
        table.insert(opts.routes, {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+ more lines" },
                    { find = "%d+ fewer lines" },
                    { find = "%d+ lines yanked" },
                    { find = "%d+ lines indented" },
                    { find = "yanked" },
                },
            },
            opts = { skip = true },
        })

        opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
            signature = {
                auto_open = {
                    enabled = false,
                },
            },
        })
    end,
}
