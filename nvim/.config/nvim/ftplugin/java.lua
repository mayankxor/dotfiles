-- Start the treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Build command (Non interactive)
vim.keymap.set('n', '<leader>co', ':! javac "%" && java "%:r" <CR>')
