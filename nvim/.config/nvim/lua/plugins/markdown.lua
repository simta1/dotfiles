return {
	"brianhuster/live-preview.nvim",
	ft = { "markdown" },
	config = function()
		require("live-preview").setup({
			port = 8080,
			browser_command = "firefox",
		})
		vim.keymap.set("n", "<leader>mp", "<cmd>LivePreview start<CR>", { desc = "Markdown Live Preview" })
	end,
}
