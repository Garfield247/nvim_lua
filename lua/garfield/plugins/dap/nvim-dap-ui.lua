-- nvim-dap-ui：DAP 调试界面，提供变量、堆栈、断点、控制台等面板
return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
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

		-- 只在 dap-ui 成功加载后注册监听，避免缺依赖时把 nvim 启动直接打断
		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
	end,
}
