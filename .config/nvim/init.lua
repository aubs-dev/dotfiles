require("plugin-setup")

-- -------------------------------------------
-- Vim options
-- -------------------------------------------
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false

-- Indentation & wrapping
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1
opt.expandtab = true
opt.smarttab = true

opt.smartindent = true
opt.autoindent = true
opt.cindent = true

opt.wrap = false

opt.backspace = "indent,eol,start"

-- Cursor
opt.cursorline = true
opt.scrolloff = 0
-- opt.scrolloff = 4
opt.updatetime = 100
opt.mousemodel = extend

-- Cmd & Search
opt.showcmd = true
opt.ignorecase = true
opt.smartcase = true

-- Text & Clipboard
-- opt.iskeyword:append("-") -- Consider dash as part of a word
opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Window management
opt.splitright = true
opt.splitbelow = true

-- Colors
-- (Gruvbox)
opt.background = "dark"
opt.termguicolors = true

vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_invert_selection = 0
vim.cmd([[colorscheme gruvbox]])

-- -------------------------------------------
-- General Keybinds
-- -------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

function ToggleLineNumbers(isRelative)
    local state = vim.o.number
    if isRelative == true then
        state = vim.o.relativenumber
    end

    -- Set option for all current windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if isRelative == true then
            vim.api.nvim_win_set_option(win, "relativenumber", not state)
        else
            vim.api.nvim_win_set_option(win, "number", not state)
        end
    end

    -- Set option for all future windows
    if isRelative == true then
        vim.o.relativenumber = not state
    else
        vim.o.number = not state
    end
end

function ToggleLineWrap()
    local state = vim.o.wrap

    -- Set option for all current windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_set_option(win, "wrap", not state)
    end

    -- Set option for all future windows
    vim.o.wrap = not state
end

-- Toggle line number state
keymap.set("n", "<leader>ln", ":lua ToggleLineNumbers(false)<CR>", opts)
keymap.set("n", "<leader>rn", ":lua ToggleLineNumbers(true)<CR>", opts)

-- Leave terminal mode by hitting esc
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Move current line up or down
keymap.set("n", "<A-Up>", ":move -2<cr>", opts)
keymap.set("n", "<A-Down>", ":move +1<cr>", opts)

-- Clear search & highlight
keymap.set("n", "<Esc>", ":nohl<CR>:echo ''<CR>", opts)

-- Toggle word wrapping
keymap.set("n", "<leader>wr", ":lua ToggleLineWrap()<CR>", opts)

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

-- Saving and quitting
function SaveAllFiles()
    vim.cmd("silent! wa")
    local curTime = os.date("%H:%M:%S")
    print("Files Saved - " .. curTime)
end

keymap.set("n", "<C-s>", ":lua SaveAllFiles()<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:lua SaveAllFiles()<CR>", opts)

-- -------------------------------------------
-- Plugin Keybinds
-- -------------------------------------------

-- Lazy package manager
keymap.set("n", "<leader>ll", ":Lazy<CR>", opts)
keymap.set("n", "<leader>lu", ":Lazy update<CR>", opts)

-- Oil file exporer
function GetBufferDir()
	local buffer_name = vim.fn.expand("%:p:h")
	return vim.fn.fnameescape(buffer_name)
end

keymap.set("n", "<leader>fv", ":lua vim.cmd('Oil ' .. GetBufferDir())<CR>", opts) -- [F]ile [V]iew

-- Telescope
keymap.set("n", "<leader>km", ":Telescope keymaps<CR>", opts) -- [K]ey [M]appings
keymap.set("n", "<leader>ch", ":Telescope command_history<CR>", opts) -- [C]ommand [H]istory

keymap.set("n", "<leader><space>", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ile [F]inder
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts) -- [F]ile [S]tring
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- [F]ind [W]ord "under cursor"
keymap.set("n", "<leader>ds", ":Telescope treesitter theme=dropdown<CR>", opts) -- [D]ocument [S]ymbols

