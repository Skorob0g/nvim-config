-- The following is copy-pasted from lazy's github page
-- Lazy bootstraping (whatever it is) BEGIN
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- END

-- This line actually starts (?) lazy
-- Also that's where all the plugins should be defined
require("lazy").setup({
	{
		'nvim-telescope/telescope.nvim', -- some fancy search tool
		tag = '0.1.5',
		dependencies = {	-- this also reqiered installing "ripgrep" & "fd-find"packages
			'nvim-lua/plenary.nvim',	-- That's some lib with a bunch of stuff implemented in lua
			-- '',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function() -- seems like this function checks if make is installed on my computer
					return vim.fn.executable 'make' == 1
				end,
				}
		}
	},
	-- 'tpope/vim-sleuth', -- tabstop & shiftwidth
	{
		-- LSP stuff
		'neovim/nvim-lspconfig', -- (?) attaches LServers automatically
		dependencies = {
			{ 'williamboman/mason.nvim', config = true }, -- (?) Package manager for LServers
			'williamboman/mason-lspconfig.nvim', -- (?) marries the two above together
			'WhoIsSethDaniel/mason-tool-installer.nvim'
		},
		config = function() -- runs when LServer gets attached to a file
			vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
			callback = function(event)
				-- supposed to be prettier to define keymaps like this
				local map = function(keys, func, desc)
				vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
			end

			--  To jump back, press <C-t>.
			map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
			map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			-- seems like this is useful for C, to jump from header file to implementation
			map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
			-- Doesn't seem very useful yet, jumps to defenition of a word's type
			map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
			-- Searches "symbols" within a buffer, symbols are vars, funcs and so on
			map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			-- Same as above, but for the entire project 
			map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

			-- Rename the variable under cursor.
			map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

			-- Seems like this executes the action suggested by LSP, auto fixing errors (?) 
			map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

			map('K', vim.lsp.buf.hover, 'Hover Documentation')

			-- Like go to defenition, but would jump to a header file in C
			map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

			-- Show full error message recieved from LSP
			map('<leader>e', vim.diagnostic.open_float, '[E]xplicit error')

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
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local servers = {
				clangd = {},
				-- gopls = {},
				pyright = {},
				ansiblels = {},
				bashls = {},
				jsonnet_ls = {}
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
		end,
	},
	-- Supposed to show progress messages tied to LSP stuff
	-- in the bottom right corner
	-- {'j-hui/fidget.nvim, opts = {} },
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
					'hrsh7th/cmp-nvim-lsp',
					'hrsh7th/cmp-path'
		},
		config = function()
			local cmp = require 'cmp'
			cmp.setup {
				completion = { completeopt = 'menu,menuone,noinsert' },
				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-y>'] = cmp.mapping.confirm { select = true },

					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
				},
                sources = {
                    { name = 'nvim_lsp' }
                }
		}
		end,
	},
	'christoomey/vim-tmux-navigator'

})
