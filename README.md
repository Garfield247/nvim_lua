# Garfield's Neovim Configuration (Neovim 0.12+)

```text
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
||     󰄛    ██████╗  █████╗ ██████╗ ███████╗██╗███████╗██╗     ██████╗     ||
||         ██╔════╝ ██╔══██╗██╔══██╗██╔════╝██║██╔════╝██║     ██╔══██╗    ||
||   󰄛     ██║  ███╗███████║██████╔╝█████╗  ██║█████╗  ██║     ██║  ██║    ||
||         ██║   ██║██╔══██║██╔══██╗██╔══╝  ██║██╔══╝  ██║     ██║  ██║    ||
||         ╚██████╔╝██║  ██║██║  ██║██║     ██║███████╗███████╗██████╔╝    ||
||  󰄛       ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚═════╝     ||
||                                                                         ||
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
||                                                                         ||
||                     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ||
||                      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ||
||                      ██╔██╗ ██║█████╗  ██║ 󰄛 ██║██║   ██║██║██╔████╔██║ ||
||                      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ||
||                      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ||
||                      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ||
||                                                                         ||
||=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=||
```

<p align="center">
  <a href="https://dotfyle.com/Garfield247/nvimlua"><img src="https://dotfyle.com/Garfield247/nvimlua/badges/plugins?style=flat" /></a>
  <a href="https://dotfyle.com/Garfield247/nvimlua"><img src="https://dotfyle.com/Garfield247/nvimlua/badges/leaderkey?style=flat" /></a>
  <a href="https://dotfyle.com/Garfield247/nvimlua"><img src="https://dotfyle.com/Garfield247/nvimlua/badges/plugin-manager?style=flat" /></a>
</p>

基于 **Neovim 0.12+** 构建的高性能、现代化全栈开发配置。全面拥抱 Native LSP、基于 Rust 构建的超极速补全引擎 `blink.cmp`，并整合了 `fzf-lua`、`snacks.nvim` 等下一代核心插件。

---

## 🛠️ 架构与核心插件 Stack

- **语言服务 (Native LSP)**: 采用 Neovim 0.12 原生 `vim.lsp.config` & `vim.lsp.enable` 架构管理语言服务器。
- **自动补全 (Completion)**: `saghen/blink.cmp` - 超高性能 Rust 引擎，支持 Nerd Font v3 美化图标与三栏右对齐渲染。
- **模糊查找 (Picker)**: `ibhagwan/fzf-lua` - 极速文件、字符串及符号检索。
- **UI 基础设施 (UI Framework)**: `folke/snacks.nvim` - 整合 Dashboard 仪表盘、Notification 通知系统及大文件保护。
- **快速跳转 (Navigation)**: `folke/flash.nvim` - 极速代码块与光标定位。
- **格式化与校验 (Formatting & Lint)**: `stevearc/conform.nvim` 与 `mfussenegger/nvim-lint` 组合。
- **状态栏 (Statusline)**: `nvim-lualine/lualine.nvim` 自定义极简主题。

---

## 🐍 语言生态增强 (Language Ecosystem)

### Python 工具链深度集成
- **虚拟环境动态感知**: 自动探测 `uv` (`.venv`)、`pyenv` 及系统环境，自动绑定 LSP 解释器路径。
- **自动 Organize Imports**: 格式化时由 `ruff` 自动进行 `import` 语句排序与对齐。
- **状态栏环境显示**: 在 `lualine` 中实时高亮当前 Python 版本及激活的虚拟环境名称。

### Go & Web 工具链
- 整合 `gopls` / `golangci-lint` / `goimports` / `prettier` / `stylua` 等高效工具链。

---

## ⌨️ 常用快捷键速查 (Keymaps)

| 快捷键 | 功能描述 |
| :--- | :--- |
| **`<leader>ff`** | 模糊查找当前目录文件 (fzf-lua) |
| **`<leader>fs`** | 全局搜索字符串 (live_grep) |
| **`<leader>fb`** | 缓冲区列表切换 |
| **`<leader>fr`** | 最近打开的历史文件 |
| **`gd`** | 跳转到定义 (Definition) |
| **`gR`** | 查找所有引用 (References) |
| **`<leader>ca`** | 代码操作 (Code Action) |
| **`<leader>rn`** | 重命名变量/符号 (Rename) |
| **`<leader>mp`** | 格式化当前文件 / 选中区域 |
| **`<leader>d`** | 显示当前行 LSP 诊断 |
| **`<leader>yd`** | 一键复制当前行诊断报错至剪贴板 |
| **`s`** | Flash 极速光标跳转 |

---

## 📦 安装说明 (Installation)

```bash
# 1. 克隆配置文件仓库
git clone git@github.com:Garfield247/nvim_lua.git ~/.config/nvim

# 2. 启动 Neovim（自动安装与同步 Lazy 插件）
nvim
```
