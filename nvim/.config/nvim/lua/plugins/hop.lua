return {
	{
		"smoka7/hop.nvim",
		config = function()
			local hop = require("hop")
			hop.setup()

			vim.keymap.set("n", "<leader><leader>w", "<cmd>HopWord<CR>", { desc = "Hop by word" })
			-- vim.keymap.set("n", "<leader><leader>f", "<cmd>HopChar1<CR>", { desc = "Hop by single char" })
			-- vim.keymap.set("n", "<leader><leader>l", "<cmd>HopLine<CR>", { desc = "Hop by line" })
			-- vim.keymap.set("n", "<leader><leader>p", "<cmd>HopPattern<CR>", { desc = "Hop by pattern" })
		end,
	},
}
