-- gitsigns.nvim：在行号列显示 Git 变更标记（新增/修改/删除），支持 hunk 预览和暂存
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
