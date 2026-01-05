return {
  "ghillb/cybu.nvim",
  config = function()
    require("cybu").setup()
    -- Map your keys here (e.g., using Alt+Left/Right or Ctrl+Tab if your terminal supports it)
    vim.keymap.set("n", "<S-Tab>", "<Plug>(CybuPrev)")
    vim.keymap.set("n", "<Tab>", "<Plug>(CybuNext)")
  end,
}
