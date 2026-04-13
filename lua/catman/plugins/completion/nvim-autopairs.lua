-- nvim-autopairs：自动补全括号、引号等成对符号，使用 treesitter 降低误补全
return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- 启用 treesitter 检查
			ts_config = {
				lua = { "string" }, -- Lua 字符串节点内不自动补全括号
				javascript = { "template_string" }, -- JS 模板字符串内不补全
				java = false, -- Java 不检查 treesitter
			},
		})
	end,
}
