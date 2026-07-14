local hl = vim.api.nvim_get_hl(0, { name = "Keyword" })
hl.italic = true
vim.api.nvim_set_hl(0, "Keyword", hl)

hl = vim.api.nvim_get_hl(0, { name = "Statement" })
hl.italic = true
vim.api.nvim_set_hl(0, "Statement", hl)
