vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ''

-- General indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true


-- YAML indenting
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
	end
})
