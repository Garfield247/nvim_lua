-- telescope.nvim：强大的模糊查找框架，支持文件、字符串、缓冲区、LSP 符号等全局搜索
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = function()
		local builtin = require("telescope.builtin")

		return {
			{
				"<leader>ff",
				function()
					builtin.find_files({
						hidden = true,
						no_ignore = true,
					})
				end,
				desc = "模糊查找当前目录文件",
			},
			{ "<leader>fr", builtin.oldfiles, desc = "最近打开的文件" },
			{
				"<leader>fs",
				function()
					builtin.live_grep({
						additional_args = function()
							return { "--hidden" }
						end,
					})
				end,
				desc = "在当前目录搜索字符串",
			},
			{ "<leader>fc", builtin.grep_string, desc = "搜索光标下字符串" },
			{
				"<leader>fb",
				function()
					builtin.buffers({
						sort_mru = true,
						ignore_current_buffer = true,
					})
				end,
				desc = "查找缓冲区",
			},
		}
	end,
	opts = function()
		local actions = require("telescope.actions")

		return {
			defaults = {
				path_display = { "truncate" },
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"dist/",
					"build/",
					"target/",
					"%.cache/",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "ivy",
					previewer = false,
					initial_mode = "normal",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		pcall(telescope.load_extension, "fzf")
	end,
}
