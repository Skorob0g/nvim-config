return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            -- checks if make is installed on my computer
            -- originally was a function, but seems to also work like this
            cond = vim.fn.executable 'make' == 1
        }
    },
}
