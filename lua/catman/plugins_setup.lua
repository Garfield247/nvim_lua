-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])
-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- 插件列表
return packer.startup(function(use)
	-- packer自身
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("tanvirtin/monokai.nvim")
	use("sainnhe/gruvbox-material")
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- 图标
	use("kyazdani42/nvim-web-devicons")
	-- 文件浏览器
	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})
	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
	})

	-- 状态栏
	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- FZF支持
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- 启动画面
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	-- 自动补全
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("onsails/lspkind-nvim")
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/cmp-cmdline")
	-- 代码片段补全
	use("hrsh7th/cmp-vsnip")
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	--For vsnip users.
	use("hrsh7th/vim-vsnip")
	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({ "glepnir/lspsaga.nvim", branch = "main", requires = "kyazdani42/nvim-web-devicons" }) -- enhanced lsp uis
	-- use({ "kkharji/lspsaga.nvim" })
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- Golang support
	use({
		"olexsmir/gopher.nvim",
		requires = { -- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	})
	-- use("fatih/vim-go")
	-- use("ray-x/go.nvim")
	-- use("ray-x/guihua.lua")
	--debug
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("leoluz/nvim-dap-go")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but s
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- 彩虹括号
	use("p00f/nvim-ts-rainbow")
	if packer_bootstrap then
		require("packer").sync()
	end
	-- git blame
	use("f-person/git-blame.nvim")
	--lazygit
	use("kdheepak/lazygit.nvim")
	-- terminal
	use("akinsho/toggleterm.nvim")
	use({ "michaelb/sniprun", run = "bash ./install.sh 1" })
end)
