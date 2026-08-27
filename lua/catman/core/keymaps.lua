-- 设置 leader 键
vim.g.mapleader = " "

local keymap = vim.keymap

local function reload_nvim_config()
	for name, _ in pairs(package.loaded) do
		if name:match("^catman") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.fn.stdpath("config") .. "/init.lua")
	vim.notify("Neovim config reloaded", vim.log.levels.INFO, { title = "nvim" })
end

---------------------
-- 通用键位映射
---------------------

-- keymap.set({模式}, {按键}, {动作}, {选项})
keymap.set("n", "s", "<nop>", { noremap = true, desc = "禁用 s 键" })
keymap.set("n", "S", ":w<CR>", { desc = "保存当前文件" })
keymap.set("n", "Q", ":q<CR>", { desc = "关闭当前文件" })

-- 分屏
-- 分屏快捷键
keymap.set("n", "sl", ":set splitright<CR>:vsplit<CR>", { desc = "split  ┣" })
keymap.set("n", "sh", ":set nosplitright<CR>:vsplit<CR>", { desc = "split  ┫" })
keymap.set("n", "sj", ":set splitbelow<CR>:split<CR>", { desc = "split  ┻" })
keymap.set("n", "sk", ":set nosplitbelow<CR>:split<CR>", { desc = "split ┳" })
-- 在分屏间移动光标
keymap.set("n", "<C-H>", "<C-w>h", { desc = "光标移至左侧窗口" })
keymap.set("n", "<C-J>", "<C-w>j", { desc = "光标移至下方窗口" })
keymap.set("n", "<C-K>", "<C-w>k", { desc = "光标移至上方窗口" })
keymap.set("n", "<C-L>", "<C-w>l", { desc = "光标移至右侧窗口" })
-- 分屏中调整上下 右布局
keymap.set("n", "<LEADER>sv", "<C-w>t<C-w>H", { desc = "-- split to |" })
keymap.set("n", "<LEADER>sh", "<C-w>t<C-w>K", { desc = "| split to -- " })
-- 移动分屏
keymap.set("n", "<LEADER>H", "<C-w>H", { desc = "窗口移至左侧" })
keymap.set("n", "<LEADER>J", "<C-w>J", { desc = "窗口移至下方" })
keymap.set("n", "<LEADER>K", "<C-w>K", { desc = "窗口移至上方" })
keymap.set("n", "<LEADER>L", "<C-w>L", { desc = "窗口移至右侧" })
-- 互换分屏位置
keymap.set("n", "<LEADER>[", "<C-w>r", { desc = "轮换窗口" })
keymap.set("n", "<LEADER>]", "<C-w>R", { desc = "反向轮换窗口" })
-- 调整分屏窗口大小
keymap.set("n", "<C-up>", ":res +5<CR>", { desc = "增加窗口高度" })
keymap.set("n", "<C-down>", ":res -5<CR>", { desc = "减少窗口高度" })
keymap.set("n", "<C-left>", ":vertical resize-5<CR>", { desc = "减少窗口宽度" })
keymap.set("n", "<C-right>", ":vertical resize+5<CR>", { desc = "增加窗口宽度" })
-- 标签页
keymap.set("n", "<LEADER>tn", ":tabe<CR>", { desc = "新建标签页" })
keymap.set("n", "<LEADER>th", ":-tabnext<CR>", { desc = "上一个标签页" })
keymap.set("n", "<LEADER>tl", ":+tabnext<CR>", { desc = "下一个标签页" })
-- 缓冲区
keymap.set("n", "<LEADER>bl", ":BufferNext<CR>", { desc = "下一个缓冲区" })
keymap.set("n", "<LEADER>bh", ":BufferPrevious<CR>", { desc = "上一个缓冲区" })
-- 快速翻页（用 JK 翻页并居中，禁用原生 J 合并行、K 查文档）
keymap.set("n", "J", "10jzz", { desc = "下移10行并居中" })
keymap.set("n", "K", "10kzz", { desc = "上移10行并居中" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "下翻半页并居中" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "上翻半页并居中" })

-- 取消检索高亮
keymap.set("n", "=", "Nzz", { desc = "上一个搜索结果" })
keymap.set("n", "-", "nzz", { desc = "下一个搜索结果" })
keymap.set("n", "<LEADER><CR>", ":nohlsearch<CR>", { desc = "清除搜索高亮" })
keymap.set("n", "<LEADER>rr", reload_nvim_config, { desc = "重载 Neovim 配置" })
----------------------
-- 插件键位
----------------------
keymap.set("n", "<LEADER>vb", ":ViewInBrowser<CR>", { desc = "在浏览器中打开" })

----------------------
-- 命令行模式 (Cmdline / Wildmenu) 补全键位
----------------------
keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true, desc = "命令行补全选择下一个" })
keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true, desc = "命令行补全选择上一个" })
