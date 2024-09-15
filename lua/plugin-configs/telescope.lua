local tlscp = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tlscp.find_files, { desc = 'Find filenames in current working directory'}) 
vim.keymap.set('n', '<leader>fl', tlscp.live_grep, { desc = 'Find lines within files in current working directory'})
vim.keymap.set('n', '<leader>fo', tlscp.treesitter, { desc = 'Find in treesitter objects'})
vim.keymap.set('n', '<leader>fg', tlscp.git_files, { desc = 'Find git filenames in current git repository'})
vim.keymap.set('n', '<leader>fb', tlscp.buffers, { desc = 'Find names of open buffers of current nvim instance'})
vim.keymap.set('n', '<leader>fvo', tlscp.vim_options, { desc = 'Find vim options, edit current value on <CR>'})
vim.keymap.set('n', '<leader>fk', tlscp.keymaps, { desc = 'Find normal mode keymaps'})


