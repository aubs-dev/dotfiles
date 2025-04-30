return {
    "aubs-dev/hopper.nvim",
    cmd = { "Hopper" },
    opts = {
        dirs = {
            "C:/Dev/dotfiles/.config/nvim",
            "C:/Dev/projects/c-cpp/game",
            "C:/Dev/projects/c-cpp/cpp-port",
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
