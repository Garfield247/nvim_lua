-- gopher.nvim：Go 语言辅助工具，提供 struct tag 生成、接口实现、错误处理等快捷命令
return {
	"olexsmir/gopher.nvim",
	enabled = true,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("gopher").setup({
			commands = {
				go = "go",
				gomodifytags = "gomodifytags",
				gotests = "gotests",
				impl = "impl",
				iferr = "iferr",
			},
		})
	end,
}
