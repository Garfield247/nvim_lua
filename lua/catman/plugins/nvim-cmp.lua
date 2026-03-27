return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- 缓冲区文本补全源
		"hrsh7th/cmp-path", -- 文件路径补全源
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip", -- 代码片段引擎
		"saadparwaiz1/cmp_luasnip", -- 片段补全
		"rafamadriz/friendly-snippets", -- 常用片段
		"onsails/lspkind.nvim", -- 类 VS Code 图标
		"hrsh7th/cmp-calc",
		-- "hrsh7th/cmp-emoji",
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- 从已安装插件加载 VSCode 风格片段（如 friendly-snippets）
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- nvim-cmp 与片段引擎的交互方式
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {

				completion = cmp.config.window.bordered({
					border = "double",
					-- winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Normal,Search:NONE",
				}),
				documentation = cmp.config.window.bordered({
					border = "double",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- 上一条建议
				["<C-j>"] = cmp.mapping.select_next_item(), -- 下一条建议
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- 显示补全
				["<C-e>"] = cmp.mapping.abort(), -- 关闭补全窗口
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- 补全可见时选下一条，否则在片段内跳转
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }), -- i 插入模式 s 选择模式
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- 补全来源
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- 代码片段
				{ name = "buffer" }, -- 当前缓冲区文本
				{ name = "path" }, -- 文件路径
				{ name = "calc" },
			}),
			-- 补全菜单中类 VS Code 的图标与格式
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol", -- 仅显示符号
					maxwidth = 50, -- 弹窗最大宽度（字符数）
					ellipsis_char = "...", -- 超出部分用省略号
					show_labelDetails = true, -- 显示标签详情
					menu = {
						buffer = " Buffer",
						nvim_lsp = " Lsp",
						luasnip = "󰦨 Snip",
						ultisnips = "󰦨 Snip",
						nvim_lua = " Lua",
						look = " Look",
						path = "󰙅 Path",
						calc = " Clac",
						emoji = "󰱨 Emoji",
					},

					-- 在 lspkind 实际修改前调用的函数，可自定义弹窗样式
					-- before = function(entry, vim_item)
					-- 	vim_item.kind = lspkind.presets.default[vim_item.kind]
					-- 	vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
					-- 	-- 为每个补全源设置显示名称
					-- 	vim_item.menu = ({
					-- 		buffer = "",
					-- 		nvim_lsp = "",
					-- 		luasnip = "󰦨",
					-- 		ultisnips = "󰦨",
					-- 		nvim_lua = "",
					-- 		look = "",
					-- 		path = "󰙅",
					-- 		calc = "",
					-- 		emoji = "󰱨",
					-- 	})[entry.source.name]
					-- 	return vim_item
					-- end,
				}),
			},
		})
	end,
}
