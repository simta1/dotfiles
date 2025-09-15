-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader><leader>x", ":w | bd<CR>", { desc = "Save & Close Buffer" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", opts)
vim.keymap.set("v", "<C-a>", "<Esc>ggVG", opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)
vim.keymap.set("n", "<C-c>", '"+yl', opts)
vim.keymap.set("i", "<C-v>", '<C-r><C-o>+', opts)
vim.keymap.set("i", "<C-S-v>", '<C-r><C-o>+', opts)
vim.keymap.set("i", "<C-r>", '<C-r><C-o>', opts)

vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true }) -- neovide용
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true })

vim.keymap.set("n", "<C-Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("i", "<C-Tab>", "<Esc><cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("i", "<C-S-Tab>", "<Esc><cmd>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Outdent line" })

vim.keymap.del("n", "<leader><leader>")

vim.keymap.set("n", "]g", function()
    if vim.wo.diff then
        return "]g"
    end
    vim.schedule(function()
        require("gitsigns").nav_hunk("next")
    end)
    return "<Ignore>"
end, { expr = true, desc = "Next Git hunk" })

vim.keymap.set("n", "[g", function()
    if vim.wo.diff then
        return "[g"
    end
    vim.schedule(function()
        require("gitsigns").nav_hunk("prev")
    end)
    return "<Ignore>"
end, { expr = true, desc = "Previous Git hunk" })

-- Save unnamed buffer via Yazi (folder picker in a floating terminal)
do
    local function read_first_line(path)
        if vim.fn.filereadable(path) == 1 then
            local lines = vim.fn.readfile(path, "", 1)
            if #lines > 0 then
                return lines[1]
            end
        end
        return ""
    end

    local function cleanup(p1, p2)
        if vim.fn.filereadable(p1) == 1 then
            vim.fn.delete(p1)
        end
        if vim.fn.filereadable(p2) == 1 then
            vim.fn.delete(p2)
        end
    end

    local function after_yazi(chooser, cwdfile, win)
        if win and vim.api.nvim_win_is_valid(win) then
            pcall(vim.api.nvim_win_close, win, true)
        end

        local chosen = read_first_line(chooser)
        if chosen == "" then
            chosen = read_first_line(cwdfile)
        end

        if chosen ~= "" then
            if vim.fn.filereadable(chosen) == 1 then
                vim.notify("폴더만 선택 가능", vim.log.levels.ERROR)
                cleanup(chooser, cwdfile)
                return
            end

            local target = chosen
            if vim.fn.isdirectory(chosen) == 1 then
                local name = vim.fn.input("File name: ")
                if name == "" then
                    vim.notify("파일 이름은 비워둘 수 없음", vim.log.levels.ERROR)
                    cleanup(chooser, cwdfile)
                    return
                end
                target = chosen .. "/" .. name
            end

            vim.cmd("silent keepalt file " .. vim.fn.fnameescape(target))
            vim.cmd("write")
        end

        cleanup(chooser, cwdfile)
    end

    local function save_with_yazi()
        -- if buffer already has a name, just :w
        local current_name = vim.api.nvim_buf_get_name(0)
        if current_name ~= nil and current_name ~= "" then
            vim.cmd("write")
            return
        end

        local chooser = vim.fn.tempname()
        local cwdfile = vim.fn.tempname()
        local cmd = string.format(
            "yazi --chooser-file=%s --cwd-file=%s",
            vim.fn.shellescape(chooser),
            vim.fn.shellescape(cwdfile)
        )

        local buf = vim.api.nvim_create_buf(false, true)
        local width = math.floor(vim.o.columns * 0.90)
        local height = math.floor(vim.o.lines * 0.90)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
        })

        -- terminal buffer niceties
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].modifiable = true
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false

        -- start yazi and jump into insert mode so keys go to the terminal
        vim.fn.termopen(cmd, {
            on_exit = function(job_id, code, event)
                after_yazi(chooser, cwdfile, win)
            end,
        })
        vim.cmd("startinsert")
    end

    -- <leader>sw → Save with Yazi
    vim.keymap.set("n", "<leader>sw", save_with_yazi, { desc = "Save (pick folder via Yazi)", silent = true })
end

if vim.g.vscode then
    vim.schedule(function()
        pcall(vim.keymap.del, "n", "u")
        pcall(vim.keymap.del, "n", "<C-r>")
        vim.keymap.set("n", "u", "u", { noremap = true, silent = true, desc = "native nvim undo" })
        vim.keymap.set("n", "<C-r>", "<C-r>", { noremap = true, silent = true, desc = "native nvim redo" })
    end)
end
