-- themery.nvim：主题管理插件，提供可视化界面预览和切换主题，并支持持久化保存
return {
	"zaldih/themery.nvim",
	lazy = false,
	dependencies = {
		-- 确保所有想要管理的主题都已安装
		"catppuccin/nvim",
		"bluz71/vim-nightfly-guicolors",
		"folke/tokyonight.nvim",
		"ellisonleao/gruvbox.nvim",
	},
	config = function()
		require("themery").setup({
			themes = {
				-- 在此处列出你想管理的主题名称
				"nightfly",
				{
					name = "Catppuccin Latte",
					colorscheme = "catppuccin-latte",
				},
				{
					name = "Catppuccin Frappe",
					colorscheme = "catppuccin-frappe",
				},
				{
					name = "Catppuccin Macchiato",
					colorscheme = "catppuccin-macchiato",
				},
				{
					name = "Catppuccin Mocha",
					colorscheme = "catppuccin-mocha",
				},
				{
					name = "Tokyo Night",
					colorscheme = "tokyonight",
				},
				{
					name = "Tokyo Night Storm",
					colorscheme = "tokyonight-storm",
				},
				{
					name = "Tokyo Night Moon",
					colorscheme = "tokyonight-moon",
				},
				{
					name = "Gruvbox",
					colorscheme = "gruvbox",
				},
			},
			livePreview = true, -- 开启实时预览
		})
	end,
}
