-- Comment.nvim：智能代码注释，支持行注释、块注释，配合 treesitter 处理 JSX/TSX 等混合语言
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- 引入 Comment 插件
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- 启用注释
		comment.setup({
			-- 用于 tsx、jsx 等文件的正确注释格式
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
