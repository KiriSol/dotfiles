return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local servers = {
			"lua_ls",
			"rust_analyzer",
			"ruff",
			"ty",
		}
		vim.lsp.enable(servers)
	end,
	init = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				_G.FloatRename = {}

				function FloatRename.core_rename(win)
					local new_name = vim.trim(vim.fn.getline("."))
					vim.api.nvim_win_close(win, true)
					vim.lsp.buf.rename(new_name)
				end

				function FloatRename.float_rename()
					local opts = {
						relative = "cursor",
						row = 1,
						col = 0,
						width = 25,
						height = 1,
						style = "minimal",
						title = " New name ",
						title_pos = "center",
					}
					local cword = vim.fn.expand("<cword>")
					local buf = vim.api.nvim_create_buf(false, true)
					local win = vim.api.nvim_open_win(buf, true, opts)
					local fmt = "<cmd> lua FloatRename.core_rename(%d) <CR>"

					vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
					vim.api.nvim_buf_set_keymap(buf, "i", "<CR>", string.format(fmt, win), { silent = true })
					vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", string.format(fmt, win), { silent = true })
					vim.api.nvim_buf_set_keymap(
						buf,
						"n",
						"q",
						string.format("<cmd> lua vim.api.nvim_win_close(%d, true) <cr>", win),
						{ silent = true }
					)
					vim.api.nvim_buf_set_keymap(
						buf,
						"n",
						"<Esc>",
						string.format("<cmd> lua vim.api.nvim_win_close(%d, true) <cr>", win),
						{ silent = true }
					)
					vim.api.nvim_buf_set_keymap(
						buf,
						"n",
						"<C-c>",
						string.format("<cmd> lua vim.api.nvim_win_close(%d, true) <cr>", win),
						{ silent = true }
					)
				end
				vim.keymap.set(
					"n",
					"grn",
					FloatRename.float_rename,
					{ buffer = ev.buf, desc = "Lsp float rename", noremap = true }
				)

				vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Lsp diagnostic open float" })
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Lsp get declarations" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Lsp get hover" })
				vim.keymap.set(
					"n",
					"gK",
					vim.lsp.buf.signature_help,
					{ buffer = ev.buf, desc = "Lsp get signature help" }
				)
				vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Lsp go to definition" })
			end,
		})
	end,
}
