return {
    "saghen/blink.cmp",
    opts = function(_, opts)
        opts.sources = opts.sources or {}

        if vim.g.no_snippet then
            opts.snippets = { preset = "default" }
            opts.sources.default = { "lsp", "path", "buffer" }
        else
            opts.snippets = { preset = "luasnip" }
            opts.sources.default = { "lsp", "path", "snippets", "buffer" }
        end

        opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
            ghost_text = { enabled = false },
            menu = { auto_show = false },
        })

        opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
            preset = "none",
            ["<CR>"] = { "fallback" },
            ["<Tab>"] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.accept()
                    end
                end,
                "fallback",
            },
            ["<C-n>"] = { function(cmp) cmp.select_next() end },
            ["<C-p>"] = { function(cmp) cmp.select_prev() end },
            ["<Down>"] = { function(cmp) cmp.select_next() end },
            ["<Up>"]   = { function(cmp) cmp.select_prev() end },
            ["<C-Space>"] = { function(cmp) cmp.show() end },
        })
    end,
}
