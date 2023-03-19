-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for xml files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "xml" },
	callback = function()
		vim.b.autoformat = false
	end,
})

-- проверить
-- Подсвечивает на доли секунды скопированную часть текста
-- vim.api.nvim_exec([[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
--   augroup end
-- ]], false)
