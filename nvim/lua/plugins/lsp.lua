return {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = { enabled = false },
        servers = {
            clangd = {
                single_file_support = true,
                root_dir = function(fname)
                    local util = require("lspconfig.util")
                    local path = (type(fname) == "number") and vim.api.nvim_buf_get_name(fname) or fname
                    if not path or path == "" then
                        return vim.uv.cwd()
                    end
                    local root = util.root_pattern(".clangd", "compile_commands.json", "compile_flags.txt", ".git")(path)
                    return root or vim.fs.dirname(path) or vim.uv.cwd()
                end,
            },
            stylua = false,
        },
    },
}
