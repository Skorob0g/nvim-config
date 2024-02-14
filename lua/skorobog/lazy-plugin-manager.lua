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
				'nvim-telescope/telescope.nvim',
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
		}

})
