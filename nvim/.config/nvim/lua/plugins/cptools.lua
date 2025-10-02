return {
	-- dir = "~/coding/my/cptools.nvim",
	"simta1/cptools.nvim",
	config = function()
		require("cptools").setup({
			tools = {
				-- 'use' is the filename under 'lua/cptools/tools/'
				-- 'as' is the display name shown in the :Cptools menu
				{ use = "divisors", as = "divisors" },
				{ use = "highly_composite_number", as = "highly composite number" },
				{ use = "isqrt", as = "isqrt" },
				{ use = "primality_test", as = "prime check" },
				{ use = "prime_factorization", as = "prime factorization" },
			}
		})

		vim.keymap.set("n", "<leader>cp", "<cmd>Cptools<cr>", { desc = "Open CP Tools" })
	end,
}
