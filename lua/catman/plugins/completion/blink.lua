-- blink.cmp：Neovim 0.12 官方强烈推荐的基于 Rust 构建的超高性能补全引擎（替代旧版 nvim-cmp）
return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets", -- 提供通用的 Code Snippets 片段集
	version = "*", -- 始终跟随最新稳定版发布

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 快捷键设置：支持选择、接受、文档滚动及 Snippet 展开
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" }, -- 手动唤起/切换文档
			["<C-e>"] = { "hide" }, -- 取消并隐藏补全弹窗
			["<CR>"] = { "accept", "fallback" }, -- 回车确认补全项
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- Tab 键向下选择或展开 Snippet
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" }, -- Shift+Tab 键向上选择
			["<C-k>"] = { "select_prev", "fallback" }, -- Ctrl-k 向上选择补全项
			["<C-j>"] = { "select_next", "fallback" }, -- Ctrl-j 向下选择补全项
			["<C-b>"] = { "scroll_documentation_up", "fallback" }, -- 向上滚动浮动文档窗口
			["<C-f>"] = { "scroll_documentation_down", "fallback" }, -- 向下滚动浮动文档窗口
		},

		-- 外观设定：使用 Nerd Font 字体渲染图标
		appearance = {
			use_nvim_cmp_as_default = true, -- 回退兼容 nvim-cmp 的 Highlight 组
			nerd_font_variant = "mono",
		},

		-- 补全数据源集合：聚合 LSP、路径、代码片段及当前缓冲区词汇
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- 补全菜单与浮动窗口配置
		completion = {
			menu = {
				auto_show = true, -- 打字时自动弹出补全菜单
				border = "rounded", -- 圆角边框设计
				draw = {
					treesitter = { "lsp" }, -- 启用 Treesitter 语法高亮提升预览体验
				},
			},
			documentation = {
				auto_show = true, -- 选择补全项时自动显示详细帮助文档
				auto_show_delay_ms = 200, -- 延迟 200ms 防止快速光标移动时闪烁
				window = { border = "rounded" },
			},
			ghost_text = {
				enabled = true, -- 启用 IDE 风格的灰色行内虚拟文本预览
			},
		},

		-- 函数签名悬浮提示（输入参数时自动显示参数类型）
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},

		-- 命令行 (Cmdline / :) 补全独立配置
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true, -- 在命令行输入 : 命令时秒级自动弹出菜单
				},
			},
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next", "fallback" }, -- Cmdline 模式下用 Ctrl-j 向下选择
				["<C-k>"] = { "select_prev", "fallback" }, -- Cmdline 模式下用 Ctrl-k 向上选择
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
		},
	},
	opts_extend = { "sources.default" },
}
