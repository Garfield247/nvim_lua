-- neotest：在编辑器内直接运行测试，支持 Go 和 Python，可配合 DAP 调试单个测试
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",       -- Go 适配器
		"nvim-neotest/neotest-python",   -- Python 适配器
	},
	keys = {
		{ "<leader>nt", function() require("neotest").run.run() end,                          desc = "运行最近的测试" },
		{ "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end,        desc = "运行当前文件测试" },
		{ "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end,      desc = "调试最近的测试" },
		{ "<leader>ns", function() require("neotest").run.stop() end,                         desc = "停止测试" },
		{ "<leader>no", function() require("neotest").output.open({ enter = true }) end,      desc = "查看测试输出" },
		{ "<leader>nO", function() require("neotest").output_panel.toggle() end,              desc = "切换输出面板" },
		{ "<leader>nS", function() require("neotest").summary.toggle() end,                   desc = "切换测试概览" },
		-- 在测试间跳转
		{ "[n",         function() require("neotest").jump.prev({ status = "failed" }) end,   desc = "上一个失败测试" },
		{ "]n",         function() require("neotest").jump.next({ status = "failed" }) end,   desc = "下一个失败测试" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- Go 测试适配器
				require("neotest-go")({
					experimental = {
						test_table = true,  -- 支持 table-driven tests
					},
					args = { "-count=1", "-timeout=60s" },
				}),
				-- Python 测试适配器（支持 pytest 和 unittest）
				require("neotest-python")({
					dap = { justMyCode = false },  -- 调试时可进入第三方库
					runner = "pytest",             -- 默认用 pytest，没有时自动回退到 unittest
					python = function()
						-- 优先使用虚拟环境的 python
						local venv = vim.fn.getcwd() .. "/venv/bin/python"
						local venv2 = vim.fn.getcwd() .. "/.venv/bin/python"
						if vim.fn.executable(venv) == 1 then
							return venv
						elseif vim.fn.executable(venv2) == 1 then
							return venv2
						end
						return vim.fn.exepath("python3") or "python3"
					end,
				}),
			},
			-- 测试状态图标
			icons = {
				passed  = "✓",
				failed  = "✗",
				running = "⟳",
				skipped = "○",
				unknown = "?",
			},
			-- 诊断：在代码行内显示测试失败信息
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},
			-- 行号旁显示测试状态标记
			status = {
				enabled = true,
				signs = true,
				virtual_text = false,
			},
			output = {
				enabled = true,
				open_on_run = "short",  -- 只有失败时自动打开输出
			},
			summary = {
				enabled = true,
				animated = true,
				follow = true,          -- 跟随光标高亮对应测试
				expand_errors = true,
			},
		})
	end,
}
