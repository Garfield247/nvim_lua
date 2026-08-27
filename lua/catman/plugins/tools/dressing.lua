-- dressing.nvim：美化 vim.ui.input 和 vim.ui.select，用 telescope 等替代原生弹窗
return {
	"stevearc/dressing.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = function()
		local has_telescope, themes = pcall(require, "telescope.themes")

		return {
			input = {
				enabled = true,
				default_prompt = "Input",
				trim_prompt = true,
				title_pos = "left",
				start_mode = "insert",
				border = "rounded",
				relative = "cursor",
				prefer_width = 48,
				max_width = { 140, 0.8 },
				min_width = { 24, 0.25 },
				win_options = {
					wrap = false,
					list = true,
					listchars = "precedes:<,extends:>",
					sidescrolloff = 1,
					winblend = 0,
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<C-j>"] = "HistoryNext",
						["<C-k>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
						["<Up>"] = "HistoryPrev",
					},
				},
				get_config = function(opts)
					if opts and opts.prompt and opts.prompt:match("Rename") then
						return {
							relative = "editor",
							prefer_width = 60,
						}
					end
				end,
			},
			select = {
				enabled = true,
				trim_prompt = true,
				backend = has_telescope and { "telescope", "builtin" } or { "builtin" },
				telescope = has_telescope and themes.get_dropdown({
					layout_config = {
						width = 0.55,
						height = 0.45,
					},
					results_title = false,
					previewer = false,
					prompt_title = false,
					prompt_prefix = " ",
					selection_caret = "  ",
					sorting_strategy = "ascending",
				}) or nil,
				builtin = {
					show_numbers = false,
					border = "rounded",
					relative = "editor",
					max_width = { 100, 0.6 },
					min_width = { 36, 0.3 },
					max_height = { 20, 0.4 },
					min_height = { 8, 0.2 },
					win_options = {
						cursorline = true,
						cursorlineopt = "both",
						winblend = 0,
						statuscolumn = " ",
					},
				},
				format_item_override = {
					codeaction = function(item)
						if type(item) == "table" and item.title then
							return item.title:gsub("\r", ""):gsub("\n", " ")
						end

						return tostring(item)
					end,
				},
			},
		}
	end,
}
