vim.opt.number = true
--vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.o.wrap = false
vim.o.wrap = false

vim.diagnostic.config {
  virtual_text = {
    prefix = "\t●",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}










