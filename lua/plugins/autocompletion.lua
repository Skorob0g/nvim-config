return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                {'L3MON4D3/LuaSnip', version = "v2.*", build = "make install_jsregexp"}
    },
    config = function()
        local cmp = require 'cmp'
        cmp.setup {
            completion = { completeopt = 'menu,menuone,noinsert' },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-y>'] = cmp.mapping.confirm { select = true },

                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }
    }
    end,
}
