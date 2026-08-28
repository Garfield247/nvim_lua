-- fzf-lua：异步、高效且基于 C/C++ fzf 算法的原生模糊查找引擎（替换旧版 Telescope）
return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- 提供图标渲染支持
	cmd = "FzfLua",
	-- 按键绑定：完美继承并保留原 Telescope 的全部常用快捷键习惯
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
			desc = "最近打开历史文件列表 (fzf-lua)",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "在全局工作区实时搜索字符串 (fzf-lua)",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "搜索当前光标下的单词 (fzf-lua)",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "查找与切换已打开的缓冲区 (fzf-lua)",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "查找仅被 Git 跟踪的文件 (fzf-lua)",
		},
	},
	-- 界面与交互参数设定
	opts = {
		-- 浮动窗口布局样式设置
		winopts = {
			height = 0.85, -- 占据屏幕高度的 85%
			width = 0.80, -- 占据屏幕宽度的 80%
			row = 0.35,
			col = 0.50,
			border = "rounded", -- 优雅圆角外框
			preview = {
				layout = "flex", -- 响应式预览布局（宽屏右侧预览，窄屏上方预览）
				flip_columns = 120, -- 超过 120 列自动切换为双栏显示
			},
		},
		-- 内置控制按键映射
		keymap = {
			builtin = {
				["<C-d>"] = "preview-page-down", -- Ctrl-d 下翻预览页
				["<C-u>"] = "preview-page-up", -- Ctrl-u 上翻预览页
			},
			fzf = {
				["ctrl-q"] = "select-all+accept", -- Ctrl-q 全选并发送至 Quickfix 列表
			},
		},
		-- 文件查找器预设
		files = {
			prompt = "Files> ",
			multiprocess = true, -- 开启多进程加速大仓库搜索
			git_icons = true,
			file_icons = true,
			color_icons = true,
		},
		-- Grep 全局字符搜索预设
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
