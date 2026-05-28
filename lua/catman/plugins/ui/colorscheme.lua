-- vim-nightfly-guicolors 等：备用配色方案集合，当前启用 nightfly 深色主题
return {
	{
		"bluz71/vim-nightfly-guicolors",
		priority = 1000, -- 确保在其他启动插件之前加载
		config = function()
			-- 在此加载配色方案
			vim.cmd([[colorscheme nightfly]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
