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

	-- sets vim.ui.select to telescope, see https://github.com/simrat39/rust-tools.nvim/issues/232
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			config = function()
				require("telescope").load_extension("ui-select")
			end,
		},
	},
}
