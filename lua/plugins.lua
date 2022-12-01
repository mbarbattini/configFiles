local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
-- vim.cmd( 
-- 	augroup packer_user_config
-- 	autocmd!
-- 	autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup END
-- )

packer.startup(function(use)
	use('wbthomason/packer.nvim')

	use('scrooloose/nerdtree') -- file navigation system
	use({'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}) -- cool status bar
	-- use('neoclide/coc.nvim', { 'branch': 'release' }) -- auto completion
	use('scrooloose/nerdcommenter') -- comment out lines easily
	use('jiangmiao/auto-pairs') -- auto close braces
	use('tpope/vim-fugitive') -- git integration
	use("kyazdani42/nvim-palenight.lua")
end)

