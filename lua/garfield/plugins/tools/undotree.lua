-- undotree：可视化撤销历史树，支持在分支间跳转恢复任意历史状态
return {
	"mbbill/undotree",
	lazy = false,
	cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
	keys = {
		{ "<leader>uu", "<cmd> UndotreeToggle<CR>", desc = "Undo Tree" },
	},
	config = function()
		vim.cmd([[
      set undofile
      set undodir=~/.cache/undodir

    ]])
	end,
}
