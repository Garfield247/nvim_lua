-- diffview.nvim：Git diff 与文件历史查看器，提供类 IDE 的多文件差异对比界面
-- https://github.com/sindrets/diffview.nvim
return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewFocusFiles",
		"DiffviewToggleFiles",
		"DiffviewRefresh",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "打开 Git Diff 视图" },
		{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "关闭 Git Diff 视图" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "查看当前文件 Git 历史" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "查看项目 Git 历史" },
		{ "<leader>gf", "<cmd>DiffviewToggleFiles<cr>", desc = "切换 Diff 文件面板" },
		{ "<leader>gr", "<cmd>DiffviewRefresh<cr>", desc = "刷新 Diff 视图" },
	},
	opts = {
		enhanced_diff_hl = true,
		use_icons = true,
		show_help_hints = false,
		view = {
			default = {
				layout = "diff2_horizontal",
				disable_diagnostics = true,
				winbar_info = false,
			},
			merge_tool = {
				layout = "diff3_horizontal",
				disable_diagnostics = true,
				winbar_info = true,
			},
			file_history = {
				layout = "diff2_horizontal",
				disable_diagnostics = true,
				winbar_info = false,
			},
		},
		file_panel = {
			listing_style = "tree",
			tree_options = {
				flatten_dirs = true,
				folder_statuses = "only_folded",
			},
			win_config = {
				position = "left",
				width = 38,
			},
		},
		file_history_panel = {
			log_options = {
				git = {
					single_file = {
						diff_merges = "first-parent",
					},
					multi_file = {
						diff_merges = "first-parent",
					},
				},
			},
			win_config = {
				position = "bottom",
				height = 16,
			},
		},
	},
	config = function(_, opts)
		require("diffview").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "DiffviewFiles",
			callback = function(args)
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, {
						buffer = args.buf,
						silent = true,
						desc = desc,
					})
				end

				map("q", "<cmd>DiffviewClose<cr>", "关闭 Diff 视图")
				map("<tab>", "<cmd>DiffviewToggleFiles<cr>", "切换文件面板")
				map("R", "<cmd>DiffviewRefresh<cr>", "刷新 Diff 视图")
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "DiffviewFileHistory",
			callback = function(args)
				vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", {
					buffer = args.buf,
					silent = true,
					desc = "关闭历史视图",
				})
			end,
		})
	end,
}
