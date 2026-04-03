-- toggleterm.nvim：在 Neovim 内管理多个终端实例，支持浮窗、分屏、标签页等多种布局
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-\\>", desc = "切换终端" },
		{ "<Leader>tf", desc = "浮窗终端" },
		{ "<Leader>th", desc = "水平分屏终端" },
		{ "<Leader>tv", desc = "垂直分屏终端" },
		{ "<Leader>tg", desc = "LazyGit 终端" },
		{ "<Leader>tr", desc = "运行当前文件" },
	},
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,   -- <C-\> 在插入模式也生效
			persist_size = true,
			direction = "float",      -- 默认浮窗
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal

		-- 浮窗终端
		local float_term = Terminal:new({ direction = "float", hidden = true })
		-- 水平终端
		local horizontal_term = Terminal:new({ direction = "horizontal", hidden = true })
		-- 垂直终端
		local vertical_term = Terminal:new({ direction = "vertical", hidden = true })

		-- lazygit 专用终端
		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			hidden = true,
			float_opts = { border = "curved" },
			on_open = function(term)
				vim.cmd("startinsert!")
				-- 在 lazygit 里按 q 关闭
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		-- 运行当前文件（根据文件类型自动选择命令）
		local function run_file()
			local ft = vim.bo.filetype
			local file = vim.fn.expand("%:p")
			local cmd

			if ft == "go" then
				cmd = "go run " .. vim.fn.expand("%:p:h") .. "/..."
			elseif ft == "python" then
				cmd = "python3 " .. file
			elseif ft == "lua" then
				cmd = "lua " .. file
			elseif ft == "sh" or ft == "bash" then
				cmd = "bash " .. file
			elseif ft == "javascript" or ft == "typescript" then
				cmd = "node " .. file
			else
				vim.notify("不支持的文件类型: " .. ft, vim.log.levels.WARN)
				return
			end

			local run_term = Terminal:new({
				cmd = cmd,
				direction = "horizontal",
				close_on_exit = false,  -- 运行结束后保留输出
				hidden = true,
			})
			run_term:toggle()
		end

		-- 快捷键
		local keymap = vim.keymap
		keymap.set({ "n", "t" }, "<Leader>tf", function() float_term:toggle() end,      { desc = "浮窗终端" })
		keymap.set({ "n", "t" }, "<Leader>th", function() horizontal_term:toggle() end, { desc = "水平分屏终端" })
		keymap.set({ "n", "t" }, "<Leader>tv", function() vertical_term:toggle() end,   { desc = "垂直分屏终端" })
		keymap.set({ "n", "t" }, "<Leader>tg", function() lazygit:toggle() end,         { desc = "LazyGit 终端" })
		keymap.set("n",          "<Leader>tr", run_file,                                { desc = "运行当前文件" })

		-- 终端模式下用 <Esc> 退回普通模式
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				local opts = { buffer = 0, silent = true }
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
				vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
				vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
				vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
			end,
		})
	end,
}
