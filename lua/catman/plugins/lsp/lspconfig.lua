-- nvim-lspconfig：Neovim 内置 LSP 客户端的配置框架，管理各语言服务器的启动和能力配置
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "显示引用"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "?", vim.lsp.buf.hover, opts)
			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- 诊断图标
		local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- 注册 on_attach 到所有 LSP 客户端
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client then
					on_attach(client, args.buf)
				end
			end,
		})

		-- 各服务器配置
		vim.lsp.config("html", { capabilities = capabilities })
		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.config("cssls", { capabilities = capabilities })
		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
			filetypes = {
				"html",
				"css",
				"scss",
				"less",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
				"markdown",
			},
		})
		vim.lsp.config("prismals", { capabilities = capabilities })

		vim.lsp.config("graphql", {
			capabilities = capabilities,
			filetypes = { "graphql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		vim.lsp.config("svelte", {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
				pyright = { autoImportCompletion = true },
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "off",
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod" },
			capabilities = capabilities,
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					experimentalPostfixCompletions = true,
					analyses = {
						unusedparams = true,
						shadow = true,
						ST1000 = false,
						ST1003 = false,
						ST1020 = false,
						ST1021 = false,
						ST1022 = false,
					},
					staticcheck = true,
				},
			},
			init_options = { usePlaceholders = true },
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- 启用所有已配置的服务器
		vim.lsp.enable({
			"html",
			"ts_ls",
			"cssls",
			"tailwindcss",
			"prismals",
			"graphql",
			"emmet_ls",
			"svelte",
			"pyright",
			"gopls",
			"lua_ls",
		})
	end,
}
