-- which-key.nvim：按键提示弹窗，输入前缀键后自动显示所有可用的后续按键及其说明
return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 2
	end,
	opts = {
		-- 在此填写配置，或留空使用默认
		-- 详见插件文档的配置说明
	},
}
