vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
    callback = function(event)
        -- supposed to be prettier to define keymaps like this
        local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end


    local tlscp = require('telescope.builtin')

    --  To jump back, press <C-t>.
    map('gd', tlscp.lsp_definitions, 'Goto Definition')
    map('gr', tlscp.lsp_references, 'Goto References')
    -- Doesn't seem very useful yet, jumps to defenition of a word's type
    map('<leader>D', tlscp.lsp_type_definitions, 'Goto type Definition')
    -- Searches "symbols" within a buffer, symbols are vars, funcs and so on
    map('<leader>ds', tlscp.lsp_document_symbols, 'Document Symbols')
    -- Same as above, but for the entire project 
    map('<leader>ws', tlscp.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- Rename the variable under cursor.
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')

    -- Seems like this executes the action suggested by LSP, auto fixing errors (?) 
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- seems like this is useful for C, to jump from header file to implementation
    map('gI', tlscp.lsp_implementations, 'Goto Implementation')
    -- Like go to defenition, but would jump to a header file in C
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    -- Show full error message recieved from LSP
    map('<leader>e', vim.diagnostic.open_float, 'Explicit error')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
end,
})



-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
    'force', capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    lua_ls = {},
    ansiblels = {},
    bashls = {},
    dockerls = {},
    helm_ls = {},

    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
}

-- Ensure the servers and tools above are installed
require('mason').setup()
require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }
require('mason-lspconfig').setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}
