return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    opts = {
        sections = {
            lualine_c = {
                {
                    "filename",
                    path = 1,
                    symbols = { modified = "[+]", readonly = "[-]" },
                    separator = { right = "" },
                    color = { bg = "#3d59a1", },
                },
                {
                    function()
                        local size = vim.fn.wordcount().bytes
                        if size <= 0 then return "" end
                        local format_size = size < 20000 and size .. "B" 
                        or size < 1024 * 1024 and string.format("%.1fKB", size / 1024)
                        or string.format("%.1fMB", size / (1024 * 1024))
                        return format_size
                    end,
                    separator = { right = "" },
                    color = { bg = "#708090", },
                },
            },
        },
    },
}
