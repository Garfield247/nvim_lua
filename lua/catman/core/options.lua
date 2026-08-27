-- 禁用不需要的 provider，消除 checkhealth 警告
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt -- 简写

-- 行号
opt.relativenumber = true -- 显示相对行号
opt.number = true -- 当前行显示绝对行号（开启相对行号时）

-- 制表符与缩进
opt.tabstop = 4 -- 制表符显示为 4 个空格
opt.shiftwidth = 4 -- 缩进宽度 4 个空格
opt.expandtab = true -- 将 Tab 展开为空格
opt.autoindent = true -- 新行继承当前行缩进
opt.smarttab = true
opt.smartindent = true -- 智能缩进

-- 换行
opt.wrap = true -- 启用自动换行

-- 搜索
opt.incsearch = true
opt.ignorecase = true -- 搜索时忽略大小写
opt.smartcase = true -- 若搜索含大写则区分大小写
opt.inccommand = "split" -- 开启 Sublime 级的单文件替换实时预览（在分屏中边打字边动态展示替换前后效果）

-- 光标行
opt.cursorline = true -- 高亮当前光标所在行

-- 外观
-- 启用真彩色（需 iTerm2 等支持真彩的终端）
opt.termguicolors = true
opt.background = "dark" -- 深色主题
opt.signcolumn = "yes" -- 显示标记列，避免文字抖动

-- 退格
opt.backspace = "indent,eol,start" -- 退格可删除缩进、行尾、插入起始位置

-- 剪贴板
opt.clipboard:append("unnamedplus") -- 使用系统剪贴板作为默认寄存器

-- 分屏
opt.splitright = true -- 垂直分屏时新窗口在右侧
opt.splitbelow = true -- 水平分屏时新窗口在下方

-- 关闭交换文件
opt.swapfile = false
opt.autoread = true -- 文件被外部工具修改后允许自动重新读取

opt.iskeyword:append("-") -- 将 string-string 视为一个单词

opt.showcmd = true
opt.wildmenu = true
opt.shortmess:append("I") -- 关闭内置启动 intro，避免与 dashboard 启动页闪屏切换

-- 体验优化
opt.scrolloff = 8        -- 光标距屏幕边缘保留 8 行
opt.updatetime = 250     -- 更快触发 CursorHold（影响 LSP hover 延迟）
opt.timeoutlen = 300     -- which-key 弹出更快
opt.undofile = true      -- 持久化撤销历史（配合 undotree 更好用）
