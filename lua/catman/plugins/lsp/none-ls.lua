return {
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	lazy = true,
	-- event = { "BufReadPre", "BufNewFile" }, -- 启用时取消注释
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")

		local null_ls = require("null-ls")

		local null_ls_utils = require("null-ls.utils")

		mason_null_ls.setup({
			ensure_installed = {
				"prettier", -- 前端格式化
				"stylua", -- Lua 格式化
				"black", -- Python 格式化
				"pyright", -- Python 检查
				"eslint_d", -- JS 检查
				"gofumpt",
				"goimports_reviser",
			},
		})

		local formatting = null_ls.builtins.formatting -- 格式化
		local diagnostics = null_ls.builtins.diagnostics -- 诊断/检查

		-- 保存时格式化
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- 配置 null_ls
		null_ls.setup({
			-- 将 package.json 等作为根目录标识（适用于 TypeScript 单体仓库）
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			-- 格式化与检查源
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
				}), -- JS/TS 格式化
				formatting.stylua, -- Lua 格式化
				diagnostics.pyright,
				formatting.black,
				-- formatting.gofmt,
				formatting.goimports,
				formatting.gofumpt,
				-- formatting.goimports_reviser,
				diagnostics.eslint_d.with({ -- JS/TS 检查
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- 仅当根目录存在 eslint 配置时启用
					end,
				}),
			},
			-- 保存时格式化
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		})
	end,
}
