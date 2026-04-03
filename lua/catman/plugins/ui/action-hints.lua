-- action-hints.nvim：在状态栏显示光标处的 LSP 定义跳转与引用数量提示
return {
	"roobert/action-hints.nvim",
	config = function()
		-- 修复上游使用废弃 API 的问题（vim.lsp.buf_get_clients 在 0.12 移除）
		if not vim.lsp.buf_get_clients then
			vim.lsp.buf_get_clients = function(bufnr)
				return vim.lsp.get_clients({ bufnr = bufnr or 0 })
			end
		end

		require("action-hints").setup({
			template = {
				definition = { text = " ⊛ ", color = "#add8e6" },
				references = { text = " ↱ %s", color = "#ff6666" },
			},
			use_virtual_text = true,
		})
	end,
}
