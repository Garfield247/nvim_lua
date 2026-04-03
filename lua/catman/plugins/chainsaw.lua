-- nvim-chainsaw：一键在光标处插入 log/print 调试语句，支持多语言
-- https://github.com/chrisgrieser/nvim-chainsaw

return {

	-- Create log statements on the fly
	{
		"chrisgrieser/nvim-chainsaw",
		opts = {
			logStatements = {
				messageLog = {
					go = 'fmt.Println("%s")',
				},
				variableLog = {
					go = 'fmt.Println("%s %s:", %s)',
					nvim_lua = 'vim.notify("%s %s", vim.inspect(%s))',
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ '<Leader>dv', function() require('chainsaw').variableLog() end },
			{ '<Leader>dm', function() require('chainsaw').messageLog() end },
		},
	},
}
