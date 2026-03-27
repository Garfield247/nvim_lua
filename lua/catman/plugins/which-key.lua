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
