-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.indentexpr = ""
vim.opt.cindent = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.indentexpr = ""
        vim.opt_local.cindent = true
        vim.opt_local.smartindent = true
    end,
})

-- 주석있는 줄에서 새 줄 만들때 주석삽입하는거 제거
-- c: 주석있는 줄에서 자동 줄바꿈(c)
-- r: 주석줄에서 enter누를 때 자동 주석 삽입
-- o: o/O로 새줄만들때 자동 주석 삽입
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.g.autoformat = false
vim.opt.undofile = false

vim.opt.clipboard = ""

-- vim.g.mapleader = "\\"
-- vim.g.maplocalleader = "\\"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

vim.g.snacks_animate = false -- true하면 gg, G까지 애니메이션 포함이라 false해둔뒤 neoscroll.lua에서 직접 설정했음

vim.opt.conceallevel = 0 -- 마크다운에서 ``` 숨기지 않게 함
