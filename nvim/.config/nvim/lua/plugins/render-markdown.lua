return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		enabled = true,
		render_modes = { "n", "c", "t" },
		max_file_size = 10, -- Megabytes
		debounce = 100, -- Number of milliseconds that must pass before rendering markdown
		preset = "lazy", -- stay up to date with LazyVim config
		file_types = { "markdown", "codecompanion" },
		code = { sign = false },
		completions = { lsp = { enabled = true } },
		ignore = function()
			return false
		end, -- If this function returns true, this plugin will detach from buffer(disable)
	},
}
