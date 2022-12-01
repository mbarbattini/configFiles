local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end

-- move through windows easily
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-h>', '<c-w>h')

-- nerdtree shortcuts
map('n', '<leader>n', ':NERDTreeFocus<CR>')
map('n', '<C-n>', ':NERDTree<CR>')
map('n', '<C-t>', ':NERDTreeToggle<CR>')
map('n', '<C-f>', ':NERDTreeFind<CR>')

