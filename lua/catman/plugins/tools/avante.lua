-- avante.nvim：在 Neovim 内使用 AI 辅助编码，类似 Cursor IDE 的体验
return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	version = false, -- 不要设置为 "*"
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim", -- 文件选择器
		"hrsh7th/nvim-cmp", -- avante 命令补全
		"stevearc/dressing.nvim", -- 输入框美化
		{
			-- 图片粘贴支持
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
				},
			},
		},
		{
			-- Markdown 渲染（avante 的回复面板用到）
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
	opts = {
		-- 使用 MiniMax，通过 OpenAI 兼容接口接入
		provider = "minimax",
		providers = {
			minimax = {
				__inherited_from = "openai", -- 继承 openai 的请求解析逻辑
				endpoint = "https://api.minimaxi.com/v1",
				model = "MiniMax-M2.7", -- 可选：MiniMax-M2.7 / MiniMax-M2.5 / MiniMax-M2.1 / MiniMax-M2
				timeout = 60000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 8192,
				},
				-- 在 ~/.zshrc 或 ~/.bashrc 中添加：
				-- export MINIMAX_API_KEY=your_api_key_here
				api_key_name = "MINIMAX_API_KEY",
			},
		},
		-- 行为配置
		behaviour = {
			auto_suggestions = false, -- 关闭自动建议（高频调用，费 token）
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			minimize_diff = true,
			enable_token_counting = true,
			auto_add_current_file = true,
		},
		-- 侧边栏配置
		windows = {
			position = "right",
			width = 35,
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
			},
			input = {
				prefix = "> ",
				height = 8,
			},
			ask = {
				floating = false,
				start_insert = true,
				border = "rounded",
			},
		},
		-- 文件选择器用 telescope
		selector = {
			provider = "telescope",
			-- nvim-tree 侧边栏不触发文件选择
			exclude_auto_select = { "NvimTree" },
		},
		-- 输入框用 dressing
		input = {
			provider = "dressing",
		},
		-- diff 冲突快捷键（避免和 trouble 的 [x/]x 冲突，改用 [c/]c）
		mappings = {
			diff = {
				ours = "co",
				theirs = "ct",
				both = "cb",
				cursor = "cc",
				next = "]c",
				prev = "[c",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
			cancel = {
				normal = { "<C-c>", "<Esc>", "q" },
				insert = { "<C-c>" },
			},
			sidebar = {
				apply_all = "A",
				apply_cursor = "a",
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
				remove_file = "d",
				add_file = "@",
				close = { "<Esc>", "q" },
			},
		},
	},
	-- nvim-tree 集成：在文件树里按 <leader>a+ 添加文件到 avante 上下文
	keys = {
		{
			"<leader>a+",
			function()
				require("avante.extensions.nvim_tree").add_file()
			end,
			desc = "Avante: 添加文件到上下文",
			ft = "NvimTree",
		},
		{
			"<leader>a-",
			function()
				require("avante.extensions.nvim_tree").remove_file()
			end,
			desc = "Avante: 从上下文移除文件",
			ft = "NvimTree",
		},
	},
}
