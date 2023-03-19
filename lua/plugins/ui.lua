-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	-- Configure neo-tree for additional key mappings
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
				},
			},
		},
	},
	-- Comment line by Ctrl+/
	{
		"echasnovski/mini.comment",
		keys = { { "<C-_>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" } },
	},

	-- Better ESC
	{ "max397574/better-escape.nvim", config = true },

	-- Make TokyoNight Transparent
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				-- floats = "transparent",
			},
		},
	},
	-- To prevent complaits like: Highlight group 'NotifyBackground' has no background highlight
	{ "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },

	-- Отключение русской раскладки при выходе из Insert Mode
	{ "ts/g3kbswitch.nvim", dir = "/home/tserge/backup/configs/nvim/g3kbswitch.nvim", dev = true, config = true },

	-- Toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<c-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
		},
	},
	-- "ahmedkhalf/project.nvim"

	{
		"telescope.nvim",
		dependencies = {
			-- sets vim.ui.select to telescope, see https://github.com/simrat39/rust-tools.nvim/issues/232
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		opts = {
			defaults = {
				initial_mode = "normal",
				layout_config = { width = 0.9, preview_width = 0.7, preview_cutoff = 60 },
				-- preview = {
				-- 	hide_on_startup = true, -- hide previewer when picker starts
				-- },
				mappings = {
					-- https://github.com/nvim-telescope/telescope.nvim#default-mappings
					n = {
						["<a-i>"] = require("lazyvim.util").telescope("find_files", { no_ignore = true }),
						["<a-h>"] = require("lazyvim.util").telescope("find_files", { hidden = true }),
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					},
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
			},
		},
	},
}
