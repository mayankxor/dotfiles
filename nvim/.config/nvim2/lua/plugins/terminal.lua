return {
	"akinsho/toggleterm.nvim",
	enabled = true,
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-`>]],
			hide_numbers = true,
			shade_filetypes = {},
			autochdir = false,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "horizontal", -- vertical | horizontal | float | tab
			close_on_exit = true,
			clear_env = false,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = "curved",
				winblend = 3,
				title_pos = "center",
			},
			winbar = {
				enabled = false,
				name_formatter = function(term)
					return term.name
				end,
			},
			responsiveness = {
				horizontal_breakpoint = 135,
			},
		})
	end,
}
