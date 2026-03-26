return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	cmd = "Gitsigns",
	opts = {},
	keys = {
		{ "[g", "<cmd> Gitsigns prev_hunk <cr>" },
		{ "]g", "<cmd> Gitsigns next_hunk <cr>" },
		{ "<leader>gv", "<cmd> Gitsigns select_hunk <cr>" },
		{ "<leader>gw", "<cmd> Gitsigns toggle_word_diff <cr>" },
		{ "<leader>grb", "<cmd> Gitsigns reset_buffer <cr>" },
		{ "<leader>grh", "<cmd> Gitsigns reset_hunk <cr>", mode = { "n", "v" } },
		{ "<leader>gd", "<cmd> Gitsigns diffthis <cr>", mode = { "n", "v" } },
		{ "<leader>gp", "<cmd> Gitsigns preview_hunk_inline <cr>", mode = { "n", "v" } },
	},
}
