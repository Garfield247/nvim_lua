-- codex.nvim：在 Neovim 内集成 OpenAI Codex CLI，并补充面向当前文件/选区的快捷入口
local toggle_key = "<leader>cx"
local ask_key = "<leader>ca"
local resume_key = "<leader>cr"
local explain_key = "<leader>ce"
local fix_key = "<leader>cf"
local quit_key = "<C-q>"

local function project_root()
	local buf = vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(buf)
	local start = name ~= "" and vim.fs.dirname(name) or vim.loop.cwd()
	return vim.fs.root(start, { ".git" }) or vim.loop.cwd()
end

local function relative_path(path)
	local root = project_root()
	if path == "" then
		return "[No Name]"
	end

	if vim.startswith(path, root) then
		return path:sub(#root + 2)
	end

	return vim.fn.fnamemodify(path, ":~")
end

local function visual_range()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	return start_line, end_line
end

local function set_codex_term_keymaps(buf)
	local opts = { buffer = buf, silent = true }
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
	vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
	vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
	vim.keymap.set("n", quit_key, "<cmd>close<CR>", opts)
	vim.keymap.set("t", quit_key, [[<C-\><C-n><cmd>close<CR>]], opts)
end

local function open_codex_session(cmd_args)
	local cwd = project_root()

	vim.cmd("botright vsplit")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_width(win, math.max(90, math.floor(vim.o.columns * 0.42)))
	vim.cmd("enew")

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "codex"

	set_codex_term_keymaps(buf)

	vim.fn.termopen(cmd_args, {
		cwd = cwd,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.schedule(function()
					vim.notify(("Codex exited with code %d"):format(code), vim.log.levels.WARN, { title = "codex" })
				end)
			end
		end,
	})

	vim.cmd("startinsert")
end

local function start_codex_with_prompt(prompt)
	local cmd = {
		"codex",
		"--no-alt-screen",
		"-s",
		"workspace-write",
		"-a",
		"on-request",
	}

	if prompt and prompt ~= "" then
		table.insert(cmd, prompt)
	end

	open_codex_session(cmd)
end

local function prompt_codex()
	vim.ui.input({ prompt = "Codex> " }, function(input)
		if not input or vim.trim(input) == "" then
			return
		end
		start_codex_with_prompt(input)
	end)
end

local function explain_context(opts)
	opts = opts or {}
	local file = vim.api.nvim_buf_get_name(0)

	if file == "" then
		vim.notify("当前缓冲区还没有文件路径，无法给 Codex 准确上下文。", vim.log.levels.WARN, { title = "codex" })
		return
	end

	local rel = relative_path(file)
	local prompt

	if opts.visual then
		local line1, line2 = visual_range()
		prompt = table.concat({
			"请先阅读当前仓库上下文，并重点查看文件 `" .. rel .. "` 的第 " .. line1 .. "-" .. line2 .. " 行。",
			"解释这段代码在做什么、依赖了什么上下文、有哪些风险或可改进点。",
			"先给分析结论，不要直接修改代码。",
		}, "\n")
	else
		prompt = table.concat({
			"请先阅读当前仓库上下文，并重点查看文件 `" .. rel .. "`。",
			"解释这个文件的职责、关键流程、潜在风险，以及最值得优先优化的地方。",
			"先给分析结论，不要直接修改代码。",
		}, "\n")
	end

	start_codex_with_prompt(prompt)
end

local function fix_context(opts)
	opts = opts or {}
	local file = vim.api.nvim_buf_get_name(0)

	if file == "" then
		vim.notify("当前缓冲区还没有文件路径，无法给 Codex 准确上下文。", vim.log.levels.WARN, { title = "codex" })
		return
	end

	local rel = relative_path(file)
	local prompt

	if opts.visual then
		local line1, line2 = visual_range()
		prompt = table.concat({
			"请先阅读当前仓库上下文，并修改文件 `" .. rel .. "` 的第 " .. line1 .. "-" .. line2 .. " 行附近代码。",
			"目标是提升可读性、稳定性或可维护性；改动尽量小，但要把问题真正修掉。",
			"修改前先快速说明你的判断，然后直接动手。",
		}, "\n")
	else
		prompt = table.concat({
			"请先阅读当前仓库上下文，并审查文件 `" .. rel .. "`。",
			"如果这里有明显可改进的问题，请直接给出最小且合理的修改方案并实施。",
			"优先处理可维护性、交互细节和配置易用性问题。",
		}, "\n")
	end

	start_codex_with_prompt(prompt)
end

local function resume_last_session()
	open_codex_session({
		"codex",
		"--no-alt-screen",
		"resume",
		"--last",
	})
end

return {
	"johnseth97/codex.nvim",
	lazy = true,
	cmd = {
		"Codex",
		"CodexToggle",
		"CodexAsk",
		"CodexResumeLast",
		"CodexExplain",
		"CodexFix",
	},
	keys = {
		{
			toggle_key,
			function()
				require("codex").toggle()
			end,
			desc = "切换 Codex 面板",
			mode = { "n", "t" },
		},
		{
			ask_key,
			prompt_codex,
			desc = "Codex 自定义提问",
			mode = "n",
		},
		{
			resume_key,
			resume_last_session,
			desc = "恢复最近一次 Codex 会话",
			mode = "n",
		},
		{
			explain_key,
			function()
				explain_context({ visual = false })
			end,
			desc = "解释当前文件",
			mode = "n",
		},
		{
			explain_key,
			function()
				explain_context({ visual = true })
			end,
			desc = "解释所选代码",
			mode = "v",
		},
		{
			fix_key,
			function()
				fix_context({ visual = false })
			end,
			desc = "优化当前文件",
			mode = "n",
		},
		{
			fix_key,
			function()
				fix_context({ visual = true })
			end,
			desc = "优化所选代码",
			mode = "v",
		},
	},
	opts = {
		keymaps = {
			toggle = nil, -- 不使用插件内置全局快捷键，统一交给 lazy keys 管理
			quit = quit_key,
		},
		border = "rounded",
		width = 0.38,
		height = 0.92,
		cmd = {
			"codex",
			"--no-alt-screen",
			"-s",
			"workspace-write",
			"-a",
			"on-request",
		},
		model = nil,
		autoinstall = false, -- 编辑器里弹包管理器选择不够顺手，缺失时直接提示手动安装更可控
		panel = true,
		use_buffer = false,
	},
	config = function(_, opts)
		require("codex").setup(opts)

		vim.api.nvim_create_user_command("CodexAsk", prompt_codex, {
			desc = "向 Codex 发起一个自定义问题",
		})

		vim.api.nvim_create_user_command("CodexResumeLast", resume_last_session, {
			desc = "恢复最近一次 Codex 会话",
		})

		vim.api.nvim_create_user_command("CodexExplain", function(command_opts)
			explain_context({ visual = command_opts.range > 0 })
		end, {
			desc = "让 Codex 解释当前文件或选区",
			range = true,
		})

		vim.api.nvim_create_user_command("CodexFix", function(command_opts)
			fix_context({ visual = command_opts.range > 0 })
		end, {
			desc = "让 Codex 优化当前文件或选区",
			range = true,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "codex",
			callback = function(args)
				set_codex_term_keymaps(args.buf)
			end,
		})
	end,
}
