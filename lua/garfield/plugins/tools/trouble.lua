-- trouble.nvim：美化的诊断、引用、quickfix 列表面板，集中展示 LSP 错误和警告
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "全局诊断列表" },
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "当前文件诊断" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "文档符号列表" },
		{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP 定义/引用" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix 列表" },
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location 列表" },
		-- 在诊断间跳转（不打开 trouble 面板）
		{
			"[x",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
			desc = "上一个诊断（Trouble）",
		},
		{
			"]x",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "下一个诊断（Trouble）",
		},
	},
	opts = {
		auto_close = true,       -- 没有条目时自动关闭
		auto_preview = true,     -- 自动预览当前条目
		focus = false,           -- 打开时不自动跳到 trouble 窗口
		follow = true,           -- 跟随光标高亮对应条目
		multiline = true,        -- 显示多行错误信息
		indent_guides = true,
		win = {
			size = { height = 12 },
		},
		modes = {
			-- 符号列表显示在右侧
			symbols = {
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right", size = { width = 35 } },
				filter = {
					["not"] = { ft = "lua", kind = "Package" },
					any = {
						ft = { "help", "markdown" },
						kind = {
							"Class", "Constructor", "Enum", "Field",
							"Function", "Interface", "Method", "Module",
							"Namespace", "Property", "Struct",
						},
					},
				},
			},
		},
	},
	-- 接入 telescope：在 telescope 结果里按 <C-t> 发送到 trouble
	config = function(_, opts)
		require("trouble").setup(opts)
		local open_with_trouble = require("trouble.sources.telescope").open
		require("telescope").setup({
			defaults = {
				mappings = {
					i = { ["<C-t>"] = open_with_trouble },
					n = { ["<C-t>"] = open_with_trouble },
				},
			},
		})
	end,
}
