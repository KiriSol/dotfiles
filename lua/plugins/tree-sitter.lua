return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"c",
				"cpp",
				"bash",
				"json",
				"jsonc",
				"toml",
				"yaml",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {
				"tmux",
			},
			highlight = {
				enable = true,
			},
		})
	end,
}
