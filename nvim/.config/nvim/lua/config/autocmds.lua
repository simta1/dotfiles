-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- visual 모드 드래그 영역 배경색, 현재커서줄 배경색 지정
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "Visual", { bg = "#536c91" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4a5c" })
		vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3e4a5c" })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            client.server_capabilities.documentHighlightProvider = false
        end
    end,
})
