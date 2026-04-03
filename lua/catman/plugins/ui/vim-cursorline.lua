-- nvim-cursorline：高亮当前行及光标下相同单词，帮助快速定位变量使用位置
return {
	"yamatsum/nvim-cursorline",
	config = true,
	opts = function()
		require("nvim-cursorline").setup({
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
		})
	end,
}
