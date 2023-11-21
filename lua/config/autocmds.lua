-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("ts_" .. name, { clear = true })
end

-- Disable autoformat for xml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("xml_conf"),
  pattern = { "xml" },
  callback = function()
    vim.b.autoformat = false
    vim.opt_local.conceallevel = 2
  end,
})

-- wrap and check for spell in additional text filetypes
-- https://github.com/LazyVim/LazyVim/blob/f9dadc11b39fb0b027473caaab2200b35c9f0c8b/lua/lazyvim/config/autocmds.lua#L72C1-L80C3
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "html" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
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
