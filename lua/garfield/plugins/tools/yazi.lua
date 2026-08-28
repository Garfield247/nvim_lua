-- yazi.nvim：在 Neovim 内嵌入 yazi 终端文件管理器
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "打开 yazi（当前文件所在目录）",
		},
		{
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "打开 yazi（当前工作目录）",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "恢复上次的 yazi 会话",
		},
	},
	opts = {
		-- 不替换 netrw（因为你已经用了 nvim-tree）
		open_for_directories = false,
		-- 浮动窗口配置
		floating_window_scaling_factor = 0.9,
		floating_window_winblend = 0,
		floating_window_border = "rounded",
		-- 按键配置
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			send_to_quickfix_list = "<c-q>",
			cycle_open_buffers = "<tab>",
		},
	},
}

