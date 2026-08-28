-- mini.nvim：用统一、轻量的模块替代 surround / comment / cursorword 三类编辑增强插件
return {
	"nvim-mini/mini.nvim",
	version = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "ys",
				delete = "ds",
				find = "",
				find_left = "",
				highlight = "",
				replace = "cs",
				suffix_last = "",
				suffix_next = "",
			},
			search_method = "cover",
		})

		require("mini.comment").setup()

		require("mini.cursorword").setup({
			delay = 1000,
		})

		vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
		vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true })
	end,
}
