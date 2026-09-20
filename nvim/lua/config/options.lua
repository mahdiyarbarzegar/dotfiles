-- ============================================================
-- Neovim options
-- ============================================================

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Editing
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Backup / swap
opt.swapfile = false
opt.backup = false
opt.undofile = true
