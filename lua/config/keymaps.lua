-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Modes
--   normal_mode = "n", command_mode = "c",
--   insert_mode = "i", term_mode = "t",
--   visual_mode = "v", visual_block_mode = "x",  CTRL-V

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end
-- Some std keymappings
-- Ctrl-a	Increment object (number) under cursor
-- Ctrl-x	Decrement object (number) under cursor

-- delete without yanking
map({ "n", "v" }, "<M-d>", '"_d', { desc = "Delete selection without yanking" })
map({ "n", "v" }, "<M-c>", '"_c', { desc = "Change selection without yanking" })
map({ "n", "v" }, "<M-d>", '"_x', { desc = "Delete symbol without yanking" })

-- replace currently selected text with default register without yanking it
map("v", "<leader>p", '"_dP', { desc = "Replace selections by clipboard content" })

-- insert_mode
-- <C-h> Delete previous char
-- <C-w> Delete previous word
-- <C-u> Delete to start of line
-- <C-j> Insert new line
-- map("i", "<C-d>", "<C-o>x", { desc = "Delete next char" })
map("i", "<M-d>", "<C-o>dw", { desc = "Delete next word" })
-- map( "i", "<M-D>", '<C-o><S-D)', { desc = "Delete to end of line"})

-- Стрелочки откл. Использовать hjkl
-- map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
-- map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
-- map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
-- map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})
