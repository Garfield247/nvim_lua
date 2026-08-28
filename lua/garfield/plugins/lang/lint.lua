-- nvim-lint：独立、异步高性能代码 Lint 检查框架（替代已停护的 null-ls / nvim-diagnostics）
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave" }, -- 触发懒加载的标准事件列表
	config = function()
		local lint = require("lint")

		-- 根据不同编程语言文件类型配置专用的 Linting 校验工具
		lint.linters_by_ft = {
			python = { "ruff" }, -- Python 优先使用极速的 ruff 校验
			go = { "golangci-lint" }, -- Go 使用官方推荐的 golangci-lint 聚合校验
		}

		-- 自动命令组：在进入文件、保存文件或退出插入模式时异步触发校验
		local lint_augroup = vim.api.nvim_create_augroup("GarfieldNvimLint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- 使用 pcall 优雅封装，当系统/环境缺失某二进制工具时自动降级静默，绝对不阻断用户编辑
				pcall(lint.try_lint)
			end,
		})
	end,
}
