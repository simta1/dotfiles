return {
	"romgrk/barbar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
	},
	opts = {
		diagnostics = {
			-- [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
			-- [vim.diagnostic.severity.WARN]  = { enabled = true, icon = "" },
			[vim.diagnostic.severity.ERROR] = { enabled = false },
			[vim.diagnostic.severity.WARN]  = { enabled = false },
			[vim.diagnostic.severity.INFO]  = { enabled = false },
			[vim.diagnostic.severity.HINT]  = { enabled = false },
		},
		icons = {
			buffer_index = true,
			filetype = { enabled = true },  -- 수정
			button = "×",
		},
		-- close_command = function(bufnr)
		-- 	vim.api.nvim_buf_delete(bufnr, {})
		-- end

		-- Close commands
		-- 	:BufferCloseAllButCurrent
		-- 	:BufferCloseAllButPinned
		-- 	:BufferCloseAllButCurrentOrPinned
		-- 	:BufferCloseBuffersLeft
		-- 	:BufferCloseBuffersRight
	},
	config = function(_, opts)
		require("barbar").setup(opts)

		local map = vim.keymap.set

		-- Move to previous/next
		map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
		map("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })

		-- Re-order to previous/next
		map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
		map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })

		-- Goto buffer in position...
		map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
		map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
		map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
		map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
		map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
		map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
		map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
		map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
		map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
		map("n", "<A-0>", "<Cmd>BufferLast<CR>", { noremap = true, silent = true })

		-- Pin/unpin buffer
		map("n", "<A-p>", "<Cmd>BufferPin<CR>", { noremap = true, silent = true })

		-- Goto pinned/unpinned buffer
		-- 	:BufferGotoPinned
		-- 	:BufferGotoUnpinned

		-- Close buffer
		map("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
	end,
}
