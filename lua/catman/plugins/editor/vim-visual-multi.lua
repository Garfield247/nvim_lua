-- vim-visual-multi：多光标编辑插件，支持同时在多处位置进行编辑操作
return {
	"mg979/vim-visual-multi",
	keys = {
		{ "<C-n>", mode = { "n", "x" }, desc = "多选下一个匹配" },
		{ "<M-j>", mode = "n", desc = "向下添加光标" },
		{ "<M-k>", mode = "n", desc = "向上添加光标" },
		{ "<leader>ma", mode = { "n", "x" }, desc = "多选全部匹配" },
		{ "<leader>mr", mode = { "n", "x" }, desc = "多选正则匹配" },
		{ "<leader>mm", mode = "n", desc = "在当前位置添加光标" },
	},
	init = function()
		-- 关闭大部分默认常驻映射，只保留手动挑选的核心操作，减少与现有快捷键冲突。
		vim.g.VM_default_mappings = 0
		vim.g.VM_mouse_mappings = 0

		-- VM 自带状态栏更新频繁且收益有限，直接关闭；退出时也不再回显提示。
		vim.g.VM_set_statusline = 0
		vim.g.VM_silent_exit = 1
		vim.g.VM_show_warnings = 0

		-- 纵向加光标时跳过空行和短行，避免列编辑时产生无效光标。
		vim.g.VM_skip_empty_lines = 1
		vim.g.VM_skip_shorter_lines = 1

		-- 退出插入模式后自动离开 VM，少按一次 <Esc>。
		vim.g.VM_quit_after_leaving_insert_mode = 1
		vim.g.VM_reindent_filetypes = { "go", "lua", "python", "javascript", "typescript", "typescriptreact" }

		vim.g.VM_maps = {
			["Find Under"] = "<C-n>",
			["Find Subword Under"] = "<C-n>",
			["Add Cursor Down"] = "<M-j>",
			["Add Cursor Up"] = "<M-k>",
			["Select All"] = "<leader>ma",
			["Visual All"] = "<leader>ma",
			["Start Regex Search"] = "<leader>mr",
			["Visual Regex"] = "<leader>mr",
			["Add Cursor At Pos"] = "<leader>mm",
		}
	end,
}
