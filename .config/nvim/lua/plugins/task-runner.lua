return {
    "aubs-dev/task-runner.nvim",
    lazy = true,
    opts = {
        tasks = {
            "run",
            "asset-forge",
            "clean",
        }
    },
    dependencies = {
        { "aubs-dev/NLIB.nvim" },
    },
}
