return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            -- LSP
            -- "clangd", -- Manual install & add to PATH
            -- "lua_ls", -- Manual install & add to PATH
            "cmake",
            "ols",
        },
    },
    dependencies = {
        { "williamboman/mason.nvim" },
    },
}
