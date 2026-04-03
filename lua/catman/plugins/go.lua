-- go.nvim：Go 语言开发增强，提供 goimport、测试运行、代码生成等一站式 Go 工具集
return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local setup, go = pcall(require, "go")
		if not setup then
			return
		end

		-- -- Run gofmt on save
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	pattern = "*.go",
		-- 	callback = function()
		-- 		require("go.format").gofmt()
		-- 	end,
		-- 	group = format_sync_grp,
		-- })
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})
		-- enable go
		go.setup({
			lsp_cfg = false,     -- 由 lspconfig.lua 统一管理 gopls，避免冲突
			lsp_gofumpt = false, -- 格式化由 conform.nvim 处理
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod", "api" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
