-- project.nvim：自动切换项目根目录，配合 telescope 快速在历史项目间跳转
return {
	"ahmedkhalf/project.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	event = "VeryLazy",
	config = function()
		require("project_nvim").setup({
			-- 根目录检测方式：先用 LSP，找不到再用 pattern 匹配
			detection_methods = { "lsp", "pattern" },

			-- pattern 匹配的根目录标识文件
			patterns = {
				".git", "Makefile", "go.mod", "go.work",  -- Go
				"pyproject.toml", "setup.py", "requirements.txt", "venv", ".venv", -- Python
				"package.json",  -- JS/TS
			},

			-- 忽略这些 LSP 客户端的根目录检测（避免干扰）
			ignore_lsp = { "null-ls", "copilot" },

			-- 切换目录时不显示提示信息
			silent_chdir = true,

			-- 切换范围：global（全局）/ tab / win
			-- 改为 win 级别，避免全局 cd 触发 nvim-tree 的 DirChanged bug
			scope_chdir = "win",

			-- telescope 中显示隐藏文件
			show_hidden = false,
		})

		-- 接入 telescope
		require("telescope").load_extension("projects")

		-- 快捷键：用 telescope 浏览历史项目
		vim.keymap.set("n", "<Leader>fp", "<cmd>Telescope projects<CR>", { desc = "查找历史项目" })
	end,
}
