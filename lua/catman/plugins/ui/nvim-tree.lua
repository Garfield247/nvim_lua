-- nvim-tree.lua：文件树侧边栏，支持 Git 状态显示、图标、过滤等功能
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- 按 nvim-tree 文档推荐的设置（禁用内置文件浏览器）
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- 树形箭头颜色设为浅蓝
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		-- 配置 nvim-tree
		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- 文件夹箭头图标
			renderer = {
				root_folder_label = false,
				highlight_git = true,
				highlight_opened_files = "all",

				indent_markers = {
					enable = true,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},

					glyphs = {
						default = "",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "󰅚",
							staged = "󰗡",
							unmerged = "",
							renamed = "",
							untracked = "󰎔",
							deleted = "󱋪",
							ignored = "󱥸",
						},
					},
				},
			},
			-- 关闭 window_picker，便于与分屏配合使用
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				enable = true,
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- 键位
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "切换文件树" })
		keymap.set("n", "<leader>ea", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "在当前文件位置打开/关闭文件树" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "折叠文件树" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "刷新文件树" })
	end,
}
