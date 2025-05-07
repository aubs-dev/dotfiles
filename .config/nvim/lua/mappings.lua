local keymap = vim.keymap
local api = vim.api

local opts = { noremap = true, silent = true }

-- -------------------------------------------
-- Functions
-- -------------------------------------------

function SaveAllFiles()
    vim.cmd("silent! wa")
    local currentTime = os.date("%H:%M:%S")
    print("Files Saved - " .. currentTime)
end

function ToggleOption(name)
    if name == nil or name == "" then return end

    for _, windowId in ipairs(api.nvim_list_wins()) do
        local options = { scope = "local", win = windowId }
        local state = not api.nvim_get_option_value(name, options)
        api.nvim_set_option_value(name, state, options)
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

-- Clear search & highlight
keymap.set("n", "<Esc>", function()
	vim.cmd("noh")
	vim.cmd("echo ''")
	vim.snippet.stop()
	return "<Esc>"
end, opts)

-- Leave terminal mode by hitting esc
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Move current line up or down
keymap.set("n", "<A-Up>", ":move -2<CR>", opts)
keymap.set("n", "<A-Down>", ":move +1<CR>", opts)

-- Saving and quitting
keymap.set("n", "<C-s>", ":lua SaveAllFiles()<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:lua SaveAllFiles()<CR>", opts)

-- Toggling
keymap.set("n", "<leader>ln", ":lua ToggleOption('number')<CR>", opts) -- [L]ine [N]umber
keymap.set("n", "<leader>rn", ":lua ToggleOption('relativenumber')<CR>", opts) -- [R]elative [N]umbers
keymap.set("n", "<leader>wr", ":lua ToggleOption('wrap')<CR>", opts) -- [W][R]ap

-- Buffer actions
keymap.set("n", "<leader>bd", ":bd<CR>", opts) -- [B]uffer [D]elete

-- Window splits & movement
keymap.set("n", "<leader>sv", "<C-w>v", opts) -- [S]plit [V]ertical
keymap.set("n", "<leader>sh", "<C-w>s", opts) -- [S]plit [H]orizontal
keymap.set("n", "<leader>se", "<C-w>=", opts) -- [S]plit [E]qual

keymap.set("n", "<leader>ww", "<C-w>k", opts)
keymap.set("n", "<leader>ss", "<C-w>j", opts)
keymap.set("n", "<leader>aa", "<C-w>h", opts)
keymap.set("n", "<leader>dd", "<C-w>l", opts)

-- Window tabs
keymap.set("n", "<leader>to", ":tabnew<CR>", opts)   -- [T]ab [O]pen
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts) -- [T]ab [C]lose
keymap.set("n", "<leader>tn", ":tabn<CR>", opts)     -- [T]ab [N]ext
keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     -- [T]ab [P]revious

-- -------------------------------------------
-- Plugin Keybinds
-- -------------------------------------------

-- Lazy package manager
keymap.set("n", "<leader>ll", ":Lazy<CR>", opts) -- [L]azy [L]ist
keymap.set("n", "<leader>lu", ":Lazy update<CR>", opts) -- [L]azy [U]pdate

-- Oil file exporer
keymap.set("n", "<leader>fv", ":lua vim.cmd('Oil ' .. GetBufferDirectory())<CR>", opts) -- [F]ile [V]iew

-- Telescope
keymap.set("n", "<leader>km", ":Telescope keymaps<CR>", opts) -- [K]ey [M]appings
keymap.set("n", "<leader>ch", ":Telescope command_history<CR>", opts) -- [C]ommand [H]istory

keymap.set("n", "<leader><space>", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ile [F]inder | Not acurate anymore lol
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts) -- [F]ile [S]tring
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- [F]ind [W]ord "under cursor"

keymap.set("n", "<leader>fb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ind [B]uffer

-- Language Server (LSP)
keymap.set("n", "<leader>lsi", ":checkhealth vim.lsp<CR>", opts) -- [L]anguage [S]erver [I]nfo
keymap.set("n", "<leader>lss", function () -- [L]anguage [S]erver [S]top
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop(true)
    end

    vim.notify("No language server found in buffer!", vim.log.levels.INFO)
end, opts)

keymap.set("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown{layout_config = {width = 0.9}})<CR>", opts) -- [F]ind [D]iagnostics
keymap.set("n", "<leader>fr", ":Telescope lsp_references theme=dropdown<CR>", opts) -- [F]ind [R]eferences
keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts) -- [G]oto [D]efinition
keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols theme=dropdown<CR>", opts) -- [D]ocument [S]ymbols

-- Hopper
keymap.set("n", "<leader>1", ":Hopper<CR>", opts)

-- Task Runner
keymap.set("n", "<leader>tr", ":lua require('task-runner').choose_task()<CR>", opts)
keymap.set("n", "<CR>", ":lua require('task-runner').terminal_close()<CR>", opts)
