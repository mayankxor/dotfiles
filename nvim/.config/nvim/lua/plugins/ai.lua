return {
	-- TODO: Get this shit to work
	--
	-- TODO: Find some free ai
	--
	-- OPTIM: vim is getting slow(prolly cuz ai)
	--
	-- TODO: Find a functional notify plugin
	"olimorris/codecompanion.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"github/copilot.vim",
		enabled = true,
		config = function()
			vim.cmd("Copilot disable")
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,
		vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)"),
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "solarized",
			-- group = ...,
			callback = function()
				vim.api.nvim_set_hl(0, "CopilotSuggestion", {
					fg = "#555555",
					ctermfg = 8,
					force = true,
				})
			end,
		}),
	},
}
