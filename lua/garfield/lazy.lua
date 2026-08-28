local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- 最新稳定版
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "garfield.plugins" },
	{ import = "garfield.plugins.completion" },
	{ import = "garfield.plugins.editor" },
	{ import = "garfield.plugins.tools" },
	{ import = "garfield.plugins.lang" },
	{ import = "garfield.plugins.ui" },
	{ import = "garfield.plugins.git" },
	{ import = "garfield.plugins.lsp" },
	{ import = "garfield.plugins.dap" },
}, {
	install = {
		colorscheme = { "catppuccin-mocha" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

vim.cmd.colorscheme("catppuccin-mocha")
