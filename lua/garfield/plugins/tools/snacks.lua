-- snacks.nvim：Folke 开发的全能型超级轻量 UI 框架与核心辅助工具箱
return {
	"folke/snacks.nvim",
	priority = 1000, -- 最高优先级，确保在启动序列早期加载以接管 UI 基础设施
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true }, -- 超大文件保护机制
		dashboard = {
			enabled = true,
			preset = {
				-- 招牌猫咪与 Neovim 组合 ASCII Header
				header = [[
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
||    ______               __      __       __                             ||
||   /   󰄛  |             /󰄛 |    /󰄛 |     /󰄛 |                            ||
||  /$$$$$$  |  ______   _$$ |_   $$  |   /$$ |  ______   _______          ||
||  $$ |  $$/  /   󰄛  | / $$   |  $$$  | /$$$ | /   󰄛  | /  󰄛    |         ||
||  $$ |       $$$$$$  |$$$$$$/   $$$$  /$$$$ | $$$$$$  |$$$$$$$  |        ||
||  $$ |   __  /    $$ |  $$ | __ $$ $$ $$/$$ | /    $$ |$$ |  $$ |        ||
||  $$ |__/  |/$$$$$$$ |  $$ |/  |$$ |$$$/ $$ |/$$$$$$$ |$$ |  $$ |        ||
||  $$  󰄛 $$/ $$    $$ |  $$  $$/ $$ | $/  $$ |$$    $$ |$$ |  $$ |        ||
||   $$$$$$/   $$$$$$$/    $$$$/  $$/      $$/  $$$$$$$/ $$/   $$/         ||
||                                                                         ||
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
||                                                                         ||
||                     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ||
||                      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ||
||                      ██╔██╗ ██║█████╗  ██║ 󰄛 ██║██║   ██║██║██╔████╔██║ ||
||                      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ||
||                      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ||
||                      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ||
||                                                                         ||
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
]],
				-- 启动页中文快捷操作选项
				keys = {
					{ icon = " ", key = "f", desc = "查找文件", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "新建空白缓冲区", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "全局搜索字符串",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "最近打开历史文件",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "打开 Neovim 配置文件",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "恢复上次会话", section = "session" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy 插件管理", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "退出 Neovim", action = ":qa" },
				},
			},
		},
		indent = { enabled = true }, -- 缩进参考线高亮
		input = { enabled = true }, -- 接入原生的 vim.ui.input 输入弹窗 UI
		notifier = { enabled = true, timeout = 3000 }, -- 现代化右下角 Notification 通知弹窗
		quickfile = { enabled = true }, -- 极速渲染空缓冲区与只读文件
		scroll = { enabled = true }, -- 平滑滚动动画
		statuscolumn = { enabled = true }, -- 整合的左侧状态列
		words = { enabled = true }, -- 自动高亮当前光标下相同的单词标记
	},
	-- 快捷键设置
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "查看历史 Notification 通知记录 (Snacks)",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "关闭并隐藏当前所有的通知弹窗 (Snacks)",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "在浏览器中直接打开当前文件的 Git 仓位置 (Snacks)",
		},
	},
}
