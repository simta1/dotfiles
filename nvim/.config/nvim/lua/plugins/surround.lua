return {
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add            = "ys",
                delete         = "ds",
                replace        = "cs",
                highlight      = "gs",
                find           = "",
                find_left      = "",
                update_n_lines = "",
                suffix_last    = "",
                suffix_next    = "",
            },
            custom_surroundings = {
                p = { output = { left = "(", right = ")" } }, -- parentheses
                P = { output = { left = "( ", right = " )" } },
                b = { output = { left = "{", right = "}" } }, -- braces
                B = { output = { left = "{ ", right = " }" } },
                s = { output = { left = "[", right = "]" } }, -- square brackets
                S = { output = { left = "[ ", right = " ]" } },
                a = { output = { left = "<", right = ">" } }, -- angle brackets
                A = { output = { left = "< ", right = " >" } },
            },
        },
    },
}
