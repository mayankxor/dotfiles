vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight parts of lines being yanked",
	callback = function()
		vim.hl.on_yank()
	end,
})
