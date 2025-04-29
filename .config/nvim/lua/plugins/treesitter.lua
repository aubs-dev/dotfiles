return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "luadoc",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
                "html",
                "latex",
                "gitignore",
                "gitattributes",
                "json",
                "toml",
                "bash",
                "c",
                "cpp",
                "make",
                "cmake",
                "glsl",
                "odin",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
