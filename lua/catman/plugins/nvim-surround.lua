-- nvim-surround：快速添加、修改、删除成对符号（括号、引号、标签等）的文本操作插件
return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
