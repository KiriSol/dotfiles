local TERMINAL_MAPPING = "<c-]>"

function _G._set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<Esc>", [[<cmd> stopinsert <cr>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua _set_terminal_keymaps()")

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
		"TermExec",
		"TermSelect",
	},
	opts = {
		shading_factor = -20,
		open_mapping = TERMINAL_MAPPING,
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.3
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.3
			end
		end,
		insert_mappings = true,
		terminal_mappings = true,
		float_opts = {
			border = "curved",
			title_pos = "center",
			height = function()
				return math.ceil(vim.o.lines * 0.85)
			end,
		},
		winbar = {
			-- enabled = true,
		},
	},
	keys = {
		{ TERMINAL_MAPPING },
		{ "<leader>tv", "<cmd> ToggleTerm direction=vertical <cr>" },
		{ "<leader>tf", "<cmd> ToggleTerm direction=float <cr>" },
		{ "<leader>th", "<cmd> ToggleTerm direction=horizontal <cr>" },
		{
			"<leader>gg",
			function()
				require("toggleterm.terminal").Terminal
					:new({ cmd = "lazygit", float_opts = { title = "LazyGit" }, hidden = true })
					:toggle(nil, "float")
			end,
		},
		{
			"<leader>trb",
			function()
				require("toggleterm.terminal").Terminal
					:new({ cmd = "btm", hfloat_opts = { title = "Bottom" }, idden = true })
					:toggle(nil, "float")
			end,
		},
	},
}
