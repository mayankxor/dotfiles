return {
	{
		"ibhagwan/fzf-lua",
		enabled = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"andrew-george/telescope-themes",
			-- "nvim-lua/popup.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			-- "nvim-telescope/telescope-z.nvim"
			"xiyaowong/telescope-emoji.nvim",
		},
		-- DONE:
		-- install treesitter
		-- add extensions
		-- TODO:
		-- READ README AND COMPLETE DEFAULT CONFIG
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")
			local open_with_trouble = require("trouble.sources.telescope").open
			local builtin = require("telescope.builtin")
			local sorters = require("telescope.sorters")
			local add_to_trouble = require("trouble.sources.telescope").add -- Add items to Trouble without clearing the list
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-t>"] = open_with_trouble,
							["<C-/>"] = "which_key",
						},
						n = { ["<C-t>"] = open_with_trouble },
					},
					scroll_strategy = "cycle",
					winblend = 0,
					wrap_results = false,
					prompt_prefix = " ",
					selection_caret = " ",
					-- entry_prefix=' ',
					multi_icon = " ",
					initial_mode = "insert",
					border = true,
					path_display = { "tail" },
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					hl_result_eol = false,
					dynamic_preview_title = false,
					results_title = false,
					prompt_title = false,
					default_mappings = nil,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					color_devicons = true,
					-- file_sorter = sorters.get_fzy_sorter,
					-- generic_sorter = sorters.get_fzy_sorter,
					-- prefilter_sorter = sorters.prefilter,
					-- tiebreak=false,
					file_ignore_patterns = nil,
					get_selection_window = function()
						return 0
					end,
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
					buffer_previewer_maker = previewers.buffer_previewer_maker,
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					themes = {
						enable_previewer = true,
						enable_live_preview = true,
						ignore = {},
						light_themes = {
							ignore = false,
						},
						dark_themes = {
							ignore = false,
						},
						persist = {
							enabled = true,
							path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
						},
					},
					-- media_files = {
					--   filetypes = { "png", "jpg", "webp", "webm", "jpeg", "mp4", "pdf" },
					--   find_cmd = "rg"
					-- },
					emoji = {
						action = function(emoji)
							vim.fn.setreg("*", emoji.value)
							vim.api.nvim_put({ emoji.value }, "c", false, true)
						end,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("themes")
			-- telescope.load_extension("media_files")
			-- telescope.load_extension("z")
			telescope.load_extension("emoji")
			telescope.load_extension("ui-select")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
			vim.keymap.set("n", "<leader>fcf", function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end)
			vim.keymap.set("n", "<leader>gf", builtin.live_grep, { desc = "live grep files" })
			vim.keymap.set("n", "<leader>fbf", builtin.buffers, { desc = "find files in buffer" })
			vim.keymap.set("n", "<leader>fht", builtin.help_tags, { desc = "Telescope help files" })
			vim.keymap.set("n", "<leader>gs", builtin.grep_string, { desc = "Grep string under cursor" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find previously opened files" })
			vim.keymap.set(
				"n",
				"<leader>fca",
				builtin.commands,
				{ desc = "List commands available and add them to command prompt on <CR>" }
			)
			vim.keymap.set(
				"n",
				"<leader>fch",
				builtin.command_history,
				{ desc = "Find command history and run them on <CR>" }
			)
			vim.keymap.set(
				"n",
				"<leader>fsh",
				builtin.search_history,
				{ desc = "Find search history and runs them on <CR>" }
			)
			vim.keymap.set("n", "<leader>fmp", builtin.man_pages, { desc = "Find man pages and run them on <CR>" })
			vim.keymap.set("n", "<leader>fth", "<cmd>Telescope themes<CR>", { desc = "Find and enable a colorscheme" })
			vim.keymap.set("n", "<leader>fvo", builtin.vim_options, { desc = "List Vim options and edit them at <CR>" })
			vim.keymap.set(
				"n",
				"<leader>freg",
				builtin.registers,
				{ desc = "Show all registers and paste selected's content on <CR>" }
			)
			vim.keymap.set("n", "<leader>fau", builtin.autocommands, { desc = "List autocommands" })
			vim.keymap.set("n", "<leader>fsc", builtin.spell_suggest, { desc = "Spell suggest and replace on <CR>" })
			vim.keymap.set("n", "<leader>fkmp", builtin.keymaps, { desc = "Lists keymaps" })
			vim.keymap.set(
				"n",
				"<leader>cft",
				builtin.filetypes,
				{ desc = "change filetype for current file and install its treesitter" }
			)
			vim.keymap.set("n", "<leader>gcb", builtin.current_buffer_fuzzy_find, { desc = "grep in current buffer" })
			vim.keymap.set("n", "<leader>fe", "<cmd>Telescope emoji<CR>", { desc = "Find emojis" })

			-- vim.keymap.set('n', '<leader>gh', function() require("telescope.builtin").live_grep({ prompt_title = "Grep Help Files", search_dirs = { vim.fn.stdpath("config") .. "/doc", vim.fn.stdpath("data") .. "/lazy", vim.env.VIMRUNTIME .. "/doc", }, }) end, { desc = "Grep through help files" } )
		end,
	},
}
