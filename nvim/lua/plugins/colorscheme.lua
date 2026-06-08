return {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("dracula")
        vim.o.background = "dark"

        local set_hl = vim.api.nvim_set_hl
        -- set_hl(0, "Search", {
        --     underline = true,
        --     bold = true,
        --     bg = "NONE",
        --     fg = "#eeff41",
        --     ctermfg = 190
        -- })
        -- set_hl(0, "IncSearch", {
        --     underline = true,
        --     bold = true,
        --     bg = "NONE",
        --     fg = "#00ffc3",
        --     ctermfg = 49
        -- })
        -- set_hl(0, "CurSearch", {
        --     underline = true,
        --     bold = true,
        --     bg = "NONE",
        --     fg = "#00ffc3",
        --     ctermfg = 49
        -- })
        -- set_hl(0, "NonText", { fg = "#6c7086", bg = "NONE" })
        set_hl(0, "NormalFloat", { bg = "#181424" })
        set_hl(0, "WinSeparator", { fg = "#89b4fa", bg = "NONE", bold = true })
    end,
}
