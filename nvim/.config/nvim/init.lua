-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_opacity = 0.2

	-- vim.g.neovide_cursor_vfx_mode = "sonicboom"
	-- vim.g.neovide_cursor_vfx_mode = "ripple"
	 vim.g.neovide_cursor_vfx_mode = "railgun"

    -- 입자 관련 세부 설정
	vim.g.neovide_cursor_vfx_particle_density = 1.5
	vim.g.neovide_cursor_vfx_particle_lifetime = 0.7
	vim.g.neovide_cursor_vfx_particle_speed = 10.0
	vim.g.neovide_cursor_vfx_opacity = 220.0
	vim.g.neovide_cursor_vfx_particle_phase = 0.0
	vim.g.neovide_cursor_vfx_particle_curl = 1.0

    -- 투명도/밝기 조정
    vim.g.neovide_cursor_vfx_opacity = 200.0

end

