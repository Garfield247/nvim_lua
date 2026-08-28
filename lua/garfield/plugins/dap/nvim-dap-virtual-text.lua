-- nvim-dap-virtual-text：调试时在代码行内以虚拟文本形式显示变量当前值
return {
	"theHamsta/nvim-dap-virtual-text",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({
			enabled = true,
			commented = true,                    -- 变量值以注释形式显示
			highlight_changed_variables = true,  -- 高亮变化的变量
			show_stop_reason = true,             -- 显示暂停原因
		})
	end,
}
