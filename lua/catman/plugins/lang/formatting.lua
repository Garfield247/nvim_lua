-- conform.nvim：轻量级代码格式化框架，支持多格式化器按文件类型配置，保存时自动格式化
return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- 禁用时注释掉此行
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters = {
        goctl_api = {
          command = "goctl",
          args = { "api", "format", "--stdin" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        -- Python 格式化：自动排序 import 块 (ruff_organize_imports)，并使用 ruff_format 格式化；缺失 ruff 时平滑退避使用 isort/black
        python = { "ruff_organize_imports", "ruff_format", "isort", "black", stop_after_first = true },
        -- Go 格式化：自动管理 import 并进行 gofmt 格式化
        go = { "goimports", "gofmt" },
        api = { "goctl_api" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "格式化文件或选中区域（可视模式）" })
  end,
}
