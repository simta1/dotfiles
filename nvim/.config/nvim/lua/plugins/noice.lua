return {
    "folke/noice.nvim",
    opts = function(_, opts)
        if not opts.routes then opts.routes = {} end

        table.insert(opts.routes, {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+ lines yanked" },
                    { find = "yanked" },
                },
            },
            opts = { skip = true },
        })
    end,
}
