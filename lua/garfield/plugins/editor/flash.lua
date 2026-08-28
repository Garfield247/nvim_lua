-- flash.nvim：极速光标定位与代码块选择插件（替代传统 easymotion / hop，绝不抢占大写 S 保存按键）
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		modes = {
			char = {
				enabled = false, -- 禁用对单字符 f, t, F, T 的自动拦截，完全保留 Vim 原生基础移动习惯
			},
		},
	},
	-- 快捷键设置
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash 极速光标跳转（输入字符 + 浮动标签字母秒级直达）",
		},
		{
			"<leader>st",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter 语法树区域结构选择",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash（在 Operator 模式下对远端目标执行操作）",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search 语法树正则搜索定位",
		},
	},
}
