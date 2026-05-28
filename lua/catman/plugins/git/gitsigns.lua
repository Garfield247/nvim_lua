-- gitsigns.nvim：在行号列显示 Git 变更标记（新增/修改/删除），支持 hunk 预览和暂存
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- 现代化的侧边栏标记
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		-- 实时行内 Blame 提示（类似 VS Code）
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 放在行尾
			delay = 500,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "   <author> • <author_time:%Y-%m-%d> • <summary>",
		-- 悬浮预览窗设置
		preview_config = {
			border = "rounded", -- 圆角边框，更有现代感
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		-- 快捷键配置
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- 导航
			map("n", "]h", function()
				if vim.wo.diff then
					return "]h"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "下一个变更 (Hunk)" })

			map("n", "[h", function()
				if vim.wo.diff then
					return "[h"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "上一个变更 (Hunk)" })

			-- 操作
			map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存变更 (Stage)" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "重置变更 (Reset)" })
			map("n", "<leader>hp", gs.preview_hunk, { desc = "预览变更 (Preview)" })
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "查看行注释 (Blame)" })
			map("n", "<leader>hd", gs.diffthis, { desc = "查看差异 (Diff)" })
		end,
	},
}
