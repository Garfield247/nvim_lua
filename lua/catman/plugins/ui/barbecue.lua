-- barbecue.nvim：基于 nvim-navic 的 winbar 面包屑导航，显示当前光标所在的代码路径
return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- 显示在 winbar（每个窗口顶部），不影响 tabline 的 barbar
		show_navic = true,
		show_dirname = true,
		show_basename = true,
		-- nvim-tree 侧边栏不显示面包屑
		exclude_filetypes = { "NvimTree", "toggleterm", "dashboard", "alpha" },
		-- 路径分隔符
		separator = "  ",
	},
}
