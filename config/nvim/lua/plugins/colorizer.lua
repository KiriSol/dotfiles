return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
	config = function()
		require("colorizer").setup({
			"*",
			css = { css = true },
		}, {
			RRGGBBAA = true,
		})
		vim.cmd("ColorizerToggle")
	end,
	keys = {
		{ "<leader>cc", "<cmd> ColorizerToggle <cr>" },
		{ "<leader>ca", "<cmd> ColorizerAttachToBuffer <cr>" },
		{ "<leader>cd", "<cmd> ColorizerDetachFromBuffer <cr>" },
		{ "<leader>cr", "<cmd> ColorizerReloadAllBuffers <cr>" },
	},
}
