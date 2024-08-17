-- Auto-install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
	-- Colorscheme
	{ "morhetz/gruvbox" },

	-- File management
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				-- Restore window options to previous values when leaving an oil buffer
				restore_win_options = false,
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
				},
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		cmd = "Telescope",
		config = function()
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
						"!{**/.git/*,**/.cache/*,**/bin/*,**/dist/*,**/build/*,**/external/*}",
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
							"!{**/.git/*,**/.cache/*,**/bin/*,**/dist/*,**/build/*}",
						},
					},
				},
			})
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
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
					-- theme = "onenord",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
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
	{ "MunifTanjim/nui.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.2",
		build = ":TSUpdateSync",
		event = "BufReadPre",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"c",
					"cpp",
					"odin",
					"cmake",
					"make",
					"bash",
					"gitignore",
					"json",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-cmdline", -- source for vim cmd
		},
	},

	-- Utility
	{
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	},
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

	-- Fun
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
})
