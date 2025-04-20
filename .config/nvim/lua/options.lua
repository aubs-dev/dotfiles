local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"

-- Indentation & wrapping
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1
opt.expandtab = true
opt.smarttab = true

opt.smartindent = true
opt.autoindent = true
opt.cindent = true

opt.wrap = false

opt.backspace = "indent,eol,start"

-- Cursor
opt.cursorline = true
opt.scrolloff = 0
-- opt.scrolloff = 4
opt.updatetime = 100
opt.mousemodel = "extend"

-- Text & Clipboard
-- opt.iskeyword:append("-") -- Consider dash as part of a word
opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Cmd & Search
opt.showcmd = true
opt.ignorecase = true
opt.smartcase = true

-- Filetypes
vim.g.c_syntax_for_h = 1

-- Window management
opt.splitright = true
opt.splitbelow = true

-- Colors
opt.background = "dark"
opt.termguicolors = true
