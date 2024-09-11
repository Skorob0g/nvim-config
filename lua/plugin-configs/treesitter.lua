require('nvim-treesitter.configs').setup{
    ensure_installed = {
        'c', 'go', 'python', 'lua',
        'yaml', 'json', 'helm',
        'make'
    },
    highlight = {enable = true},
    indent = {enable = true}
}
