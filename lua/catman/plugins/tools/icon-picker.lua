-- icon-picker.nvim：图标选择器，可在编辑器内搜索并插入 Nerd Font、emoji 等图标
return {
	"ziontee113/icon-picker.nvim",
	config = function()
		require("icon-picker").setup({ disable_legacy_commands = true })

		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
		vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
		-- <C-i> 在大多数终端里会和 <Tab> 发送同一个按键码，避免劫持 Tab 缩进
		vim.keymap.set("i", "<M-i>", "<cmd>IconPickerInsert<cr>", opts)
	end,
}
