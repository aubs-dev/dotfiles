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
opt.scrolloff = 4
opt.updatetime = 100
opt.mousemodel = extend

-- Cmd & Search
opt.showcmd = true
opt.ignorecase = true
opt.smartcase = true

-- Text & Clipboard
opt.iskeyword:append("-") -- Consider dash as part of a word
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
keymap.set("n", "<C-s>", ":echo ''<CR>:wa<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:echo ''<CR>:wa<CR>", opts)

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
keymap.set("n", "<leader>kb", ":Telescope keymaps<CR>", opts) -- [K]ey [B]indings
keymap.set("n", "<leader>ch", ":Telescope command_history<CR>", opts) -- [C]ommand [H]istory

keymap.set("n", "<leader><space>", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ile [F]inder
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts) -- [F]ile [S]tring
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- [F]ind [W]ord "under cursor"
keymap.set("n", "<leader>ds", ":Telescope treesitter theme=dropdown<CR>", opts) -- [D]ocument [S]ymbols

keymap.set("n", "<leader>fb",":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer=false}))<CR>", opts) -- [F]ind [B]uffer

-- -------------------------------------------
-- Management Keybinds
-- -------------------------------------------

-- Build tasks (needs tasks.json at project root)
function TaskRunner()
	local Menu = require("nui.menu")

	-- Check if the tasks file exists
	local path = vim.fn.getcwd():gsub("\\", "/")
	local tasksFilePath = path .. "/tasks.json"

	if not vim.loop.fs_stat(tasksFilePath) then
		print("Task runner: File 'tasks.json' not found in '" .. path .. "'")
		return
	end

	-- Check if the build script exists
	local scriptFilePath = path .. "/build.bat"

	if not vim.loop.fs_stat(scriptFilePath) then
		print("Task runner: File 'build.bat' not found in '" .. path .. "'")
		return
	end

	-- Read the contents of tasks.json
	local contents = vim.fn.readfile(tasksFilePath)

	-- Decode the JSON string
	local jsonData = vim.fn.json_decode(table.concat(contents, "\n"))

	-- Prepare list data based on specs provided by tasks.json
	local linesData = {}

	if jsonData.tasks ~= nil then
		if #jsonData.tasks > 0 then
			for index, task in ipairs(jsonData.tasks) do
				-- Task sanity checks
				if task.name == nil then
					print("Task runner: Key 'name' in task [id: " .. index .. "] not found!")
					return
				elseif task.name == "" then
					print("Task runner: Key 'name' in task [id: " .. index .. "] has no value!")
					return
				end

				if task.target == nil then
					print("Task runner: Key 'target' in task [id: " .. index .. "] not found!")
					return
				elseif task.target == "" then
					print("Task runner: Key 'target' in task [id: " .. index .. "] has no value!")
					return
				end

				-- Prepare data
				local item = {
					name = task.name,

					target = task.target,
					args = "",
					useTerminal = false,
				}

				if task.args ~= nil then
					item.args = task.args
				end

				if task.useTerminal ~= nil then
					item.useTerminal = task.useTerminal
				end

				table.insert(linesData, Menu.item(" " .. index .. ". " .. task.name, item))
			end
		else
			print("Task runner: No tasks found!")
			return
		end
	else
		print("Task runner: List 'tasks' is empty!")
		return
	end

	-- Mount the UI
	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = #jsonData.tasks,
		},
		border = {
			style = "single",
			text = {
				top = "[Task-Runner]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = linesData,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("Task runner: Cancelled!")
		end,
		on_submit = function(item)
			print("Task runner: Executed task '" .. item.name .. "'")

			local cmd = "build.bat " .. item.target
			local args = (item.args ~= "" and (" " .. item.args) or "")

			if item.useTerminal == true then
				vim.fn.execute("split | terminal " .. cmd .. args)
			else
				vim.fn.system(cmd .. args)
				if vim.v.shell_error ~= 0 then
					print("Task runner: Failed to execute task '" .. item.name .. "'")
				end
			end
		end,
	})

	menu:mount()
end

keymap.set("n", "<leader>tr", ":lua TaskRunner()<CR>", opts)

-- Open projects
function OpenAndChangeCWD(path)
	-- Open file exporer
	local cmd = string.format(":Oil %s", path)
	vim.fn.execute(cmd)

	-- Change the current working directory
	vim.api.nvim_set_current_dir(path)
	print(path)
end

keymap.set("n", "<leader>1", ":lua OpenAndChangeCWD('C:/Dev/dotfiles/.config/nvim')<CR>", opts)
keymap.set("n", "<leader>2", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/tribe-game')<CR>", opts)
keymap.set("n", "<leader>3", ":lua OpenAndChangeCWD('C:/Dev/projects/old/engine-old')<CR>", opts)

-- Reload config
keymap.set("n", "<leader><A-r>", ":source C:/Dev/dotfiles/.config/nvim/init.lua<CR>")

-- Plugin specific configs
require("sanyok.nvimcmp")
