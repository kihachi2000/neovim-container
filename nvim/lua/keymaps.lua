-- キーコンフィグ
local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

keymap("x", "j", "gj", opts)
keymap("x", "k", "gk", opts)
keymap("x", "H", "^", opts)
keymap("x", "L", "$", opts)

keymap("n", "<", "<h", opts)
keymap("n", ">", ">l", opts)
keymap("n", "p", "p`]", opts)
keymap("n", "yy", "yy`]", opts)
keymap("n", "J", "3<C-e>", opts)
keymap("n", "K", "3<C-y>", opts)

keymap("n", "<leader>bb", "<cmd>b#<CR>", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-,>", "<C-w><", opts)
keymap("n", "<C-.>", "<C-w>>", opts)
keymap("n", "<C-=>", "<C-w>=", opts)

keymap("n", "?", "<cmd>noh<CR>", opts)

keymap("v", "y", "y`]", opts)

keymap("n", "<leader>r", "<cmd>TSHighlightCapturesUnderCursor<CR>", opts)

keymap("t", "<ESC>", "<C-\\><C-n>", opts)
