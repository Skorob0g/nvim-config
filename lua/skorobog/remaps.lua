vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true


-- Telescope remaps
local tlscp = require('telescope.builtin') -- I have no
vim.keymap.set('n', '<leader>ff', tlscp.find_files, { desc = '[F]ind [f]iles'}) 
vim.keymap.set('n', '<leader>fl', tlscp.live_grep, { desc = '[F]ind [l]ines'})
vim.keymap.set('n', '<leader>fg', tlscp.git_files, { desc = '[F]ind [g]it files'})
vim.keymap.set('n', '<leader>fb', tlscp.buffers, { desc = '[F]ind [b]uffers'})
vim.keymap.set('n', '<leader>fh', tlscp.help_tags, { desc = '[F]ind [h]elp tags'})
