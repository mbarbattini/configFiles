local g = vim.g
local o = vim.o
local set = vim.opt

-- how many extra lines below the cursor
o.scrolloff = 10

-- decrease update time
o.timeoutlen = 500
o.updatetime = 200

o.relativenumber = true
o.number = true

o.clipboard = 'unnamedplus'
o.ignorecase = true
o.smartcase = true

o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

o.history = 50

set.shell =  'C:/Users/H457071/Desktop/Git/usr/bin/bash.exe'