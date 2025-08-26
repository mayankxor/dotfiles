return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		branch = "master",
		config = function()
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldenable = false -- start everything unfolded
			vim.wo.foldlevel = 6 -- if foldenable is true, all lines with folds > this will be folded on buffer load
			vim.keymap.set("n", "zf", "zf", { desc = "Create fold (zf + motion)", noremap = true, silent = true })
			vim.keymap.set("n", "zd", "zd", { desc = "Delete fold under cursor", noremap = true, silent = true })
			vim.keymap.set("n", "zD", "zD", { desc = "Delete all folds in buffer", noremap = true, silent = true })
			vim.keymap.set("n", "zo", "zo", { desc = "Open fold under cursor", noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"zO",
				"zO",
				{ desc = "Recursively open all folds under cursor", noremap = true, silent = true }
			)
			vim.keymap.set("n", "zc", "zc", { desc = "Close fold under cursor", noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"zC",
				"zC",
				{ desc = "Recursively close all folds under cursor", noremap = true, silent = true }
			)
			vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor", noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"zA",
				"zA",
				{ desc = "Recursively toggle folds under cursor", noremap = true, silent = true }
			)
			vim.keymap.set("n", "zr", "zr", { desc = "Open folds one level deeper", noremap = true, silent = true })
			vim.keymap.set("n", "zR", "zR", { desc = "Open all folds in buffer", noremap = true, silent = true })
			vim.keymap.set("n", "zm", "zm", { desc = "Close folds one level deeper", noremap = true, silent = true })
			vim.keymap.set("n", "zM", "zM", { desc = "Close all folds in buffer", noremap = true, silent = true })
			vim.keymap.set("n", "[z", "[z", { desc = "Jump to start of open fold", noremap = true, silent = true })
			vim.keymap.set("n", "]z", "]z", { desc = "Jump to end of open fold", noremap = true, silent = true })
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"python",
					"vim",
					"bash",
					"javascript",
					"html",
					"css",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
					disable = {},
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						node_decremental = "grm",
						scope_incremental = "grc",
					},
				},
				indent = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
				},
			})
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.tsqx = {
				install_info = {
					url = "https://github.com/extouchtriangle/tree-sitter-tsqx", -- local path or git repo
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					branch = "main", -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
				filetype = "tsqx", -- if filetype does not match the parser name
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		enabled = false,
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.api.nvim_set_hl(0, "TreeSitterContextBottom", {
				underline = true,
				sp = "Grey",
			})
			vim.api.nvim_set_hl(0, "TreeSitterContextLineNumberBottom", {
				underline = true,
				sp = "Grey",
			})
		end,
	},
}
