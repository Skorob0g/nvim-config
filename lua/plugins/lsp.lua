return {
    'neovim/nvim-lspconfig', -- (?) attaches LServers automatically
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- (?) Package manager for LServers
        'williamboman/mason-lspconfig.nvim', -- (?) marries the two above together
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        {'j-hui/fidget.nvim', opts = {}},
    },
}
