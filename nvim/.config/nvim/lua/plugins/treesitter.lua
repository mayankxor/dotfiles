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
			vim.wo.foldenable = false -- start everything unfolded
			vim.wo.foldlevel = 6 -- if foldenable is true, all lines with folds > this will be folded on buffer load
			vim.keymap.set("n", "zf", "zf", { desc = "Create fold (zf + motion)", noremap = true, silent = true }) -- doesnt work when foldmethod!=manual
			vim.keymap.set("n", "zd", "zd", { desc = "Delete fold under cursor", noremap = true, silent = true }) -- doesnt work when foldmethod!=manual
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
			vim.keymap.set("n", "[z", "[z", { desc = "Jump to start of open fold", noremap = true, silent = true }) -- may not work if foldexpr!=manual, use [[
			vim.keymap.set("n", "]z", "]z", { desc = "Jump to end of open fold", noremap = true, silent = true }) -- may not work if foldexpr!=manual, use ]]
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
          "rust",
          "java"
				},
				sync_install = false, -- dont halt the whole UI to download parsers
				auto_install = true, -- auto install missing parsers when a file is opened for it
				ignore_install = {},
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "gnn",
						node_decremental = "gpn",
						scope_incremental = "gns",
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
		end,
	},
}

