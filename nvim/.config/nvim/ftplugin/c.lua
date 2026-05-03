-- Start the treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Build command
vim.keymap.set("n", "<leader>co", ':! gcc "%" -o "%:r" -O2 -Wall -Wpedantic -Werror && "./%:r"')
