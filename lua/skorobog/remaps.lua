vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true


-- Telescope remaps
local tlscp = require('telescope.builtin') -- I have no
-- I also don't understand what {} are needed here foridea why require is needed here
vim.keymap.set('n', '<leader>ff', tlscp.find_files, {}) -- find files
vim.keymap.set('n', '<leader>fl', tlscp.live_grep, {})	--find lines
vim.keymap.set('n', '<leader>fg', tlscp.git_files, {})	--find git files
vim.keymap.set('n', '<leader>fb', tlscp.buffers, {})
vim.keymap.set('n', '<leader>fh', tlscp.help_tags, {})
