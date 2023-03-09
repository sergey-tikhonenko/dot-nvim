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

	-- add symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		config = true,
	},

	-- Make Markdown support better: highlight codeblocks, headlines, decorate quotes
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},

	-- Еще один вариант Markdown preview
	-- {"ellisonleao/glow.nvim", branch = 'main'}

	-- Отключение русской раскладки при выходе из Insert Mode
	{ "ts/g3kbswitch.nvim", dir = "/home/tserge/backup/configs/nvim/g3kbswitch.nvim", dev = true, config = true },

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
}
