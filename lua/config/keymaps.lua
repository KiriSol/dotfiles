-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set(
	"n",
	"<leader>sb",
	"<cmd> lua SetBackground.OtherTheme.transparency.toggle() <cr>",
	{ noremap = true, desc = "Switch background transparency" }
)
vim.keymap.set("n", "<leader>st", "<cmd> lua SwitchTheme.switch() <cr>", { noremap = true, desc = "Switch theme" })
vim.keymap.set("n", "<leader>sw", "<cmd> lua SwitchWrap() <cr>", { noremap = true, desc = "Switch wrap" })

vim.keymap.set("n", "<leader>w", "<cmd> wa <cr>", { noremap = true })
vim.keymap.set("n", "<leader>:", ":lua ", { noremap = true })

vim.keymap.set("n", "<leader>z", "<cmd> Lazy <cr>")
