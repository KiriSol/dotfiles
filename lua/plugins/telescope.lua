return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "Telescope" },
	opts = {
		defaults = {
			file_ignore_patterns = IGNONE_FILETYPES_BY_PATTERN,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopeFindPre",
			callback = function()
				vim.opt_local.winborder = "none"
				vim.api.nvim_create_autocmd("WinLeave", {
					once = true,
					callback = function()
						vim.opt_local.winborder = "rounded"
					end,
				})
			end,
		})
	end,
	keys = {
		-- Find
		{ "<leader>ff", "<cmd> Telescope find_files <cr>", desc = "Telescope find files", noremap = true },
		{
			"<leader>fF",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Telescope find files with hidden",
			noremap = true,
		},
		{ "<leader>fg", "<cmd> Telescope live_grep <cr>", desc = "Telescope live grep", noremap = true },
		{
			"<leader>fG",
			function()
				require("telescope.builtin").live_grep({ hidden = true })
			end,
			desc = "Telescope live grep with hidden files",
			noremap = true,
		},
		{ "<leader>fw", "<cmd> Telescope grep_string <cr>", desc = "Telescope grep string", noremap = true },
		{
			"<leader>fW",
			"<cmd> Telescope grep_string <cr>",
			desc = "Telescope grep string with hidden files",
			noremap = true,
		},
		{ "<leader>fb", "<cmd> Telescope buffers <cr>", desc = "Telescope buffers", noremap = true },
		{ "<leader>fo", "<cmd> Telescope oldfiles <cr>", desc = "Telescope old files", noremap = true },
		{ "<leader>fh", "<cmd> Telescope help_tags <cr>", desc = "Telescope help tags", noremap = true },
		{
			"<leader>fz",
			"<cmd> Telescope current_buffer_fuzzy_find <cr>",
			desc = "Telescope current buffer fuzzy find",
			noremap = true,
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Telescope find files in config dir",
			noremap = true,
		},
		-- Git
		{ "<leader>gs", "<cmd> Telescope git_status <cr>", desc = "Telescope git status", noremap = true },
		{ "<leader>gc", "<cmd> Telescope git_commits <cr>", desc = "Telescope git commits", noremap = true },
		{ "<leader>gb", "<cmd> Telescope git_branches <cr>", desc = "Telescope git branches", noremap = true },
		-- Lsp
		{
			"<leader>fs",
			"<cmd> Telescope lsp_document_symbols <cr>",
			desc = "Telescope lsp document symbols",
			noremap = true,
		},
		{ "<leader>lD", "<cmd> Telescope diagnostics <cr>", desc = "Telescope diagnostics", noremap = true },
		{ "gd", "<cmd> Telescope lsp_definitions <cr>", desc = "Telescope lsp definitions", noremap = true },
		{ "gy", "<cmd> Telescope lsp_type_definitions <cr>", desc = "Telescope lsp type definitions", noremap = true },
		{ "grr", "<cmd> Telescope lsp_references <cr>", desc = "Telescope lsp references", noremap = true },
		{
			"gri",
			"<cmd> Telescope lsp_implementations <cr>",
			desc = "Telescope lsp implementations",
			noremap = true,
		},
		-- Other
		-- { "<localleader>rg", "<cmd> Telescope registers <cr>", desc = "Telescope registers", noremap = true },
		{
			"<A-s>",
			"<cmd> Telescope spell_suggest <cr>",
			mode = { "n", "i", "v" },
			desc = "Telescope spell suggest",
			noremap = true,
		},
		{ "<leader>ft", "<cmd> TodoTelescope <cr>", desc = "Telescope find todo-comments", noremap = true },
	},
}
