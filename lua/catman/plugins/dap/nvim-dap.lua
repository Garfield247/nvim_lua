-- nvim-dap：Debug Adapter Protocol 核心框架，断点、单步、变量查看等调试功能
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{ "<Leader>db", function() require("dap").toggle_breakpoint() end,                   desc = "切换断点" },
		{ "<Leader>dB", function() require("dap").set_breakpoint(vim.fn.input("条件: ")) end, desc = "条件断点" },
		{ "<Leader>dc", function() require("dap").continue() end,                            desc = "继续/启动调试" },
		{ "<Leader>dn", function() require("dap").step_over() end,                           desc = "单步跳过" },
		{ "<Leader>di", function() require("dap").step_into() end,                           desc = "单步进入" },
		{ "<Leader>do", function() require("dap").step_out() end,                            desc = "单步跳出" },
		{ "<Leader>dq", function() require("dap").terminate() end,                           desc = "终止调试" },
		{ "<Leader>dr", function() require("dap").repl.toggle() end,                         desc = "切换 REPL" },
		{ "<Leader>dl", function() require("dap").run_last() end,                            desc = "重新运行上次" },
		{ "<Leader>dt", function() require("dapui").toggle() end,                            desc = "切换 DAP UI" },
		{ "<Leader>de", function() require("dapui").eval() end,                              desc = "求值表达式", mode = { "n", "v" } },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- 断点图标
		vim.fn.sign_define("DapBreakpoint",          { text = "⏺", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "⏺", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapBreakpointRejected",  { text = "⏺", texthl = "DiagnosticHint" })
		vim.fn.sign_define("DapLogPoint",            { text = "◆", texthl = "DiagnosticInfo" })
		vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })

		-- 调试开始/结束时自动开关 UI
		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end
	end,
}
