function SwitchWrap()
	if vim.o.wrap then
		vim.o.wrap = false
	else
		vim.o.wrap = true
	end
end
