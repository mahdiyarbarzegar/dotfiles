-- ============================================================
-- Neovim options
-- ============================================================

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 8
opt.shiftwidth = 8
set softtabstop=8
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
opt.scrolloff = 16
opt.clipboard = unnamedplus,unnamed,ideaput

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
