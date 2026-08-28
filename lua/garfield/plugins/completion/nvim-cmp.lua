-- nvim-cmp：Neovim 补全引擎，聚合 LSP、片段、路径、缓冲区等多种补全来源
return {
	"hrsh7th/nvim-cmp",
	enabled = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-calc",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		-- 辅助函数：判断光标前是否有字符（用于 Tab 补全判断）
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			completion = {
				-- completeopt:
				--   menu: 弹出菜单
				--   menuone: 只有一个选项时也弹出
				--   noselect: 不自动选中第一项（改为默认自动选中，提升体验）
				--   preview: 显示预览窗口（可选）
				completeopt = "menu,menuone,preview",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded", -- 改为 rounded 看起来更现代，也更稳定
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- Ctrl + Space 或 Ctrl + @ 强制唤起补全
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-@>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- 回车确认补全，select = true 表示即使没手动选也确认第一个
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
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
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 }, -- 优先 LSP
				{ name = "luasnip", priority = 750 },
				{ name = "buffer", priority = 500, keyword_length = 2 }, -- 避免过短触发
				{ name = "path", priority = 250 },
				{ name = "calc" },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- 自定义图标映射（Nerd Font v3）
					local kind_icons = {
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
					}

					-- 合并图标和类型文字到 kind 字段
					local kind_name = vim_item.kind
					local icon = kind_icons[kind_name] or ""
					vim_item.kind = string.format("%s %s", icon, kind_name)

					-- 设置右侧来源信息（带图标）
					local source_map = {
						buffer = "󰦨  Buf",
						nvim_lsp = "󰒋  LSP",
						luasnip = "󰩫  Snip",
						nvim_lua = "󰢱  Lua",
						path = "󰉖  Path",
						calc = "󰃬  Calc",
					}
					local icon_source = source_map[entry.source.name] or entry.source.name
					vim_item.menu = string.format("  [%s]", icon_source)

					return vim_item
				end,
			},
			performance = {
				fetching_timeout = 500,
				debounce = 60,
				throttle = 30,
			},
		})

		-- / 查找模式补全
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- : 命令行模式补全
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		-- 与 nvim-autopairs 集成：输入确认后自动补全括号
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
