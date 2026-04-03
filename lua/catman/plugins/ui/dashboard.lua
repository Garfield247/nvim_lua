-- dashboard-nvim：Neovim 启动页，显示自定义 banner、快捷操作和最近文件列表
return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			-- config
			theme = "hyper",
			config = {
				header = {
					"||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||",
					"||    ______               __      __       __                             ||",
					"||   /   󰄛  |             /󰄛 |    /󰄛 |     /󰄛 |                            ||",
					"||  /$$$$$$  |  ______   _$$ |_   $$  |   /$$ |  ______   _______          ||",
					"||  $$ |  $$/  /   󰄛  | / $$   |  $$$  | /$$$ | /   󰄛  | /  󰄛    |         ||",
					"||  $$ |       $$$$$$  |$$$$$$/   $$$$  /$$$$ | $$$$$$  |$$$$$$$  |        ||",
					"||  $$ |   __  /    $$ |  $$ | __ $$ $$ $$/$$ | /    $$ |$$ |  $$ |        ||",
					"||  $$ |__/  |/$$$$$$$ |  $$ |/  |$$ |$$$/ $$ |/$$$$$$$ |$$ |  $$ |        ||",
					"||  $$  󰄛 $$/ $$    $$ |  $$  $$/ $$ | $/  $$ |$$    $$ |$$ |  $$ |        ||",
					"||   $$$$$$/   $$$$$$$/    $$$$/  $$/      $$/  $$$$$$$/ $$/   $$/         ||",
					"||                                                                         ||",
					"||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||",
					"||                                                                         ||",
					"||                     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ||",
					"||                      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ||",
					"||                      ██╔██╗ ██║█████╗  ██║ 󰄛 ██║██║   ██║██║██╔████╔██║ ||",
					"||                      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ||",
					"||                      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ||",
					"||                      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ||",
					"||                                                                         ||",
					"||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||",
					"",
					"",
				},

				week_header = {
					enable = false,
				},
				shortcut = {
					{
						desc = "󰙅 Tree",
						group = "@property",
						action = "NvimTreeOpen",
						key = "e",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " KeyWord",
						group = "DiagnosticHint",
						action = "Telescope live_grep",
						key = "w",
					},
					-- {
					-- 	desc = " dotfiles",
					-- 	group = "Number",
					-- 	action = "Telescope dotfiles",
					-- 	key = "d",
					-- },
				},
				packages = { enable = false }, -- show how many plugins neovim loaded
				-- limit how many projects list, action when you press key or enter it will run this action.
				-- action can be a functino type, e.g.
				-- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
				project = {
					enable = false,
					limit = 8,
					icon = "your icon",
					label = "",
					action = "Telescope find_files cwd=",
				},
				mru = { limit = 10, icon = "  ", label = "MRU", cwd_only = true },
				footer = {}, -- footer
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
