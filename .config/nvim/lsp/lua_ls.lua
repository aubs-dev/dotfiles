-- Base: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua

return {
    cmd = {
        "lua-language-server.exe",
    },
    filetypes = {
        "lua",
    },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
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
