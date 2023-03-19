-- see <https://github.com/folke/dot/blob/master/nvim/lua/plugins/editor.lua>
return {
	-- add folding range to capabilities
	{
		"neovim/nvim-lspconfig",
		opts = {
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
		},
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		config = true,
		init = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		end,
	},

	-- By default h and l keys are used. On first press of h key, when cursor is on a closed fold, the preview will be shown.
	-- On second press the preview will be closed and fold will be opened. When preview is opened, the l key will close it
	-- and open fold. In all other cases theese keys will work as usual.
	-- {
	-- 	"anuvyklack/fold-preview.nvim",
	-- 	event = "VeryLazy",
	-- 	-- lazy = true,
	-- 	dependencies = { "anuvyklack/keymap-amend.nvim" },
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			pattern = { "*" },
	-- 			callback = function()
	-- 				if not vim.bo.ft == "alpha" then
	-- 					require("lazy").load({ plugins = { "fold-preview.lua" } })
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
