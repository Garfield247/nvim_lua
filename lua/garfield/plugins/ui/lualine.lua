-- lualine.nvim：高度可定制的状态栏插件，显示模式、文件信息、Git 状态、诊断等
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- 用于显示 lazy 待更新数量

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		local python_env_cache = {}

		-- 自定义状态栏组件：动态提取 Python 版本号与当前激活的虚拟环境名称 (带缓存)
		local function get_python_env()
			if vim.bo.filetype ~= "python" then
				return ""
			end

			local buf = vim.api.nvim_get_current_buf()
			if python_env_cache[buf] then
				return python_env_cache[buf]
			end

			local root = vim.fs.root(buf, { "uv.lock", "pyproject.toml", ".venv", "venv", ".git" }) or vim.uv.cwd()
			local venv_name = ""
			local python_bin = ""

			local venv_dir = vim.fs.joinpath(root, ".venv")
			if vim.fn.isdirectory(venv_dir) == 1 then
				venv_name = ".venv"
				python_bin = vim.fs.joinpath(venv_dir, "bin", "python")
			else
				local alt_venv_dir = vim.fs.joinpath(root, "venv")
				if vim.fn.isdirectory(alt_venv_dir) == 1 then
					venv_name = "venv"
					python_bin = vim.fs.joinpath(alt_venv_dir, "bin", "python")
				elseif vim.env.VIRTUAL_ENV then
					venv_name = vim.fs.basename(vim.env.VIRTUAL_ENV)
					python_bin = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
				end
			end

			if python_bin == "" or vim.fn.executable(python_bin) ~= 1 then
				python_bin = vim.fn.exepath("python3") or "python"
			end

			local version_out = vim.fn.system({ python_bin, "--version" })
			local version = version_out:match("Python (%d+%.%d+%.%d+)") or version_out:match("Python (%d+%.%d+)") or ""

			local result = ""
			if venv_name ~= "" then
				result = string.format(" %s (%s)", version, venv_name)
			elseif version ~= "" then
				result = string.format(" %s", version)
			end

			python_env_cache[buf] = result
			return result
		end

		-- 使用自定义主题配置 lualine
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						get_python_env,
						cond = function()
							return vim.bo.filetype == "python"
						end,
						color = { fg = "#38bdf8", gui = "bold" },
					},
					require("action-hints").statusline,
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
