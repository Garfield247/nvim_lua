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
		end,
	},
}
