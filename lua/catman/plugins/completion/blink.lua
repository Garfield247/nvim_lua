-- blink.cmp：现代补全引擎，整合 LSP、路径、缓冲区、snippet 等补全来源
return {
	"saghen/blink.cmp",
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = {
			preset = "none",
			-- 让 C-j / C-k 在切换候选时直接预览写入，更接之前 nvim-cmp 的手感
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		},
		appearance = {
			nerd_font_variant = "normal",
			use_nvim_cmp_as_default = false,
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 180,
				window = {
					border = "double",
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
				},
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				max_items = 12,
				selection = {
					-- 候选切换时直接把当前项预览写入，减少再按一次回车的频率
					preselect = false,
					auto_insert = true,
				},
			},
			menu = {
				border = "double",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpBorder,CursorLine:BlinkCmpSel,Search:None",
				scrollbar = false,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
						{ "source_name" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								return ctx.kind_icon .. " "
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
						kind = {
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
						label = {
							width = { fill = true, max = 40 },
						},
						source_name = {
							width = { max = 18 },
						},
					},
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "double",
			},
		},
		snippets = {
			preset = "default",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		local blink = require("blink.cmp")
		blink.setup(opts)

		local function set_blink_highlights()
			-- 自定义浮窗高亮，让补全菜单和文档面板层次更清晰
			vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "BlinkCmpBorder", { link = "FloatBorder" })
			vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
			vim.api.nvim_set_hl(0, "BlinkCmpSel", {
				fg = "#D6DEEB",
				bg = "#315B7A",
				bold = true,
			})
		end

		set_blink_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("catman_blink_highlights", { clear = true }),
			callback = set_blink_highlights,
		})
	end,
}
