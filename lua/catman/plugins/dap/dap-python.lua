-- nvim-dap-python：Python 语言调试适配器，基于 debugpy，支持本地和远程调试
return {
	"mfussenegger/nvim-dap-python",
	ft = { "python" },
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		-- 优先使用 mason 安装的 debugpy，否则回退到系统 python
		local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3"
		if vim.fn.executable(debugpy_path) == 0 then
			debugpy_path = vim.fn.exepath("python3") or "python3"
		end
		require("dap-python").setup(debugpy_path)

		-- 补充调试配置
		local dap = require("dap")
		dap.configurations.python = vim.list_extend(dap.configurations.python or {}, {
			{
				type    = "python",
				request = "launch",
				name    = "Debug 当前文件",
				program = "${file}",
				justMyCode = false,          -- 允许进入第三方库
				console = "integratedTerminal",
			},
			{
				type    = "python",
				request = "launch",
				name    = "Debug 带参数",
				program = "${file}",
				args    = function()
					return vim.split(vim.fn.input("参数: "), " ")
				end,
				justMyCode = false,
				console = "integratedTerminal",
			},
			{
				type    = "python",
				request = "attach",
				name    = "Attach 远程进程",
				connect = function()
					local host = vim.fn.input("Host (默认 127.0.0.1): ")
					local port = vim.fn.input("Port (默认 5678): ")
					return {
						host = host ~= "" and host or "127.0.0.1",
						port = tonumber(port) or 5678,
					}
				end,
			},
		})
	end,
}
