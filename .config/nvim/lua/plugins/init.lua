return {
    -- Dependencies
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim", lazy = true },

    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            -- require("gruvbox").setup({
            --     invert_selection = true
            -- })
            vim.cmd("colorscheme gruvbox")
        end
    },

    -- File management
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
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
                }
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
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
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.3",
        build = ":TSUpdateSync",
        event = "BufReadPre",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "luadoc",
                    "vim",
                    "vimdoc",
                    "markdown",
                    "markdown_inline",
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
                highlight = { enable = true },
                indent = { enable = true },
            })

            vim.filetype.add({
                extension = {
                    vert = "glsl",
                    frag = "glsl",
                },
            })
        end,
    },

    -- Managing & installing lsp servers, linters & formatters
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cmake",
                    "ols",
                    "pylsp",
                    -- "lua_ls", -- Manual install & add to PATH
                    -- "clangd", -- Manual install & add to PATH
                },
            })
        end,
    },
    -- TODO: CONTINUE FROM HERE
    -- Configuring LSP servers
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                floating_window = false,
                hint_prefix = "",
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- lsp capabilities
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "hrsh7th/cmp-cmdline", -- source for vim cmd

            -- Snippets
            { "L3MON4D3/LuaSnip", version = "2.3.0" }, -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- source for autocomplete
        },
    },

    -- IDE visuals
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "gruvbox",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        {
                            "filename",
                            path = 4
                        }
                    },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            "filename",
                            path = 4
                        }
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },
    {
        "echasnovski/mini.tabline",
        version = false,
        config = function()
            require("mini.tabline").setup({
                set_vim_settings = false,
                tabpage_section = "right",
            })
        end,
    },

    -- Utility
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                },
            })
            require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                indent = { char = "│" },
                scope = { enabled = false },
            })
        end,
    },
    {
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
                    swap_icons = true,
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
        end
    }
}
