return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            -- LSP
            "cmake",
            "ols",
            "pylsp",
            -- "lua_ls", -- Manual install & add to PATH
            -- "clangd", -- Manual install & add to PATH
        },
    },
    dependencies = {
        { "williamboman/mason.nvim" },
    },
}