keymap.set("n", "<leader>fb",":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ind [B]uffer

-- -------------------------------------------
-- Management Keybinds
-- -------------------------------------------

function TerminalRunCommand(cmd, doScroll)
    -- Find terminal to hook onto
    local foundTerminal = false
    local terminalID = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.b[buf].taskRunnerConsole then
            foundTerminal = true
            terminalID = buf
            break
        end
    end

    local createTerminal = false
    if foundTerminal == true then
        -- Check if the terminal child process is still running
        local lineCount = vim.api.nvim_buf_line_count(terminalID)
        local startLine = math.max(lineCount - 50, 0) -- Check the last X amount of lines

        local lines = vim.api.nvim_buf_get_lines(terminalID, startLine, lineCount, false)

        local processExited = false
        for _, line in ipairs(lines) do
            if line:match("%[Process exited") then
                -- If the process is no longer running, use the current terminal
                vim.api.nvim_buf_delete(terminalID, { force = true })
                createTerminal = true
                processExited = true
                break
            end
        end

        -- ELSE: If the process is still running, stop the current build command
        if processExited == false then
            print("Build: failed to execute. A process is still running!")
        end
    else
        createTerminal = true
    end

    -- If no terminal exists, create one and run the build command
    if createTerminal == true then
        vim.cmd("split | terminal " .. cmd)
        vim.api.nvim_buf_set_var(0, "taskRunnerConsole", true)
        if doScroll then
            vim.cmd("normal! G")
        end
    end
end

function TerminalClose()
    if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert")
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", false)
    end
end

function CreateChoiceMenu(title, choices, submissionFunc)
    -- Argument checks
    if title == nil or title == "" then
        print("Failed to create choice menu, title is empty!")
    end

    if submissionFunc == nil then
        print("Failed to create choice menu, no submission function provided!")
    end

    if type(choices) == "table" and next(choices) ~= nil then
        local Menu = require("nui.menu")

        -- Prepare menu data
        local menuData = {}
        for index, choice in ipairs(choices) do
            local item = { task = choice }
            table.insert(menuData, Menu.item(" " .. (index - 1) .. ". " .. choice, item))  
        end

        -- Create menu instance
        local menuInstance = Menu({
            position = "50%",
            size = {
                width = 25,
                height = #menuData,
            },
            border = {
                style = "single",
                text = {
                    top = "[" .. title .. "]",
                    top_align = "center",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
            }, {
                lines = menuData,
                max_width = 20,
                keymap = {
                    focus_next = { "j", "<Down>", "<Tab>" },
                    focus_prev = { "k", "<Up>", "<S-Tab>" },
                    close = { "<Esc>", "<C-c>" },
                    submit = { "<CR>", "<Space>" },
                },
                on_close = function()
                    print("MENU: No choices selected!")
                end,
                on_submit = submissionFunc,
        })

        return menuInstance
    else
        print("Failed to create choice menu, choices is empty!")
        return nil
    end
end

function TaskRunner()
    local basePath = vim.fn.getcwd():gsub("\\", "/")
    local buildPath = basePath .. "/build.bat"

    -- Check if the build script exists
	if not vim.loop.fs_stat(buildPath) then
		print("TaskRunner: File 'build.bat' not found in '" .. basePath .. "'")
		return
	end
    
    -- Create target selection menu
    local menu = CreateChoiceMenu(
        "Task-Runner", 
        { "run debug", "run release", "asset", "clean" }, 
        function(item)
            print("Task Runner: executed task '" .. item.task .. "'!")
            local cmd = buildPath .. " " .. item.task
            local doScroll = (item.task ~= "run debug" and item.task ~= "run release")
            TerminalRunCommand(cmd, doScroll)
        end
    )

    if menu ~= nil then
        menu:mount()
    end
end

keymap.set("n", "<leader>tr", ":lua TaskRunner()<CR>", opts)
keymap.set("n", "<CR>", ":lua TerminalClose()<CR>", opts)

-- Open projects
function OpenAndChangeCWD(path)
	-- Open file exporer
	local cmd = string.format(":Oil %s", path)
	vim.cmd(cmd)

	-- Change the current working directory
	vim.api.nvim_set_current_dir(path)
	print(path)
end

keymap.set("n", "<leader>1", ":lua OpenAndChangeCWD('C:/Dev/dotfiles/.config/nvim')<CR>", opts)
keymap.set("n", "<leader>2", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/game')<CR>", opts)
keymap.set("n", "<leader>3", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/game-prototype')<CR>", opts)

-- Reload config
keymap.set("n", "<leader><A-r>", ":source C:/Dev/dotfiles/.config/nvim/init.lua<CR>")

-- Plugin specific configs
require("sanyok.nvimcmp")
