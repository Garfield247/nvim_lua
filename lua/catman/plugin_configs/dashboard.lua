-- import comment plugin safely
local setup, db = pcall(require, "dashboard")
if not setup then
	return
end
local keymap = vim.keymap
keymap.set("n", "<LEADER>ff", ":Telescope find_files find_command=rg,--hidden,--files<CR>")
keymap.set("n", "<LEADER>fw", ":Telescope live_grep<CR>")

db.setup({

	config = {
		shortcut = {
			-- action can be a function type
			{ desc = string, group = "highlight group", key = "shortcut key", action = "action when you press key" },
		},
		packages = { enable = true }, -- show how many plugins neovim loaded
		-- limit how many projects list, action when you press key or enter it will run this action.
		-- action can be a functino type, e.g.
		-- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
		project = { enable = true, limit = 8, icon = "your icon", label = "", action = "Telescope find_files cwd=" },
		mru = { limit = 10, icon = "your icon", label = "" },
		footer = {}, -- footer
	},
})