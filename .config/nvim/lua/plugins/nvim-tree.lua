return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    vim.keymap.set("n", "<D-b>", ":NvimTreeToggle<cr>")
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
  end,
}
