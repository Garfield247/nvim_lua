-- mason.nvim：LSP 服务器、格式化工具、linter、DAP 工具的统一安装器
return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		local lsp_servers = {
			"rust_analyzer",
			"ts_ls",
			"html",
			"cssls",
			"lua_ls",
			"emmet_ls",
			"pyright",
			"gopls",
			"tailwindcss",
			"prismals",
			"graphql",
			"svelte",
		}

		local mason_packages_by_lsp_server = {
			rust_analyzer = "rust-analyzer",
			ts_ls = "typescript-language-server",
			html = "html-lsp",
			cssls = "css-lsp",
			lua_ls = "lua-language-server",
			emmet_ls = "emmet-ls",
			pyright = "pyright",
			gopls = "gopls",
			tailwindcss = "tailwindcss-language-server",
			prismals = "prisma-language-server",
			graphql = "graphql-language-service-cli",
			svelte = "svelte-language-server",
		}

		local extra_tools = {
			"prettier",
			"stylua",
			"isort",
			"black",
			"gofumpt",
			"goimports",
			"gomodifytags",
			"gotests",
			"iferr",
			"impl",
			"debugpy",
			"delve",
		}

		local ensure_installed = {}
		local seen = {}
		local lsp_packages = vim.tbl_map(function(server)
			return mason_packages_by_lsp_server[server] or server
		end, lsp_servers)

		for _, package in ipairs(vim.list_extend(lsp_packages, extra_tools)) do
			if not seen[package] then
				seen[package] = true
				table.insert(ensure_installed, package)
			end
		end

		mason.setup({
			PATH = "append",
			max_concurrent_installers = 4,
			ui = {
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed,
			run_on_start = true,
			debounce_hours = 12,
		})
	end,
}
