-- lspkind.nvim：为补全菜单添加类 VS Code 的图标，直观区分函数、变量、类等补全类型
return {
	"onsails/lspkind.nvim",
	config = function()
		require("lspkind").init({
			mode = "symbol_text",
			preset = "codicons",
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰡱",
				Constructor = "",
				Field = "󰜢",
				Variable = "𝑽",
				Class = "󰠱",
				Interface = "",
				Module = "全",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
				Codeium = "",
			},
		})
	end,
}
