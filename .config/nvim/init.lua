-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap the lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    rocks = {
        enabled = false,
    },
    dev = {
        path = function(plugin)
            return "C:/Dev/projects/lua/nvim-plugins/" .. plugin.name
        end,
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
    ui = {
        border = "rounded",
    },
})

-- General
require("options")
require("filetype")
require("autocmds")

vim.schedule(function()
    require("mappings")
end)

require("lsp")
