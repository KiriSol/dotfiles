return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		-- Customize or remove this keymap to your liking
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer (Conform)",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			c = { "clang_format" },
			cpp = { "clang_format" },
			java = { "clang_format" },
			cs = { "clang_format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			markdown = { "prettierd" },
			rust = { "rustfmt" },
			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
			["_"] = { "trim_whitespace", lsp_format = "prefer" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		notify_on_error = true,
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500 },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
			clang_format = {
				prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
