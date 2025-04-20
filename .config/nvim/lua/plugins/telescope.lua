return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
        local assets = ",**/assets/font,**/assets/music,**/assets/particle,**/assets/sound,**/assets/sprite,**/assets/tilemap"
        local excludedDirs = "!{**/.git/*,**/.cache/*,**/bin/*,**/build/*" .. assets

        require("telescope").setup({
            defaults = {
                hidden = true,
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--follow",
                    "--hidden",
                    "--no-ignore-vcs",
                    "--glob",
                    excludedDirs .. ",**/external/*}",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        "rg",
                        "--follow",
                        "--hidden",
                        "--files",
                        "--no-ignore-vcs",
                        "--glob",
                        excludedDirs .. "}",
                    },
                },
            },
        })
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
}
