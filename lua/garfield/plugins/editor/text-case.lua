-- text-case.nvim：快速转换文本大小写格式，支持 camelCase、snake_case、PascalCase 等互转
-- https://github.com/johmsalas/text-case.nvim
return {
	"johmsalas/text-case.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("textcase").setup({})
		require("telescope").load_extension("textcase")
	end,
	keys = {
		"ga", -- Default invocation prefix
		{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
	},
}
