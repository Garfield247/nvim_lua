-- nvim-web-devicons：为文件类型提供 Nerd Font 图标，供 nvim-tree、lualine 等插件使用
return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").set_icon({
      gql = {
        icon = "",
        color = "#e535ab",
        cterm_color = "199",
        name = "GraphQL",
      },
    })
  end,
}
