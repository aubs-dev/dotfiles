return {
    "aubs-dev/hopper.nvim",
    cmd = { "Hopper" },
    opts = {
        dirs = {
            "C:/Dev/projects/c-cpp/space-game",
            "C:/Dev/projects/c-cpp/gem-proto-cpp",
            "C:/Dev/projects/c-cpp/gem-proto-c",
            "C:/Dev/dotfiles/.config/nvim",
            "C:/Dev/projects/lua/nvim-plugins",
        },
        explorer = {
            plugin = "stevearc/oil.nvim",
            module = "oil",
        },
    },
    dependencies = {
        {
            "aubs-dev/NLIB.nvim",
            "MunifTanjim/nui.nvim"
        },
    },
}
