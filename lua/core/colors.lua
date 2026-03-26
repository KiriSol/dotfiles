vim.g.colors_name = vim.g.colors_name or "habamax"

SetBackground = {
	is_transparent = false,
	VimTheme = {
		---@param color string | nil
		set_color = function(color)
			if color then
				vim.cmd.colorscheme(color)
			end
			if SetBackground.is_transparent then
				SetBackground.VimTheme.transparency.enable()
			end
			local change_bg = {
				"NormalFloat",
				"ColorColumn",
			}
			for _, v in pairs(change_bg) do
				vim.api.nvim_set_hl(0, v, { bg = "none" })
			end
		end,
		transparency = {
			enable = function()
				SetBackground.is_transparent = true
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			end,
			disable = function()
				SetBackground.is_transparent = false
				vim.cmd.colorscheme(vim.g.colors_name)
				local background = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)
				background = background or "#2E3440"
				vim.api.nvim_set_hl(0, "Normal", { bg = background })
				SetBackground.VimTheme.set_color()
			end,
			toggle = function()
				if SetBackground.is_transparent then
					SetBackground.VimTheme.transparency.disable()
				else
					SetBackground.VimTheme.transparency.enable()
				end
				print("Toggle transparency")
			end,
		},
	},
	CustomChangeFunc = {
		default = {
			enable = function()
				SetBackground.VimTheme.transparency.enable()
			end,
			disable = function()
				SetBackground.VimTheme.transparency.disable()
			end,
			toggle = function()
				SetBackground.VimTheme.transparency.toggle()
			end,
		},
	},
	OtherTheme = {
		---@param color string | nil
		SetColor = function(color)
			if color then
				vim.cmd.colorscheme(color)
			end
			if SetBackground.is_transparent then
				SetBackground.OtherTheme.transparency.enable()
			else
				SetBackground.OtherTheme.transparency.disable()
			end
		end,
		transparency = {
			enable = function()
				SetBackground.is_transparent = true
				local theme = SetBackground.CustomChangeFunc[vim.g.colors_name]
					or SetBackground.CustomChangeFunc.default
				theme.enable()
			end,
			disable = function()
				SetBackground.is_transparent = false
				local theme = SetBackground.CustomChangeFunc[vim.g.colors_name]
					or SetBackground.CustomChangeFunc.default
				theme.disable()
			end,
			toggle = function()
				if SetBackground.is_transparent then
					SetBackground.OtherTheme.transparency.disable()
				else
					SetBackground.OtherTheme.transparency.enable()
				end
				print("Toggle transparency")
			end,
		},
	},
}

SetColor = SetBackground.OtherTheme.SetColor

SwitchTheme = {
	current_index = 1,
	list = { "habamax" },
	switch = function()
		SwitchTheme.current_index = SwitchTheme.current_index + 1
		if not SwitchTheme.list[SwitchTheme.current_index] then
			SwitchTheme.current_index = 1
		end
		SetBackground.OtherTheme.SetColor(SwitchTheme.list[SwitchTheme.current_index])
		print("Set colorscheme " .. SwitchTheme.list[SwitchTheme.current_index])
	end,
}
