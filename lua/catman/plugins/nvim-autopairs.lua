-- nvim-autopairs：自动补全括号、引号等成对符号，与 nvim-cmp 和 treesitter 深度集成
return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		-- 引入 nvim-autopairs
		local autopairs = require("nvim-autopairs")

		-- 配置自动括号
		autopairs.setup({
			check_ts = true, -- 启用 treesitter 检查
			ts_config = {
				lua = { "string" }, -- Lua 字符串节点内不自动补全括号
				javascript = { "template_string" }, -- JS 模板字符串内不补全
				java = false, -- Java 不检查 treesitter
			},
		})

		-- 自动括号与补全联动
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
