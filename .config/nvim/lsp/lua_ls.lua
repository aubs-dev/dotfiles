-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua

return {
    cmd = {
        "lua-language-server",
    },
    filetypes = {
        "lua",
    },
    root_markers = {
        ".git",
        "docs",
        "lua",
    },
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                },
                disable = {
                    "missing-parameters",
                    "missing-fields",
                    "unused-local",
                    "unused-param",
                },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
                -- checkThirdParty = "Apply",
            },
        },
    },
    single_file_support = true,
}
