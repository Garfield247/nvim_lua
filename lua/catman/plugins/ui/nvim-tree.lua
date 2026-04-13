-- nvim-tree.lua：文件树侧边栏，支持 Git 状态显示、图标、过滤与诊断信息
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle", "NvimTreeCollapse", "NvimTreeRefresh" },
	keys = {
		{ "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" },
		{ "<leader>ea", "<cmd>NvimTreeFindFileToggle<CR>", desc = "在当前文件位置打开/关闭文件树" },
		{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "折叠文件树" },
		{ "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "刷新文件树" },
	},
	init = function()
		-- 官方建议尽早禁用 netrw，避免目录缓冲区被它接管。
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = function()
		local api = require("nvim-tree.api")

		local function opts(desc, bufnr)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		local function on_attach(bufnr)
			api.map.on_attach.default(bufnr)

			vim.keymap.set("n", "l", api.node.open.edit, opts("打开", bufnr))
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("关闭目录", bufnr))
			vim.keymap.set("n", "v", api.node.open.vertical, opts("垂直分屏打开", bufnr))
			vim.keymap.set("n", "s", api.node.open.horizontal, opts("水平分屏打开", bufnr))
			vim.keymap.set("n", "i", api.tree.toggle_gitignore_filter, opts("切换 Git 忽略过滤", bufnr))
			vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("切换隐藏文件过滤", bufnr))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("帮助", bufnr))
		end

		-- 主题切换后重新应用高亮，避免箭头颜色丢失。
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("CatmanNvimTreeHighlights", { clear = true }),
			callback = function()
				vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#3FC5FF" })
				vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#3FC5FF" })
			end,
		})

		vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#3FC5FF" })
		vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#3FC5FF" })

		return {
			on_attach = on_attach,
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			select_prompts = false,
			update_focused_file = {
				enable = true,
				update_root = {
					enable = false,
				},
			},
			view = {
				width = {
					min = 35,
					max = 50,
					padding = 1,
				},
				relativenumber = true,
				signcolumn = "yes",
				centralize_selection = true,
				preserve_window_proportions = true,
			},
			sort = {
				sorter = "case_sensitive",
				folders_first = true,
			},
			renderer = {
				root_folder_label = false,
				group_empty = true,
				highlight_git = "name",
				highlight_opened_files = "all",
				highlight_modified = "name",
				highlight_diagnostics = "name",
				indent_markers = {
					enable = true,
					inline_arrows = true,
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
						diagnostics = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						modified = "●",
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
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				icons = {
					hint = "󰌵",
					info = "",
					warning = "",
					error = "",
				},
			},
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			actions = {
				open_file = {
					resize_window = false,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = { "^%.DS_Store$" },
			},
			live_filter = {
				prefix = "[过滤] ",
			},
			git = {
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = false,
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 120,
			},
		}
	end,
}
