-- boole.nvim：增强 <C-a>/<C-x> 的递增/递减功能，支持布尔值、自定义词组循环切换
return {
	"nat-418/boole.nvim",
	config = function()
		require("boole").setup({
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
			-- User defined loops
			additions = {
				{ "Foo", "Bar" },
				{ "tic", "tac", "toe" },
			},
			allow_caps_additions = {
				{ "enable", "disable" },
				-- enable → disable
				-- Enable → Disable
				-- ENABLE → DISABLE
			},
		})
	end,
}
