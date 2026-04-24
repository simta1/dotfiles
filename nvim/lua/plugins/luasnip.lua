return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        local from_vscode = require("luasnip.loaders.from_vscode")

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = false,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        })

        from_vscode.lazy_load()
        from_vscode.lazy_load({
            paths = { vim.fn.expand("~/.config/Code/User/snippets") },
        })

        local unlink_group = vim.api.nvim_create_augroup("LuasnipUnlinkOnModeChange", {})
        vim.api.nvim_create_autocmd("ModeChanged", {
            group = unlink_group,
            pattern = { "s:n", "i:*" },
            callback = function(ev)
                local ls = require("luasnip")
                if ls.session
                    and ls.session.current_nodes[ev.buf]
                    and not ls.session.jump_active then
                    ls.unlink_current()
                end
            end,
            desc = "Unlink current LuaSnip snippet when leaving insert/select mode",
        })

        local function expand_by_name(name)
            local function find_and_expand(ft)
                local snips = ls.get_snippets(ft) or {}
                for _, s in ipairs(snips) do
                    if s.name == name then
                        ls.snip_expand(s)
                        return true
                    end
                end
                return false
            end
            local ft = vim.bo.filetype
            if not find_and_expand(ft) and not find_and_expand("all") then
                vim.notify(("Snippet not found: %s (ft=%s)"):format(name, ft), vim.log.levels.WARN)
            end
        end

        local map = function(lhs, name, desc)
            vim.keymap.set("i", lhs, function() expand_by_name(name) end,
                { silent = true, noremap = true, desc = desc })
        end

        map("<M-A>", "all(vector)", "Insert snippet: all(vector)")
        -- B
        map("<M-C>", "cin c", "Insert snippet: cin c")
        -- D
        map("<M-E>", "cout yesno", "Insert snippet: cout yesno")
        -- F
        map("<M-G>", "GCC optimize", "Insert snippet: GCC optimize")
        -- H
        map("<M-I>", "ps default code", "Insert snippet: ps default code")
        map("<M-J>", "cin nk", "Insert snippet: cin nk")
        map("<M-K>", "cin nmk", "Insert snippet: cin nmk")
        map("<M-L>", "lambdaWrap", "Insert snippet: lambdaWrap")
        map("<M-M>", "cin nm", "Insert snippet: cin nm")
        map("<M-N>", "cin n", "Insert snippet: cin n")
        map("<M-O>", "sort", "Insert snippet: sort")
        map("<M-P>", "include ext/pb_ds", "Insert snippet: include ext/pb_ds")
        -- Q
        map("<M-R>", "include ext/rope", "Insert snippet: include ext/rope")
        map("<M-S>", "cin st", "Insert snippet: cin st")
        map("<M-T>", "codeforces testcase for loop", "Insert snippet: CF testcase")
        map("<M-U>", "cp default code", "Insert snippet: cp default code")
        map("<M-V>", "cin v", "Insert snippet: cin v")
        -- W
        map("<M-X>", "cin x", "Insert snippet: cin x")
        map("<M-Y>", "cin xy", "Insert snippet: cin xy")
        -- Z

        map("<M-@>", "cin vec2D", "Insert snippet: cin vec2D")
        map("<M-<>", "for [0:n)", "Insert snippet: for [0:n)")
        map("<M->>", "for (n:0]", "Insert snippet: for (n:0]")
        map("<M-+>", "for [1:n]", "Insert snippet: for [1:n]")
        map("<M-_>", "for [n:1]", "Insert snippet: for [n:1]")

        vim.keymap.set({ "i", "s" }, "<Space>", function()
            if ls.locally_jumpable(1) then
                ls.jump(1)
            else
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes(" ", true, false, true),
                    "n",
                    true
                )
            end
        end, { silent = true, noremap = true, desc = "LuaSnip: jump/expand or insert space" })
    end,
}
