-- blink.cmp：Neovim 0.12 推荐的原生超高性能补全引擎（带现代 UI 视觉美化方案）
return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 快捷键设置：支持选择、接受、文档滚动及 Snippet 展开
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		-- 外观美化与 Nerd Font v3 图标映射集
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰏿",
			},
		},

		-- 补全数据源集合
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- 补全菜单与美化绘制配置
		completion = {
			menu = {
				auto_show = true,
				border = "rounded", -- 精致圆角边框
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				draw = {
					columns = {
						{ "kind_icon", "kind", gap = 1 },
						{ "label", "label_description", gap = 1 },
					},
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 150,
				window = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
			ghost_text = {
				enabled = true, -- IDE 风格暗色虚线行内预览
			},
		},

		-- 函数签名悬浮提示
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
			},
		},

		-- 命令行 (Cmdline / :) 补全与美化配置
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true,
				},
			},
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
		},
	},
	opts_extend = { "sources.default" },
}
