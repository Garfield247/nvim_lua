-- rainbow-delimiters.nvim：彩虹括号，用不同颜色区分嵌套的括号、方括号和花括号层级
return {
	"hiphish/rainbow-delimiters.nvim",
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")
		vim.g.rainbow_delimiters = {
			condition = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return false
				end

				local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
				return ok and parser ~= nil
			end,
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}
	end,
}
