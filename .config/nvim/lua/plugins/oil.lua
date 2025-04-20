return {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["<C-s>"] = false,
            ["<C-h>"] = false,
            ["<C-t>"] = false,
            ["<C-p>"] = false,
            ["<C-c>"] = false,
            ["`"] = false,
            ["~"] = false,
            ["gs"] = false,
            ["gx"] = false,
            ["g."] = false,
            ["g\\"] = false,
        },
        view_options = {
            show_hidden = true,
        },
        preview_win = {
            disable_preview = function(filename)
                return true
            end,
        },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
