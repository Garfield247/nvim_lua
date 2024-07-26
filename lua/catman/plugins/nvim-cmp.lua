return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-emoji",
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
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
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Hint: if the completion menu is visible select next one
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
						luasnip.expand_or_jump()
					-- elseif has_words_before() then
					-- 	cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }), -- i - insert mode; s - select mode
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

			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				-- { name = "codeium" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "emoji" },
				{ name = "calc" },
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
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

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					-- before = function(entry, vim_item)
					-- 	-- fancy icons and a name of kind
					-- 	-- vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
					-- 	vim_item.kind = lspkind.presets.default[vim_item.kind]
					-- 	vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
					-- 	-- set a name for each source
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
