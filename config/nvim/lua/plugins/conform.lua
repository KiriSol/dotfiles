return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer (Conform)",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			java = { "clang_format" },
			cs = { "clang_format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			toml = { "taplo" },
			json = { "biome" },
			jsonc = { "biome" },
			html = { "biome" },
			css = { "biome" },
			javascript = { "biome" },
			typescript = { "biome" },
			yaml = { "dprint" },
			markdown = { "dprint" },
			typst = { "typstyle" },
			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "typos" },
			-- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
			["_"] = { "trim_whitespace", lsp_format = "prefer" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		notify_on_error = true,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters = {
			clang_format = {
				prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
