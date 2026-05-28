-- which-key.nvim：按键提示弹窗，输入前缀键后自动显示所有可用的后续按键及其说明
return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "显示当前缓冲区键位",
		},
	},
	opts = {
		preset = "modern",
		delay = function(ctx)
			return ctx.plugin and 0 or 120
		end,
		notify = false,
		sort = { "local", "order", "group", "alphanum", "mod" },
		expand = 1,
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			wo = {
				winblend = 0,
			},
		},
		layout = {
			width = { min = 24, max = 56 },
			spacing = 4,
		},
		icons = {
			breadcrumb = "»",
			separator = "→",
			group = "+",
			ellipsis = "…",
		},
		spec = {
			{ "<leader>a", group = "AI 智能" },
			{ "<leader>c", group = "代码 / Codex" },
			{ "<leader>d", group = "调试 / 诊断" },
			{ "<leader>e", group = "文件树" },
			{ "<leader>f", group = "查找" },
			{ "<leader>g", group = "Git 协作" },
			{ "<leader>m", group = "修改 / 大小写" },
			{ "<leader>n", group = "测试" },
			{ "<leader>r", group = "LSP / 运行" },
			{ "<leader>t", group = "终端" },
			{ "<leader>th", desc = "主题管理器" },
			{ "<leader>u", group = "界面 / UI" },
			{ "<leader>x", group = "纠错 (Trouble)" },
			{ "<leader><leader>", group = "插入 / 选择器" },
			{ "[", group = "上一个" },
			{ "]", group = "下一个" },
			{ "g", group = "跳转" },
			{ "z", group = "折叠" },
		},
	},
}
