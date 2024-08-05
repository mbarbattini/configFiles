call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'vim-airline/vim-airline' " Cool status bar
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
Plug 'preservim/nerdtree' " file navigation system
Plug 'scrooloose/nerdcommenter' " comment out lines easily
" Plug 'jiangmiao/auto-pairs' " auto close braces
Plug 'tpope/vim-fugitive' " git integration
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
" or                                , { 'branch': '0.1.x' }lug ''
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP Support
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'theprimeagen/harpoon'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

call plug#end()

" use tab to accept a suggestion from the nvim alphabetical suggestions
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Theme
" colorscheme iceberg
" colorscheme gruvbox
"

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif


let g:material_theme_italics=1
let g:material_theme_style='darker'
colorscheme material

let mapleader = "\<Space>"
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set relativenumber
set number
set ruler
set visualbell
set encoding=utf-8
set wrap
set hlsearch
set incsearch
set autoindent
set smartindent
set mouse=a
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=1
set shortmess+=c
set signcolumn=yes

let g:airline_theme='cyberpunk'
" vim-airline customization
" let g:airline_section_b = '%{strftime("%c")}'
" let g:airline_section_y = 'BN: %{bufnr("%")}'


" open nerdtree on start
autocmd VimEnter * NERDTree


" nerdtree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" go between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-d>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-f>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-g>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

EOF

function! TreeSitterStart()
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python", "help", "javascript"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
endfunction


lua << EOF

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
    ensure_installed = {'tsserver',  'eslint', 'rust_analyzer', 'pylsp', 'clangd'},
    handlers = {
      lsp_zero.default_setup,
    },
  })

lsp_zero.preset('recommended')
lsp_zero.setup()

-- Ignore some errors from pylsp
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

-- lspconfig.clangd.setup({
--
-- })



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


EOF

