-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/clangd.lua

return {
    cmd = {
        "clangd.exe",
        "--all-scopes-completion",
        "--background-index",
        "--completion-style=detailed",
        "-j=4",
        "--pch-storage=memory",
        "--pretty",
        -- "--log=verbose",
    },
    filetypes = {
        "c",
        "cpp",
    },
    root_markers = {
        ".cache",
        ".clangd",
        ".git",
        "bin",
    },
    init_option = {
        fallbackFlags = {
            "-std=c++20"
        },
    },
}
