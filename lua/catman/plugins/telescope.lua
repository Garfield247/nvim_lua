return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- 上一条结果
						["<C-j>"] = actions.move_selection_next, -- 下一条结果
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
				buffers = {
					theme = "ivy",
				},
			},
		})

		telescope.load_extension("fzf")

		-- 键位
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "模糊查找当前目录文件" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "最近打开的文件" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "在当前目录搜索字符串" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "搜索光标下字符串" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "查找缓冲区" })
	end,
}
