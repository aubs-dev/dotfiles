local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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
