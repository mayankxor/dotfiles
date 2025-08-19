return {
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				buftypes = {},
				user_commands = true,
				lazy_load = true,
				user_default_options = {
					names = true, -- vim.api.nvim_get_color_map()
					names_opts = {
						lowercase = true, -- highlight blue
						camelcase = true, -- highlight Blue
						uppercase = true, -- highlight BLUE
						strip_digits = true, -- dont highlight blue2213
					},
					names_custom = {}, -- Example: { cool = "#107dac", ["notcool"] = "#ee9240" }
					RGB = true, -- RGB hex codes
					RGBA = true, -- RGBA hex codes
					RRGGBB = true, -- RRGGBB hex codes
					RRGGBBAA = false, -- RRGGBBAA hex codes
					rgb_fn = true, -- rgb() and rgba() functions
					hsl_fn = true, -- hsl() and hsla() functions
					css = false, -- Enable all CSS *features*:
					-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
					tailwind = false, -- Enable tailwind colors
					tailwind_opts = { -- Options for highlighting tailwind names
						update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
					},
					sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
					xterm = true, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
					-- Highlighting mode.  'background'|'foreground'|'virtualtext'
					mode = "background", -- Set the display mode
					-- Virtualtext character to use
					virtualtext = "■",
					-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
					virtualtext_inline = true,
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false,
					-- hooks to invert control of colorizer
					hooks = {
						-- called before line parsing.  Accepts boolean or function that returns boolean
						-- see hooks section below
						disable_line_highlight = false,
					},
				},
			})
		end,
	},
}
