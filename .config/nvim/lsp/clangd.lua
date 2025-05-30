-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/clangd.lua

return {
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--background-index",
        "--completion-style=bundled",
        "-j=4",
        "--pch-storage=memory",
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
        "build",
    },
    init_option = {
        fallbackFlags = {
            "-std=c++20",
        },
    },
}
