local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local argv = vim.v.argv

local general = augroup("aubs-dev/general", { clear = true })

-- Disable newline comments
-- https://github.com/scottmckendry/Windots/blob/main/nvim/lua/core/autocmds.lua
autocmd("BufEnter", {
	group = general,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Show cursor line only in active window
-- https://github.com/folke/dot/blob/master/nvim/lua/config/autocmds.lua
autocmd({ "InsertLeave", "WinEnter" }, {
	group = general,
	callback = function()
		if vim.wo.previewwindow then
			return
		end

		if vim.w.auto_cursorline then
			vim.wo.cursorline = true
			vim.w.auto_cursorline = false
		end
	end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
	group = general,
	callback = function()
		if vim.wo.previewwindow then
			return
		end

		if vim.wo.cursorline then
			vim.w.auto_cursorline = true
			vim.wo.cursorline = false
		end
	end,
})

-- Highlight selection when yanking
-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/dmmulroy/highlight_yank.lua
autocmd("TextYankPost", {
	group = general,
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200, visual = true })
	end,
})

-- Set the current working directory from the arguments used to open NeoVim
local targetDir
for i = 2, #argv do -- Skip argv[1]
    local a = argv[i]

    if not a:match("^%-") then -- Ignore flags
        -- Strip any trailing slash for consistency
        local dir = a:gsub("/$", "")

        if vim.fn.isdirectory(dir) ~= 0 then
            targetDir = dir
            break
        end
    end
end

if targetDir then
    autocmd("VimEnter", {
        group = general,
        callback = function()
            vim.api.nvim_set_current_dir(targetDir)
        end,
    })
end

-- Consider underscores as part of a new word (only in Visual modes)
autocmd("ModeChanged", {
    group = general,
    callback = function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "\22" then -- 'v' for Visual & '\22' for Visual Block
            vim.opt.iskeyword:remove("_") -- Remove underscore from keywords
        else
            vim.opt.iskeyword:append("_") -- Restore underscore as part of keywords
        end
    end,
})
