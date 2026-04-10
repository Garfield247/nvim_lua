-- codex.nvim：在 Neovim 内集成 OpenAI Codex CLI
-- 需要先设置环境变量：export OPENAI_API_KEY=your_api_key
local toggle_key = "<leader>cx"
local quit_key = "<C-q>"

return {
	"johnseth97/codex.nvim",
	lazy = true,
	cmd = { "Codex", "CodexToggle" },
	keys = {
		{
			toggle_key,
			function()
				require("codex").toggle()
			end,
			desc = "Toggle Codex 窗口",
			mode = { "n", "t" },
		},
	},
	opts = {
		keymaps = {
			toggle = nil, -- 默认 nil：不使用插件内置全局快捷键，改由上方 keys 显式声明
			quit = quit_key, -- 默认 "<C-q>"：Codex 窗口内关闭快捷键
		},
		border = "rounded", -- 默认 "single"：浮动窗口边框，可选 "single"、"double"、"rounded"、"none"
		width = 0.4, -- 默认 0.8：窗口宽度，占编辑器总宽度的比例
		height = 0.8, -- 默认 0.8：窗口高度，占编辑器总高度的比例
		cmd = "codex", -- 默认 "codex"：启动 Codex CLI 的命令，也可传命令数组
		model = nil, -- 默认 nil：使用 Codex CLI 当前默认模型，可改为 "o3-mini" 等
		autoinstall = true, -- 默认 true：未检测到 Codex CLI 时自动尝试安装（需要 npm）
		panel = true, -- 默认 false：false 使用浮动窗口，true 使用右侧边栏
		use_buffer = false, -- 默认 false：false 使用 terminal buffer，true 捕获到普通 buffer
	},
}
