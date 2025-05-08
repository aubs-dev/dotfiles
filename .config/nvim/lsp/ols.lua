-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ols.lua

return {
    cmd = {
        "ols",
    },
    filetypes = {
        "odin",
    },
    root_markers = {
        "ols.json",
        ".git",
        "bin",
        "src",
    },
}
