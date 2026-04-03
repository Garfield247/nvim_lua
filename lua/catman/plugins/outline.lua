-- outline.nvim：代码大纲侧边栏，展示当前文件的函数、类、变量等符号结构树
return {
	"hedyhli/outline.nvim",
	config = function()
		-- Example mapping to toggle outline
		vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
		})
	end,
}
