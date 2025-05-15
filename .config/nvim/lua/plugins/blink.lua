return {
    "saghen/blink.cmp",
    tag = "v1.3.1",
    event = "InsertEnter",
    opts = {
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
            },
            -- ghost_text = {
            --     enabled = true,
            --     show_without_menu = false,
            -- },
        },
        keymap = {
            preset = "enter",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },

            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<C-p>"] = {},
            ["<C-n>"] = {},

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        signature = {
            enabled = true,
        },
        sources = {
            default = {
                "lsp",
                "path",
                "buffer",
            },
        },
    },
    opts_extend = {
        "sources.default",
    },
}
