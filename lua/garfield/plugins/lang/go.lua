-- go.nvim：Go 语言开发增强，提供 goimport、测试运行、代码生成等一站式 Go 工具集
return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local setup, go = pcall(require, "go")
		if not setup then
			return
		end

		-- 格式化统一由 conform.nvim 处理，此处保持 setup 即可
		-- enable go
		go.setup({
			lsp_cfg = false,      -- 由 lspconfig.lua 统一管理 gopls，避免冲突
			lsp_gofumpt = false,  -- 格式化由 conform.nvim 处理
			lsp_codelens = false, -- go.nvim 目前调用了 0.11.3 不存在的 vim.lsp.codelens.enable()，先关闭避免报错
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod", "api" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
