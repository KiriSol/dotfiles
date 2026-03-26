return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			indicator = { style = "none" },
			hover = {
				enabled = true,
				delay = 100,
				reveal = { "close" },
			},
		},
	},
	keys = {
		{ "gb", "<cmd> BufferLinePick <cr>", desc = "Goto certain buffer" },
		{ "<leader>x", "<cmd> BufferLinePickClose <cr>", desc = "Close certain buffer" },
		{ "<leader>X", "<cmd> BufferLineCloseOthers <cr>", desc = "Close other buffers" },
		{ "<leader>bp", "<cmd> BufferLineTogglePin <cr>", desc = "Toggle pin buffer" },
		{ "<leader>bl", "<cmd> BufferLineCloseLeft <cr>", desc = "Close left buffers" },
		{ "<leader>bh", "<cmd> BufferLineCloseRight <cr>", desc = "Close right buffers" },
	},
}
