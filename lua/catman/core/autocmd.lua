-- 打开文件时恢复上次光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- 保存时删除行尾空白（markdown 除外，两个空格结尾是换行语法）
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "markdown" then
			return
		end
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- 在浏览器中打开当前文件（适用于 HTML 等）
vim.api.nvim_create_user_command("ViewInBrowser", function()
	local file = vim.fn.expand("%:p")
	if vim.fn.has("mac") == 1 then
		vim.fn.system({ "open", "-a", "Google Chrome", file })
	end
end, {})
