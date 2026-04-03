-- vim-maximizer：一键最大化/还原当前分屏窗口，方便临时专注单个窗口
return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}
