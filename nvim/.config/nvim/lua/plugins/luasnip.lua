return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            local from_vscode = require("luasnip.loaders.from_vscode")

            -- 기본 옵션
            ls.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = false,
                region_check_events = "InsertEnter",
                delete_check_events = "TextChanged,InsertLeave",
            })

            -- 커뮤니티 + 사용자 스니펫 로드
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

            -- 이름으로 스니펫 찾아서 즉시 확장
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

            -- C/C++ 버퍼에서만 키맵 등록
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "c", "cpp" },
                callback = function(ev)
                    local buf = ev.buf
                    local map = function(lhs, name, desc)
                        vim.keymap.set("i", lhs, function() expand_by_name(name) end,
                            { buffer = buf, silent = true, noremap = true, desc = desc })
                    end

                    -- Alt+Shift+문자 → <M-대문자>
                    map("<M-I>", "ps default code", "Insert snippet: ps default code")
                    map("<M-U>", "cp default code", "Insert snippet: cp default code")
                    map("<M-G>", "GCC optimize", "Insert snippet: GCC optimize")
                    map("<M-R>", "include ext/rope", "Insert snippet: include ext/rope")
                    map("<M-P>", "include ext/pb_ds", "Insert snippet: include ext/pb_ds")
                    map("<M-T>", "codeforces testcase for loop", "Insert snippet: CF testcase")

                    map("<M-N>", "cin n", "Insert snippet: cin n")
                    map("<M-M>", "cin nm", "Insert snippet: cin nm")
                    map("<M-K>", "cin nmk", "Insert snippet: cin nmk")
                    map("<M-J>", "cin nk", "Insert snippet: cin nk")
                    map("<M-V>", "cin v", "Insert snippet: cin v")

                    map("<M-@>", "cin vec2D", "Insert snippet: cin vec2D")

                    map("<M-O>", "sort", "Insert snippet: sort")
                    map("<M-A>", "all(vector)", "Insert snippet: all(vector)")
                    map("<M-X>", "cin x", "Insert snippet: cin x")
                    map("<M-Y>", "cin xy", "Insert snippet: cin xy")
                    map("<M-C>", "cin c", "Insert snippet: cin c")
                    map("<M-S>", "cin st", "Insert snippet: cin st")
                    map("<M-L>", "lambdaWrap", "Insert snippet: lambdaWrap")

                    map("<M-<>", "for [0:n)", "Insert snippet: for [0:n)")
                    map("<M-+>", "for [1:n]", "Insert snippet: for [1:n]")

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
                    end, { buffer = buf, silent = true, noremap = true, desc = "LuaSnip: jump/expand or insert space" })

                end,
            })
        end,
    },
}
