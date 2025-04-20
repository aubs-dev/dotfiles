return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    config = function()
        require('cord').setup({
            editor = {
                tooltip = "Nvim <3",
            },
            display = {
                theme = "atom",
                flavor = "light",
                swap_icons = false,
            },
            timestamp = {
                enabled = true,
                reset_on_change = false,
            },
            idle = {
                enabled = false,
            },
            text = {
                workspace = function(opts) return "in " .. opts.workspace .. "." end,
                viewing = function(opts) return "Viewing " .. opts.filename end,
                editing = function(opts) return "Editing " .. opts.filename end,
                file_browser = true,
                plugin_manager = true,
                lsp = true,
                docs = true,
                vcs = true,
                notes = true,
                debug = true,
                test = true,
                diagnostics = true,
                games = true,
                terminal = true,
                dashboard = true,
            },
            assets = {
                [".h"] = {
                    icon = require("cord.api.icon").get("c", "atom", "light"),
                    tooltip = "C Header",
                    name = "C Header",
                    type = "language",
                },
            },
            advanced = {
                plugin = {
                    cursor_update = "none",
                },
                discord = {
                    reconnect = {
                        enabled = false,
                        interval = 5000,
                        initial = true,
                    },
                },
            },
        })
    end,
}
