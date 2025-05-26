return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    lazy = false, -- set to true if you prefer lazy loading
    config = function()
      require("nvim-tree").setup({
        -- your nvim-tree configuration here
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
      })
    end,
  },
}

