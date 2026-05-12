-- Start the treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	callback = function()
		vim.treesitter.start()
	end,
})

