-- Start the treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c" },
	callback = function()
		vim.treesitter.start()
	end,
})

