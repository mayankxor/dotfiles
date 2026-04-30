require("config.lazy")
require("config.options")
require("config.keymaps")
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("lazy").update({ show = false })
	end,
})
