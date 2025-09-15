return {
    "monaqa/dial.nvim",
    config = function()
        local augend = require("dial.augend")

        require("dial.config").augends:register_group{
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"], -- 날짜
                augend.constant.alias.bool, -- true <-> false (소문자만)
                augend.constant.new{ elements = {"TRUE", "FALSE"}, word = true, cyclic = true },
                augend.constant.new{ elements = {"True", "False"}, word = true, cyclic = true },
                augend.constant.new{ elements = {"yes", "no"}, word = true, cyclic = true },
                augend.constant.new{ elements = {"YES", "NO"}, word = true, cyclic = true },
                augend.constant.new{ elements = {"first", "second"}, word = true, cyclic = true },
            }
        }

        vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
        vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
		vim.keymap.set("v", "<C-a>", function()
			require("dial.map").manipulate("increment", "visual")
			vim.cmd("normal! gv")
		end, { noremap = true })
		vim.keymap.set("v", "<C-x>", function()
			require("dial.map").manipulate("decrement", "visual")
			vim.cmd("normal! gv")
		end, { noremap = true })
    end
}
