-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/cmake.lua

return {
    cmd = {
        "cmake-language-server",
    },
    filetypes = {
        "cmake",
    },
    root_markers = {
        ".git",
        "CMakeLists.txt",
        "build",
        "cmake",
    },
    init_options = {
        buildDirectory = "build",
    },
}
