local keymap = vim.keymap
local api = vim.api

local opts = { noremap = true, silent = true }

-- -------------------------------------------
-- Functions
-- -------------------------------------------

function SaveAllFiles()
    api.nvim_command("silent! wa")
    local currentTime = os.date("%H:%M:%S")
    print("Files Saved - " .. currentTime)
end

function ToggleOption(name)
    if name == nil or name == "" then return end

    for _, windowId in ipairs(api.nvim_list_wins()) do
        local options = { scope = "local", win = windowId }
        local state = api.nvim_get_option_value(name, options)
        api.nvim_set_option_value(name, not state, options)
    end
end

function GetBufferDirectory()
    -- Get the absolute path of the current buffer's directory using its filename
    local path = vim.fn.expand("%:p:h")
    return vim.fn.fnameescape(path)
end
-- -------------------------------------------
-- Default Keybinds
-- -------------------------------------------

-- Enter command mode
keymap.set("n", ";", ":", opts)

-- Clear search & highlight
keymap.set("n", "<Esc>", ":nohl<CR>:echo ''<CR>", opts)

-- Leave terminal mode by hitting esc
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Move current line up or down
keymap.set("n", "<A-Up>", ":move -2<cr>", opts)
keymap.set("n", "<A-Down>", ":move +1<cr>", opts)

-- Saving and quitting
keymap.set("n", "<C-s>", ":lua SaveAllFiles()<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:lua SaveAllFiles()<CR>", opts)

-- Toggling
keymap.set("n", "<leader>ln", ":lua ToggleOption('number')<CR>", opts)
keymap.set("n", "<leader>rn", ":lua ToggleOption('relativenumber')<CR>", opts)
keymap.set("n", "<leader>wr", ":lua ToggleOption('wrap')<CR>", opts)

-- Window splits (vertical, horizontal & make equal)
keymap.set("n", "<leader>sv", "<C-w>v", opts)
keymap.set("n", "<leader>sh", "<C-w>s", opts)
keymap.set("n", "<leader>se", "<C-w>=", opts)

keymap.set("n", "<leader>ww", "<C-w>k", opts)
keymap.set("n", "<leader>ss", "<C-w>j", opts)
keymap.set("n", "<leader>aa", "<C-w>h", opts)
keymap.set("n", "<leader>dd", "<C-w>l", opts)

-- Window tabs (open, close, move next & move previous)
keymap.set("n", "<leader>to", ":tabnew<CR>", opts)
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)
keymap.set("n", "<leader>tn", ":tabn<CR>", opts)
keymap.set("n", "<leader>tp", ":tabp<CR>", opts)

-- -------------------------------------------
-- Plugin Keybinds
-- -------------------------------------------

-- Lazy package manager
keymap.set("n", "<leader>ll", ":Lazy<CR>", opts)
keymap.set("n", "<leader>lu", ":Lazy update<CR>", opts)

-- Oil file exporer
keymap.set("n", "<leader>fv", ":lua vim.api.nvim_command('Oil ' .. GetBufferDirectory())<CR>", opts) -- [F]ile [V]iew

-- Telescope
keymap.set("n", "<leader>kb", ":Telescope keymaps<CR>", opts) -- [K]ey [B]indings
keymap.set("n", "<leader>ch", ":Telescope command_history<CR>", opts) -- [C]ommand [H]istory

keymap.set("n", "<leader><space>", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ile [F]inder
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts) -- [F]ile [S]tring
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- [F]ind [W]ord "under cursor"

keymap.set("n", "<leader>fb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ind [B]uffer

-- Language Server (LSP)
keymap.set("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown{layout_config = {width = 0.9}})<CR>", opts) -- [F]ind [D]iagnostics
keymap.set("n", "<leader>fr", ":Telescope lsp_references theme=dropdown<CR>", opts) -- [F]ind [R]eferences
keymap.set("n", "<leader>gd", ":Telescope lsp_definitions<CR>", opts) -- [G]oto [D]efinition
keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols theme=dropdown<CR>", opts) -- [D]ocument [S]ymbols

-- TEMPORARY
function OpenAndChangeCWD(path)
    -- Open file exporer
    local cmd = string.format(":Oil %s", path)
    api.nvim_command(cmd)

    -- Change the current working directory
    api.nvim_set_current_dir(path)
    print(path)
end

keymap.set("n", "<leader>1", ":lua OpenAndChangeCWD('C:/Dev/dotfiles/.config/nvim')<CR>", opts)
keymap.set("n", "<leader>2", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/game')<CR>", opts)
keymap.set("n", "<leader>3", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/cpp-port')<CR>", opts)
