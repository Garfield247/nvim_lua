-- neodev.nvim：为 Neovim 配置开发提供 Lua API 类型提示、文档补全和签名帮助
return {
	"folke/neodev.nvim",
	opts = {
		library = {
			enabled = true, -- 关闭后 neodev 不会修改 LSP 服务器的任何设置
			-- 以下设置用于你的 Neovim 配置目录
			runtime = true, -- 运行时路径
			types = true, -- vim.api、vim.treesitter、vim.lsp 等的完整签名、文档与补全
			plugins = true, -- packpath 中已安装的 opt 或 start 插件
			-- 也可指定作为工作区库的插件列表
			-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
		},
		setup_jsonls = true, -- 配置 jsonls 为项目 .luarc.json 提供补全
		-- 配置目录使用 config.library；插件目录（含 /lua 的 root_dirs）会禁用 config.library.plugins
		-- 其他目录会将 config.library.enabled 设为 false
		override = function(root_dir, options) end,
		-- 配合 lspconfig 时，Neodev 会自动配置 lua-language-server
		-- 若关闭此项，需在 LSP 启动选项中设置 {before_init=require("neodev.lsp").before_init}
		lspconfig = true,
		-- 更快，但需要较新版本的 lua-language-server（>= 3.6.0）
		pathStrict = true,
	},
}
