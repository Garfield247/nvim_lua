-- fzf-lua：极速、原生的模糊查找引擎（替换 Telescope）
return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "FzfLua",
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "模糊查找当前目录文件 (fzf-lua)",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "最近打开的文件 (fzf-lua)",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "在当前目录搜索字符串 (fzf-lua)",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "搜索光标下字符串 (fzf-lua)",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "查找缓冲区 (fzf-lua)",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "查找 Git 跟踪文件 (fzf-lua)",
		},
	},
	opts = {
		winopts = {
			height = 0.85,
			width = 0.80,
			row = 0.35,
			col = 0.50,
			border = "rounded",
			preview = {
				layout = "flex",
				flip_columns = 120,
			},
		},
		keymap = {
			builtin = {
				["<C-d>"] = "preview-page-down",
				["<C-u>"] = "preview-page-up",
			},
			fzf = {
				["ctrl-q"] = "select-all+accept",
			},
		},
		files = {
			prompt = "Files> ",
			multiprocess = true,
			git_icons = true,
			file_icons = true,
			color_icons = true,
		},
		grep = {
			prompt = "Grep> ",
			input_prompt = "Grep For> ",
			multiprocess = true,
			git_icons = true,
			file_icons = true,
			color_icons = true,
		},
	},
}
