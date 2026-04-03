-- ranger.nvim：在 Neovim 内嵌入 ranger 终端文件管理器，支持替代 netrw
return {
	"kelly-lin/ranger.nvim",
	config = function()
		require("ranger-nvim").setup({ replace_netrw = true })
		vim.api.nvim_set_keymap("n", "<leader>ef", "", {
			noremap = true,
			callback = function()
				require("ranger-nvim").open(true)
			end,
		})
	end,
}
