return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set(
			"n",
			"<leader>ff",
			builtin.find_files,
			{ desc = "Lists files in your current working directory, respects .gitignore" }
		)
		-- local x =
		-- require("telescope.builtin").live_grep({ layout_strategy = "vertical", layout_config = { width = 0.5 } })
		vim.keymap.set(
			"n",
			"<leader>rg",
			":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<CR>",
			{
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)",
			}
		)
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Lists open buffers in current neovim instance" })
		vim.keymap.set(
			"n",
			"<leader>fh",
			builtin.help_tags,
			{ desc = "Lists available help tags and opens a new window with the relevant help info on <cr>" }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>fw",
			builtin.grep_string,
			{ desc = "Searches for the string under your cursor or selection in your current working directory" }
		)
		vim.keymap.set(
			"n",
			"<leader>fcmd",
			builtin.commands,
			{ desc = "Lists available plugin/user commands and runs them on <cr>" }
		)
		vim.keymap.set("n", "<leader>fold", builtin.oldfiles, { desc = "Lists previously open files" })
		vim.keymap.set(
			"n",
			"<leader>fch",
			builtin.command_history,
			{ desc = "Lists commands that were executed recently, and reruns them on <cr>" }
		)
		vim.keymap.set(
			"n",
			"<leader>fsh",
			builtin.search_history,
			{ desc = "Lists searches that were executed recently, and reruns them on <cr>" }
		)
		vim.keymap.set(
			"n",
			"<leader>fmp",
			builtin.man_pages,
			{ desc = "Lists manpage entries, opens them in a help window on <cr>" }
		)
		vim.keymap.set(
			"n",
			"<leader>fclr",
			builtin.colorscheme,
			{ desc = "Lists available colorschemes and applies them on <cr>" }
		)
		vim.keymap.set("n", "<leader>fqf", builtin.quickfix, { desc = "Lists items in the quickfix list" })
		vim.keymap.set(
			"n",
			"<leader>fopt",
			builtin.vim_options,
			{ desc = "Lists vim options, allows you to edit the current value on <cr>" }
		)
		vim.keymap.set(
			"n",
			"<leader>freg",
			builtin.registers,
			{ desc = "Lists vim registers, pastes the contents of the register on <cr>" }
		)
		vim.keymap.set(
			"n",
			"<leader>fau",
			builtin.autocommands,
			{ desc = "Lists vim autocommands and goes to their declaration on <cr>" }
		)
		vim.keymap.set("n", "<leader>ftyp", builtin.filetypes, { desc = "Lists all available filetypes" })
		vim.keymap.set("n", "<leader>fkmp", builtin.keymaps, { desc = "Lists normal mode keymappings" })
		vim.keymap.set(
			"n",
			"<leader>fib",
			builtin.current_buffer_fuzzy_find,
			{ desc = "Live fuzzy search inside of the currently open buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>lr",
			builtin.lsp_references,
			{ desc = "Lists LSP references for word under the cursor" }
		)
		vim.keymap.set(
			"n",
			"<leader>lsb",
			builtin.lsp_document_symbols,
			{ desc = "Lists LSP document symbols in the current buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>lsw",
			builtin.lsp_workspace_symbols,
			{ desc = "Lists LSP document symbols in the current workspace" }
		)
		vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, {
			desc = "Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope",
		})
		vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, {
			desc = "Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
		})
		vim.keymap.set("n", "<leader>ltd", builtin.lsp_type_definitions, {
			desc = "Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope",
		})
		vim.keymap.set("n", "<leader>ltd", builtin.lsp_type_definitions, {
			desc = "Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope",
		})
		vim.keymap.set("n", "<leader>fss", builtin.spell_suggest, {
			desc = "Lists spelling suggestions for the current word under the cursor, replaces word with selected suggestion on <cr>",
		})
		vim.keymap.set("n", "<leader>fgwc", builtin.git_commits, {
			desc = "Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h",
		})
		vim.keymap.set(
			"n",
			"<leader>fgbc",
			builtin.git_bcommits,
			{ desc = "Lists buffer's git commits with diff preview and checks them out on <cr>" }
		)
		vim.keymap.set("n", "<leader>fgb", builtin.git_branches, {
			desc = "Lists all branches with log preview, checkout action <cr>, track action <C-t>, rebase action<C-r>, create action <C-a>, switch action <C-s>, delete action <C-d> and merge action <C-y>",
		})
		vim.keymap.set(
			"n",
			"<leader>fgs",
			builtin.git_status,
			{ desc = "Lists current changes per file with diff preview and add action. (Multi-selection still WIP)" }
		)
		vim.keymap.set(
			"n",
			"<leader>fts",
			builtin.treesitter,
			{ desc = "Lists Function names, variables, ... using treesitter locals queries" }
		)
		vim.keymap.set("n", "<leader>tt", builtin.builtin, { desc = "Lists Built-in pickers and run them on <cr>" })
	end,
}
