-- snacks.nvim：全能型轻量 UI 与辅助工具库
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "显示通知历史 (Snacks)",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "关闭所有通知 (Snacks)",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "在浏览器中打开 Git 仓 (Snacks)",
		},
	},
}
