Themes = {
	{
		"folke/tokyonight.nvim",
		event = { "ColorSchemePre" },
		opts = {
			style = "storm",
			transparent = false,
		},
		init = function()
			local tokyo = require("tokyonight")
			for _, v in pairs({
				"tokyonight-storm",
				"tokyonight-night",
				"tokyonight-moon",
				"tokyonight-day",
			}) do
				SetBackground.CustomChangeFunc[v] = {
					enable = function()
						Themes[2].opts.transparent = true
						Themes[2].opts.styles = {
							sidebars = "transparent",
							floats = "transparent",
						}
						tokyo.setup(Themes[2].opts)
						vim.cmd.colorscheme(v)
						vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
					end,
					disable = function()
						Themes[2].opts.transparent = false
						Themes[2].opts.styles = nil
						tokyo.setup(Themes[2].opts)
						vim.cmd.colorscheme(v)
					end,
				}
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "auto", -- latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "frappe",
			},
			transparent_background = false,
		},
		init = function()
			local cat = require("catppuccin")
			for _, v in pairs({
				"catppuccin-frappe",
				"catppuccin-macchiato",
				"catppuccin-mocha",
				"catppuccin-latte",
			}) do
				SetBackground.CustomChangeFunc[v] = {
					enable = function()
						cat.options.transparent_background = true
						cat.compile()
						vim.cmd.colorscheme("catppuccin")
					end,
					disable = function()
						cat.options.transparent_background = false
						cat.compile()
						vim.cmd.colorscheme("catppuccin")
					end,
				}
			end
		end,
	},
}

return Themes
