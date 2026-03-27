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
	{ import = "catman.plugins" },
	{ import = "catman.plugins.ui" },
	{ import = "catman.plugins.git" },
	{ import = "catman.plugins.lsp" },
	-- { import = "catman.plugins.dap" },
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
