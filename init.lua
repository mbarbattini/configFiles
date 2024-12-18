local vim = vim
local o = vim.o
local g = vim.g
local Plug = vim.fn["plug#"]


vim.call('plug#begin')

Plug('morhetz/gruvbox')
-- Telescope is a fuzzy finder for filenames and grep command (content in files)
Plug('nvim-telescope/telescope.nvim', { ['tag']='0.1.5' })
Plug('nvim-lua/plenary.nvim') -- required for telescope
Plug('neovim/nvim-lspconfig') -- LSP support
Plug('scrooloose/nerdcommenter') -- comment out lines easily
-- Autocompletion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('VonHeikemen/lsp-zero.nvim', {['branch']='v3.x'})
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('theprimeagen/harpoon')
Plug('kaicataldo/material.vim', {['branch']='main'})
Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'}) -- better color highlighting of text
vim.call('plug#end')

g.mapleader=' '
o.scrolloff=10
o.syntax='on'
o.tabstop=4
o.visualbell=true
o.ruler=true
o.encoding='utf-8'
o.softtabstop=4
o.shiftwidth=4
o.smartindent=true
o.autoindent=true
o.number = true
o.relativenumber = true
o.wrap = true
o.hlsearch = true
o.mouse = 'a'
o.updatetime = 300
o.cmdheight = 1
o.signcolumn='yes'
o.history = 50
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

local function map(mode, key, value)
	vim.keymap.set(mode,key,value,{silent=true})
end

-- COLORSCHEME
vim.cmd('silent! colorscheme material')

-- telescope keybindings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

--require'nvim-treesitter.configs'.setup {
  ---- A list of parser names, or "all" (the five listed parsers should always be installed)
  --ensure_installed = { "c", "vim", "vimdoc", "query", "rust", "python", "javascript"},

  ---- Install parsers synchronously (only applied to `ensure_installed`)
  --sync_install = false,

  ---- Automatically install missing parsers when entering buffer
  ---- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  --auto_install = true,

  ------ If you need to change the installation directory of the parsers (see -> Advanced Setup)
  ---- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  --highlight = {
    --enable = true,

    ---- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    ---- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    ---- Using this option may slow down your editor, and you may see some duplicate highlights.
    ---- Instead of true it can also be a list of languages
    --additional_vim_regex_highlighting = false,
  --},
--}

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
-- see :help lsp-zero-keybindings
-- to learn the available actions
lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
	ensure_installed = {'eslint', 'rust_analyzer', 'pylsp', 'clangd'},
	handlers = {
	  lsp_zero.default_setup,
	},
})

lsp_zero.preset('recommended')
lsp_zero.setup()

-- Python LSP setup with pylsp
local lspconfig = require('lspconfig')
lspconfig.pylsp.setup({
settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {
			  'E302', 
			  'E303', 
			  'W209',
			  'W293',
			  'E201',
			  'E501',
			  'E701',
			  'E231',
			  'W291',
			  'E704',
			  'E226',
			  'E211',
			  'E251',
			  'E202',
			  'E261',
			  'E122',
			  'E225',
		  },
          maxLineLength = 100
        }
      }
    }
  }
})

-- Go LSP setup with gopls
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})



local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
window = {
  completion = cmp.config.window.bordered(),
  documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),

})
