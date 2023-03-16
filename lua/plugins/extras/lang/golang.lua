-- see for example here:
-- * <https://github.com/binary4cat/.config/blob/main/nvim/lua/plugins/coding.lua#L3>
-- * <https://github.com/binary4cat/.config/blob/main/nvim/lua/plugins/lsp.lua#L60>
return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
		},
		opts = {
			setup = {
				codelldb = function()
					-- Install golang specific config
					require("dap-go").setup()
				end,
			},
		},
	},
}
