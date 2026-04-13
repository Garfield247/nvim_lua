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
			{ "<leader>a", group = "AI" },
			{ "<leader>c", group = "Code / Codex" },
			{ "<leader>d", group = "Debug / Diagnostic" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>m", group = "Modify" },
			{ "<leader>n", group = "Test" },
			{ "<leader>r", group = "LSP / Run" },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>u", group = "Undo / UI" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader><leader>", group = "Insert / Picker" },
			{ "[", group = "Prev" },
			{ "]", group = "Next" },
			{ "g", group = "Goto" },
			{ "z", group = "Fold" },
		},
	},
}
