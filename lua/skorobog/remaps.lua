vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = unix

vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
	end
})

-- Telescope remaps
local tlscp = require('telescope.builtin') -- I have no
vim.keymap.set('n', '<leader>ff', tlscp.find_files, { desc = '[F]ind [f]iles'}) 
vim.keymap.set('n', '<leader>fl', tlscp.live_grep, { desc = '[F]ind [l]ines'})
vim.keymap.set('n', '<leader>fg', tlscp.git_files, { desc = '[F]ind [g]it files'})
vim.keymap.set('n', '<leader>fb', tlscp.buffers, { desc = '[F]ind [b]uffers'})
vim.keymap.set('n', '<leader>fh', tlscp.help_tags, { desc = '[F]ind [h]elp tags'})
vim.keymap.set('n', '<leader>fk', tlscp.keymaps, { desc = '[F]ind [k]eymaps'})

vim.keymap.set( 'n', '<leader>fnf', function()
		tlscp.find_files {cwd = vim.fn.stdpath 'config'}
	end, {desc = '[F]ind [N]eovim [F]iles'}
)

vim.keymap.set( 'n', '<leader>fnl', function()
		tlscp.live_grep {cwd = vim.fn.stdpath 'config'}
	end, {desc = '[F]ind [l]ines in [N]eovim Files'}
)

vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
