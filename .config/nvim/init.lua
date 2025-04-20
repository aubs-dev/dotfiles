vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    dev = {
        path = "C:/Dev/projects/lua/nvim-plugins",
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
})

-- General
require("options")

vim.schedule(function()
  require("keybinds")
end)

-- Plugin specific
require("configs.lspconfig")
require("configs.nvimcmp")
