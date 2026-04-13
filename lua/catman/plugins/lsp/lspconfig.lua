return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local blink_ok, blink = pcall(require, "blink.cmp")
		if blink_ok then
			capabilities = blink.get_lsp_capabilities(capabilities)
		end
		local svelte_group = vim.api.nvim_create_augroup("CatmanSvelteWatch", { clear = true })
		local lsp_attach_group = vim.api.nvim_create_augroup("CatmanLspAttach", { clear = true })

		local function buf_map(bufnr, mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				noremap = true,
				silent = true,
				desc = desc,
			})
		end

		local function restart_lsp(bufnr)
			vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = bufnr }))
			vim.defer_fn(function()
				vim.cmd.edit()
			end, 100)
		end

		vim.diagnostic.config({
			severity_sort = true,
			float = {
				border = "rounded",
				source = "if_many",
			},
			underline = true,
			virtual_text = {
				spacing = 2,
				source = "if_many",
			},
		})

		for type, icon in pairs({ Error = "", Warn = "", Hint = "󰠠", Info = "" }) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_attach_group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				local ok, telescope_builtin = pcall(require, "telescope.builtin")
				local bufnr = args.buf
				local references = ok and telescope_builtin.lsp_references or vim.lsp.buf.references
				local definitions = ok and telescope_builtin.lsp_definitions or vim.lsp.buf.definition
				local implementations = ok and telescope_builtin.lsp_implementations or vim.lsp.buf.implementation
				local type_definitions = ok and telescope_builtin.lsp_type_definitions or vim.lsp.buf.type_definition
				local diagnostics = ok and function()
					telescope_builtin.diagnostics({ bufnr = 0 })
				end or vim.diagnostic.setloclist

				buf_map(bufnr, "n", "gR", references, "显示引用")
				buf_map(bufnr, "n", "gD", vim.lsp.buf.declaration, "跳转声明")
				buf_map(bufnr, "n", "gd", definitions, "显示定义")
				buf_map(bufnr, "n", "gi", implementations, "显示实现")
				buf_map(bufnr, "n", "gt", type_definitions, "显示类型定义")
				buf_map(bufnr, { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "代码操作")
				buf_map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, "重命名符号")
				buf_map(bufnr, "n", "<leader>D", diagnostics, "显示缓冲区诊断")
				buf_map(bufnr, "n", "<leader>d", vim.diagnostic.open_float, "显示行诊断")
				buf_map(bufnr, "n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "上一条诊断")
				buf_map(bufnr, "n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "下一条诊断")
				buf_map(bufnr, "n", "?", vim.lsp.buf.hover, "悬浮文档")
				buf_map(bufnr, "n", "<leader>rs", function()
					restart_lsp(bufnr)
				end, "重启 LSP")
			end,
		})

		local servers = {
			html = {},
			ts_ls = {},
			cssls = {},
			tailwindcss = {
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
			},
			prismals = {},
			graphql = {
				filetypes = { "graphql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			},
			svelte = {
				on_attach = function(client)
					vim.api.nvim_create_autocmd("BufWritePost", {
						group = svelte_group,
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							if client.name == "svelte" then
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
							end
						end,
					})
				end,
			},
			pyright = {
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
			},
			gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						experimentalPostfixCompletions = true,
						gofumpt = true,
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
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
			rust_analyzer = {},
		}

		for server, server_opts in pairs(servers) do
			vim.lsp.config(
				server,
				vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, server_opts)
			)
		end

		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}
