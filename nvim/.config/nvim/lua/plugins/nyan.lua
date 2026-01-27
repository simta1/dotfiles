return {
    {
        "abosnjakovic/nyan.nvim",
        opts = {
            width = 20,
            animation = { enabled = true, fps = 6, },
            min_buffer_lines = 10,
            fallback = "none",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, 1, {
                require("nyan").get,
                cond = require("nyan").should_display,
            })
        end,
    },
}
