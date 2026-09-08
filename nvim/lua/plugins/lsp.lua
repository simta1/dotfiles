return {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = { enabled = false },
        servers = {
            clangd = {
                cmd = {
                    "/etc/profiles/per-user/simtal/bin/clangd",
                    "--query-driver=/etc/profiles/per-user/simtal/bin/gcc,/etc/profiles/per-user/simtal/bin/g++,/nix/store/*gcc-wrapper*/bin/gcc,/nix/store/*gcc-wrapper*/bin/g++",
                    "--log=verbose",
                },
                single_file_support = true,
            },
            stylua = { enabled = false },
        },
    },
}
