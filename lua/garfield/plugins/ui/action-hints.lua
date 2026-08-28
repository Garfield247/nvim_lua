-- action-hints.nvim：在状态栏显示光标处的 LSP 定义跳转与引用数量提示
return {
	"roobert/action-hints.nvim",
	event = { "BufReadPre", "BufNewFile" },
	init = function()
		-- 兼容仍在调用旧 API 的上游实现。
		if not vim.lsp.buf_get_clients then
			vim.lsp.buf_get_clients = function(bufnr)
				return vim.lsp.get_clients({ bufnr = bufnr or 0 })
			end
		end
	end,
	opts = function()
		local function fg_from(group, fallback)
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
			if ok and hl and hl.fg then
				return string.format("#%06x", hl.fg)
			end
			return fallback
		end

		return {
			template = {
				definition = {
					text = " 󰌹",
					color = fg_from("DiagnosticHint", "#10B981"),
				},
				references = {
					text = " 󰌻 %s",
					color = fg_from("DiagnosticInfo", "#7DCFFF"),
				},
			},
			-- 已经接入 lualine，再额外显示虚拟文本会显得重复且更容易抖动。
			use_virtual_text = false,
		}
	end,
}
