-- set leader key
vim.g.mapleader = " "

local keymap = vim.keymap
---------------------
-- General Keymaps --
---------------------

-- keymap.set({mode}, {lhs}, {rhs}, {opts})
vim.api.nvim_set_keymap("n", "s", "<nop>", { noremap = true })
keymap.set("n", "S", ":w<CR>", { desc = "Save Current File" }) --save current file
keymap.set("n", "Q", ":q<CR>", { desc = "Close Current File" }) --save current file

-- 分屏
-- 分屏快捷键
keymap.set("n", "sl", ":set splitright<CR>:vsplit<CR>", { desc = "split  ┣" })
keymap.set("n", "sh", ":set nosplitright<CR>:vsplit<CR>", { desc = "split  ┫" })
keymap.set("n", "sj", ":set splitbelow<CR>:split<CR>", { desc = "split  ┻" })
keymap.set("n", "sk", ":set nosplitbelow<CR>:split<CR>", { desc = "split ┳" })
-- move cursor
keymap.set("n", "<C-H>", "<C-w>h", { desc = "move cursor  " })
keymap.set("n", "<C-J>", "<C-w>j", { desc = "move cursor  " })
keymap.set("n", "<C-K>", "<C-w>k", { desc = "move cursor  " })
keymap.set("n", "<C-L>", "<C-w>l", { desc = "move cursor  " })
-- 分屏中调整上下 右布局
keymap.set("n", "<LEADER>sv", "<C-w>t<C-w>H", { desc = "-- split to |" })
keymap.set("n", "<LEADER>sh", "<C-w>t<C-w>K", { desc = "| split to -- " })
-- 移动分屏
keymap.set("n", "<LEADER>H", "<C-w>H")
keymap.set("n", "<LEADER>J", "<C-w>J")
keymap.set("n", "<LEADER>K", "<C-w>K")
keymap.set("n", "<LEADER>L", "<C-w>L")
-- 互换分屏位置
keymap.set("n", "<LEADER>[", "<C-w>r")
keymap.set("n", "<LEADER>]", "<C-w>R")
-- 调整分屏窗口大
keymap.set("n", "<C-up>", ":res +5<CR>")
keymap.set("n", "<C-down>", ":res -5<CR>")
keymap.set("n", "<C-left>", ":vertical resize-5<CR>")
keymap.set("n", "<C-right>", ":vertical resize+5<CR>")
-- 标签
keymap.set("n", "<LEADER>tn", ":tabe<CR>")
keymap.set("n", "<LEADER>th", ":-tabnext<CR>")
keymap.set("n", "<LEADER>tl", ":+tabnext<CR>")
-- Buffer
-- keymap.set("n", "<LEADER>bh", ":BufferNext<CR>")
-- keymap.set("n", "<LEADER>bl", ":BufferPrevious<CR>")
-- 快速翻页
keymap.set("n", "J", "10j")
keymap.set("n", "K", "10k")

-- 取消检索高亮
keymap.set("n", "=", "Nzz")
keymap.set("n", "-", "nzz")
keymap.set("n", "<LEADER><CR>", ":nohlsearch<CR>", { desc = "nohlsearch" })
----------------------
-- Plugin Keybinds
----------------------
--
keymap.set("n", "<LEADER>vb", ":call ViewInBrowser()<cr>")
