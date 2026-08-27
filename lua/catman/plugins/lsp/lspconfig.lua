-- nvim-lspconfig：Neovim 0.12 官方推荐 Native LSP 启动与配置模块（利用 vim.lsp.config & vim.lsp.enable）
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp", -- 集成 blink.cmp 的 Capabilities 能力扩展
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- 开启文件重命名时自动同步重构 LSP Import
	},
	config = function()
		-- 继承并加载 blink.cmp 的补全 Capabilities 特性
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local svelte_group = vim.api.nvim_create_augroup("CatmanSvelteWatch", { clear = true })
		local lsp_attach_group = vim.api.nvim_create_augroup("CatmanLspAttach", { clear = true })

		-- 辅助函数：缓冲区局部按键绑定
		local function buf_map(bufnr, mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				noremap = true,
				silent = true,
				desc = desc,
			})
		end

		-- Python 专属：项目根目录动态探测器（兼容 uv, pyproject, .venv, pyenv）
		local function detect_python_root(bufnr)
			local root = vim.fs.root(bufnr, {
				"uv.lock",
				"pyproject.toml",
				"pyrightconfig.json",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
			})
			if root then
				return root
			end

			root = vim.fs.root(bufnr, { ".venv", "venv", ".python-version" })
			if root then
				return root
			end

			root = vim.fs.root(bufnr, { "src" })
			if root then
				return root
			end

			root = vim.fs.root(bufnr, { ".git" })
			if root then
				return root
			end

			local name = vim.api.nvim_buf_get_name(bufnr)
			return name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
		end

		-- Python 专属：解释器可执行文件精确探针（按 uv -> 传统 venv -> 激活环境 -> pyenv 顺序探测）
		local function get_python_interpreter(root_dir)
			if not root_dir or root_dir == "" then
				root_dir = vim.uv.cwd()
			end

			-- 1. 优先使用项目根目录下的 .venv (uv 生成)
			local venv_path = vim.fs.joinpath(root_dir, ".venv", "bin", "python")
			if vim.fn.executable(venv_path) == 1 then
				return venv_path
			end

			-- 2. 检查项目根目录下的 venv
			local alt_venv_path = vim.fs.joinpath(root_dir, "venv", "bin", "python")
			if vim.fn.executable(alt_venv_path) == 1 then
				return alt_venv_path
			end

			-- 3. 使用当前 Shell 激活的 VIRTUAL_ENV
			if vim.env.VIRTUAL_ENV then
				local env_python = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
				if vim.fn.executable(env_python) == 1 then
					return env_python
				end
			end

			-- 4. 使用 pyenv 或全局默认 python3
			return vim.fn.exepath("python3") or "python"
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

				local ok, fzf_lua = pcall(require, "fzf-lua")
				local bufnr = args.buf
				local filetype = vim.bo[bufnr].filetype
				local references = ok and fzf_lua.lsp_references or vim.lsp.buf.references
				local definitions = vim.lsp.buf.definition
				local implementations = ok and fzf_lua.lsp_finder or vim.lsp.buf.implementation
				local type_definitions = ok and fzf_lua.lsp_typedefs or vim.lsp.buf.type_definition
				local diagnostics = ok and fzf_lua.diagnostics_document or vim.diagnostic.setloclist

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

				vim.api.nvim_buf_create_user_command(bufnr, "LspRoot", function()
					local lines = {}
					local clients = vim.lsp.get_clients({ bufnr = bufnr })
					for _, attached_client in ipairs(clients) do
						table.insert(
							lines,
							string.format("%s: %s", attached_client.name, attached_client.root_dir or "nil")
						)
					end

					if #lines == 0 then
						table.insert(lines, "No LSP client attached")
					end

					vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LSP Root" })
				end, {
					desc = "显示当前缓冲区 LSP 根目录",
				})

				if
					(filetype == "go" or filetype == "python")
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
				then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
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
			basedpyright = {
				root_dir = function(bufnr, on_dir)
					on_dir(detect_python_root(bufnr))
				end,
				before_init = function(_, config)
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = get_python_interpreter(config.root_dir)
				end,
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "standard",
						},
					},
				},
			},
			ruff = {
				root_dir = function(bufnr, on_dir)
					on_dir(detect_python_root(bufnr))
				end,
			},
			pyright = {
				root_dir = function(bufnr, on_dir)
					on_dir(detect_python_root(bufnr))
				end,
				before_init = function(_, config)
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = get_python_interpreter(config.root_dir)
				end,
				settings = {
					pyright = { autoImportCompletion = true },
					python = {
						inlayHints = true,
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
						hints = {
							parameterNames = true,
							functionTypeParameters = true,
							constantValues = true,
						},
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
