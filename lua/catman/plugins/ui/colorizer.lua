-- nvim-colorizer.lua：高性能颜色代码预览，在编辑器内直接显示 #hex、rgb 等颜色
return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
