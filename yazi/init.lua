require("full-border"):setup()

require("smart-enter"):setup {
	open_multi = true,
}

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.deleted_sign = "D"
th.git.ignored_sign = "I"
th.git.updated_sign = "C"
require("git"):setup()
