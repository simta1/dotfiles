return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
		-- gg, G는 애니메이션 사용X
        mappings = { "<C-f>", "<C-b>", "<C-d>", "<C-u>", "zz", "zt", "zb" },
        hide_cursor = true, -- 스크롤 중 커서 숨김
        stop_eof = true, -- 파일 끝에서 멈춤
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
        performance_mode = false, -- <C-f>, <C-b>에도 애니메이션 제대로 적용
    },

    config = function(_, opts)
        local neoscroll = require("neoscroll")
        neoscroll.setup(opts)

		-- mappings = {"<C-e>", "<C-y>"}는 여러 줄 이동이라 한줄만 이동하게 따로 매핑
        vim.keymap.set("n", "<C-e>", function()
            neoscroll.scroll(1, { move_cursor = true, duration = 100, easing = opts.easing_function })
        end, { desc = "Scroll down one line (smooth)" })

        vim.keymap.set("n", "<C-y>", function()
            neoscroll.scroll(-1, { move_cursor = true, duration = 100, easing = opts.easing_function })
        end, { desc = "Scroll up one line (smooth)" })
    end,
}
