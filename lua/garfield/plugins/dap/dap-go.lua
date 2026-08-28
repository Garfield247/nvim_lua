-- nvim-dap-go：Go 语言调试适配器，基于 delve，支持普通调试、测试调试和进程 attach
return {
	"leoluz/nvim-dap-go",
	ft = { "go" },
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		local delve_path = vim.fn.stdpath("data") .. "/mason/bin/dlv"
		if vim.fn.executable(delve_path) == 0 then
			delve_path = vim.fn.exepath("dlv") or "dlv"
		end

		require("dap-go").setup({
			dap_configurations = {
				{
					type    = "go",
					name    = "Debug 当前文件",
					request = "launch",
					program = "${file}",
				},
				{
					type    = "go",
					name    = "Debug 当前包",
					request = "launch",
					program = "${fileDirname}",
				},
				{
					type    = "go",
					name    = "Debug 测试文件",
					request = "launch",
					mode    = "test",
					program = "${file}",
				},
				{
					type      = "go",
					name      = "Attach 进程",
					request   = "attach",
					mode      = "local",
					processId = require("dap.utils").pick_process,
				},
			},
			delve = {
				path                   = delve_path,
				initialize_timeout_sec = 20,
				port                   = "${port}",
				args                   = {},
				build_flags            = "",
			},
		})
	end,
}
