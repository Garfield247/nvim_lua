-- nvim-dap-ui：DAP 调试界面，提供变量、堆栈、断点、控制台等面板
return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("dapui").setup({
			layouts = {
				{
					elements = {
						{ id = "scopes",      size = 0.4 },
						{ id = "breakpoints", size = 0.2 },
						{ id = "stacks",      size = 0.2 },
						{ id = "watches",     size = 0.2 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl",    size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 12,
					position = "bottom",
				},
			},
		})
	end,
}
