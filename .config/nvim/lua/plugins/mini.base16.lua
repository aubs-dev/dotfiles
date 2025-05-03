-- Highlighting functions & groups from: https://github.com/neovim/neovim/blob/master/runtime/colors/vim.lua
local hi = function(name, val)
    -- Force links
    val.force = true
    -- Make sure that 'cterm' attribute is not populated from 'gui'
    val.cterm = val.cterm or {} ---@type vim.api.keyset.highlight
    -- Define global highlight
    vim.api.nvim_set_hl(0, name, val)
end

-- Based on https://github.com/morhetz/gruvbox (dark)
local gruvbox = {
    bg0  = "#282828",
    bg1  = "#3c3836",
    bg2  = "#504945",
    bg3  = "#665c54",
    bg4  = "#7c6f64",
    gray = "#928374",

    fg4 = "#a89984",
    fg3 = "#bdae93",
    fg2 = "#d5c4a1",
    fg1 = "#ebdbb2",
    fg0 = "#fbf1c7",

    red = "#fb4934",
    green = "#b8bb26",
    yellow = "#fabd2f",
    blue = "#83a598",
    purple = "#d3869b",
    aqua = "#8ec07c",
    orange = "#fe8019",
}

return {
    "echasnovski/mini.base16",
    config = function()
        vim.opt.background = "dark"
        vim.opt.termguicolors = true

        -- Based on: https://github.com/chriskempson/base16/blob/main/styling.md
        local p = {
            base00 = gruvbox.bg0,    -- Default Background
            base01 = gruvbox.bg1,    -- Lighter Background (Used for status bars, line number and folding marks)
            base02 = gruvbox.bg2,    -- Selection Background
            base03 = gruvbox.bg4,    -- Comments, Invisibles, Line Highlighting
            base04 = gruvbox.yellow, -- Dark Foreground (Used for status bars)
            base05 = gruvbox.fg1,    -- Default Foreground, Caret, Delimiters, Operators
            base06 = gruvbox.fg0,    -- Light Foreground (Not often used)
            base07 = gruvbox.gray,   -- Light Background (Not often used)
            base08 = gruvbox.fg1,    -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
            base09 = gruvbox.purple, -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
            base0A = gruvbox.yellow, -- Classes, Markup Bold, Search Text Background
            base0B = gruvbox.aqua,   -- Strings, Inherited Class, Markup Code, Diff Inserted
            base0C = gruvbox.yellow, -- Support, Regular Expressions, Escape Characters, Markup Quotes
            base0D = gruvbox.green,  -- Functions, Methods, Attribute IDs, Headings
            base0E = gruvbox.red,    -- Keywords, Storage, Selector, Markup Italic, Diff Changed
            base0F = gruvbox.fg4,    -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
        }

        require("mini.base16").setup({
            palette = p,
            plugins = {
                ["echasnovski/mini.nvim"] = true,
                ["lukas-reineke/indent-blankline.nvim"] = true,
                ["OXY2DEV/markview.nvim"] = true,
                ["williamboman/mason.nvim"] = true,
                ["nvim-telescope/telescope.nvim"] = true,
            },
        })

        -- Override colors
        -- [custom]
        hi("YankHighlight", { fg = gruvbox.bg0, bg = gruvbox.aqua })

        -- [general]
        hi("MsgArea", { fg = gruvbox.fg1 })
        hi("ModeMsg", { fg = gruvbox.aqua })
        hi("MoreMsg", { fg = gruvbox.aqua })
        hi("WarningMsg", { fg = gruvbox.yellow })
        hi("ErrorMsg", { fg = gruvbox.red })

        hi("LineNr", { fg = gruvbox.bg4, bg = gruvbox.bg0 })
        hi("SignColumn", { bg = gruvbox.bg1 })
        hi("CursorLineSign", { bg = gruvbox.bg4 })

        hi("Operator", { fg = gruvbox.fg3 })

        hi("DiagnosticError", { fg = gruvbox.red, bg = gruvbox.bg1 })
        hi("DiagnosticWarn", { fg = gruvbox.yellow, bg = gruvbox.bg1 })
        hi("DiagnosticInfo", { fg = gruvbox.blue, bg = gruvbox.bg1 })
        hi("DiagnosticHint", { fg = gruvbox.green, bg = gruvbox.bg1 })
        hi("DiagnosticOk", { fg = gruvbox.fg1, bg = gruvbox.bg1 })
        hi("DiagnosticUnderlineError", { underline = false })
        hi("DiagnosticUnderlineWarn", { underline = false })
        hi("DiagnosticUnderlineInfo", { underline = false })
        hi("DiagnosticUnderlineHint", { underline = false })
        hi("DiagnosticUnderlineOk", { underline = false })
        hi("DiagnosticVirtualTextError", { link = "DiagnosticError" })
        hi("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
        hi("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
        hi("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
        hi("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
        hi("DiagnosticFloatingError", { link = "DiagnosticError" })
        hi("DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
        hi("DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
        hi("DiagnosticFloatingHint", { link = "DiagnosticHint" })
        hi("DiagnosticFloatingOk", { link = "DiagnosticOk" })
        hi("DiagnosticSignError", { link = "DiagnosticError" })
        hi("DiagnosticSignWarn", { link = "DiagnosticWarn" })
        hi("DiagnosticSignInfo", { link = "DiagnosticInfo" })
        hi("DiagnosticSignHint", { link = "DiagnosticHint" })
        hi("DiagnosticSignOk", { link = "DiagnosticOk" })
        hi("DiagnosticDeprecated", { sp = gruvbox.red, strikethrough = true })

        -- [treesitter]
        -- General
        hi("@keyword.return", { fg = p.base0E })
        -- C
        hi("@constant.builtin.c", { fg = p.base09 })
        -- C++
        hi("@function.builtin.cpp", { fg = p.base0E })
        -- Lua
        hi("@string.regexp.lua", { fg = p.base09 })
        hi("@string.escape.lua", { fg = p.base09 })

        -- [lsp]
        -- hi("", { fg = gruvbox. })
        hi("@module.cpp", { fg = gruvbox.orange })
        hi("@lsp.type.namespace.cpp", { link = "@module.cpp" })

        -- [indent-blankline]
        hi("IblIndent", { fg = p.base01 })

        -- [mini.tabline]
        hi("MiniTablineCurrent",         { fg = gruvbox.bg1, bg = gruvbox.fg1 })
        hi("MiniTablineVisible",         { fg = gruvbox.fg2, bg = gruvbox.bg1 })
        hi("MiniTablineHidden",          { fg = gruvbox.bg4, bg = gruvbox.bg1 })

        hi("MiniTablineModifiedCurrent", { fg = gruvbox.bg0, bg = gruvbox.yellow })
        hi("MiniTablineModifiedVisible", { link = "MiniTablineVisible" })
        hi("MiniTablineModifiedHidden",  { link = "MiniTablineHidden" })
        hi("MiniTablineFill",            { bg = gruvbox.bg2 })
        hi("MiniTablineTabpagesection",  { fg = gruvbox.bg0, bg = gruvbox.purple })
        hi("MiniTablineTrunc",           { fg = gruvbox.bg0, bg = gruvbox.orange })

        -- [mini.trailspace]
        hi("MiniTrailspace", { bg = gruvbox.gray })
    end,
}
