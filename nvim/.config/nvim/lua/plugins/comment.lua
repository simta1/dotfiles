return {
    "numToStr/Comment.nvim",
    keys = {
        { "⎘", mode = "n", function()
            require("Comment.api").toggle.linewise.current()
        end, desc = "Toggle comment (line)" },
        { "⎘", mode = "x", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(comment_toggle_linewise_visual)gv", true, false, true), "x", false)
        end, desc = "Toggle comment (visual)" },
		{ "⎘", mode = "i", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			require("Comment.api").toggle.linewise.current()
			vim.api.nvim_feedkeys("A", "n", false)
		end, desc = "Toggle comment (insert)" },

		-- neovide 전용
		{ "<C-/>", mode = "n", function()
            require("Comment.api").toggle.linewise.current()
        end, desc = "Toggle comment (line)" },
        { "<C-/>", mode = "x", function()
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Plug>(comment_toggle_linewise_visual)gv", true, false, true),
                "x",
                false
            )
        end, desc = "Toggle comment (visual)" },
		{ "<C-/>", mode = "i", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            require("Comment.api").toggle.linewise.current()
            vim.api.nvim_feedkeys("A", "n", false)
        end, desc = "Toggle comment (insert, neovide)" },
    },
}
