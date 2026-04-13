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
		for _, package in ipairs(vim.list_extend(vim.deepcopy(lsp_servers), extra_tools)) do
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
