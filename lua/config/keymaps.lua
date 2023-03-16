-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",  CTRL-V
--   term_mode = "t",
--   command_mode = "c",

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
-- insert_mode
-- <C-h> Delete previous char
-- <C-w> Delete previous word
-- <C-u> Delete to start of line
-- <C-j> Insert new line
-- map("i", "<C-d>", "<C-o>x", { desc = "Delete next char" })
map("i", "<M-d>", "<C-o>dw", { desc = "Delete next word" })
-- map( "i", "<M-D>", '<C-o><S-D)', { desc = "Delete to end of line"})

-- delete without yanking
map({ "n", "v" }, "<M-d>", '"_d', { desc = "Delete selection without yanking" })
map({ "n", "v" }, "<M-c>", '"_c', { desc = "Change selection without yanking" })
map({ "n", "v" }, "<M-d>", '"_x', { desc = "Delete symbol without yanking" })
-- replace currently selected text with default register without yanking it
map("v", "<leader>p", '"_dP', { desc = "Replace currently selected text with default register without yanking it" })
