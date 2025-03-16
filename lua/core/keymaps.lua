-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local options = { silent = true }


-- Save file
keymap.set("n", "<leader>ss", ":w<CR>")

-- Tab
keymap.set("n", "<Tab>", ":><CR>", options)
keymap.set("n", "<S-Tab>", ":<<CR>", options)
keymap.set("v", "<S-Tab>", "<gv", options)
keymap.set("v", "<Tab>", ">gv", options)

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", options)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", options)

-- delete single character without copying into register
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set("n", "X", 'V"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- diagnostic
keymap.set("n", "<leader>ds", vim.diagnostic.open_float)
keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
