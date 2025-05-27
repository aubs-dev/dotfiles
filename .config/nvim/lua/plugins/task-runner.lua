return {
    "aubs-dev/task-runner.nvim",
    dev = true,
    lazy = true,
    opts = {
        tasks = {
            "game",
            "forge",
            "clean",
        }
    },
    dependencies = {
        { "aubs-dev/NLIB.nvim" },
    },
}
