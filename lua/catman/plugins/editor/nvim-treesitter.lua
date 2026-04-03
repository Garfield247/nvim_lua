-- nvim-treesitter：基于语法树的代码高亮、缩进、折叠引擎，支持数十种编程语言
return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- 引入 nvim-treesitter
			local treesitter = require("nvim-treesitter.configs")

			-- 配置 treesitter
			treesitter.setup({ -- 语法高亮
				highlight = {
					enable = true,
				},
				-- 缩进
				indent = { enable = true },
				-- 自动标签（配合 nvim-ts-autotag）
				autotag = {
					enable = true,
				},
				-- 要安装的语言解析器
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"python",
					"go",
					"vimdoc",
					"gowork",
					"gomod",
					"gosum",
					"sql",
					"gotmpl",
					"comment",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})

			-- 为 tsx、jsx 等提供正确的注释上下文
			require("ts_context_commentstring").setup({})

			-- 基于 treesitter 的代码折叠
			-- 用 autocmd 延迟设置，避免懒加载导致 foldexpr 失效
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				callback = function()
					if pcall(vim.treesitter.get_parser) then
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.opt_local.foldlevel = 99
						vim.opt_local.foldenable = true
						vim.opt_local.foldtext = ""
					end
				end,
			})

			-- 折叠快捷键
			local keymap = vim.keymap
			keymap.set("n", "za", "za", { desc = "切换当前折叠" })
			keymap.set("n", "zc", "zc", { desc = "关闭当前折叠" })
			keymap.set("n", "zo", "zo", { desc = "打开当前折叠" })
			keymap.set("n", "zR", "zR", { desc = "展开所有折叠" })
			keymap.set("n", "zM", "zM", { desc = "关闭所有折叠" })
			keymap.set("n", "zj", "zj", { desc = "跳到下一个折叠" })
			keymap.set("n", "zk", "zk", { desc = "跳到上一个折叠" })
		end,
	},
}
