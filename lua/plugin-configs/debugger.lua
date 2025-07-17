require('dap-python').setup()
require('dapui').setup()
require('nvim-dap-virtual-text').setup()

dap = require('dap')
ui = require('dapui')

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {desc = 'Toggle breakpoint'})
vim.keymap.set('n', '<leader>dr', dap.repl.toggle, {desc = 'Toggle debug REPL'})
vim.keymap.set('n', '<leader>dc', dap.continue, {desc = 'Debugger: continue'})
vim.keymap.set('n', '<leader>dn', dap.step_over, {desc = 'Debugger: next'})
vim.keymap.set('n', '<leader>di', dap.step_into, {desc = 'Debugger: into'})
vim.keymap.set('n', '<leader>do', dap.step_out, {desc = 'Debugger: out'})
vim.keymap.set('n', '<leader>da', dap.continue, {desc = 'Debugger: attach'})
vim.keymap.set('n', '<leader>dt', dap.terminate, {desc = 'Debugger: terminate'})

vim.keymap.set('n', '<leader>dw', ui.open, {desc = 'Debugger UI: open (windows)'})
vim.keymap.set('n', '<leader>dq', ui.close, {desc = 'Debugger UI: close (quit)'})
