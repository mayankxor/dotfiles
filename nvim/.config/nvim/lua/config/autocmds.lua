-- Sync OS clipboard to nvim clipboard
vim.api.nvim_create_autocmd("UIEnter", {
	desc = "Sync OS clipboard to nvim",
	callback = function()
		vim.opt.clipboard = "unnamedplus"
	end,
})

-- Show yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight parts of line being yanked",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
			on_macro = false,
			on_visual = true,
			event = vim.v.event,
			priority = vim.hl.priorities.user
		})
	end,
})
