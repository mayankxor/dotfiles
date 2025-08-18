return {
	"folke/snacks.nvim",
	enabled = false,
	priority = 1000,
	lazy = false,
	opts = {
		explorer = {
			enabled = true,
			finder = "explorer",
			sort = { fields = { "sort" } },
			supports_live = true,
			tree = true,
			watch = true,
			diagnostics = true,
			diagnostics_open = false,
			git_status = true,
			git_status_open = false,
			git_untracked = true,
			follow_file = true,
			focus = "list",
			auto_close = false,
			jump = { close = false },
			layout = { preset = "sidebar", preview = true },
			-- to show the explorer to the right, add the below to
			-- your config under `opts.picker.sources.explorer`
			-- layout = { layout = { position = "right" } },
			formatters = {
				file = { filename_only = true },
				severity = { pos = "right" },
			},
			matcher = { sort_empty = false, fuzzy = false },
			config = function(opts)
				return require("snacks.picker.source.explorer").setup(opts)
			end,
			win = {
				list = {
					keys = {
						["<BS>"] = "explorer_up",
						["l"] = "confirm",
						["h"] = "explorer_close", -- close directory
						["a"] = "explorer_add",
						["d"] = "explorer_del",
						["r"] = "explorer_rename",
						["c"] = "explorer_copy",
						["m"] = "explorer_move",
						["o"] = "explorer_open", -- open with system application
						["P"] = "toggle_preview",
						["y"] = { "explorer_yank", mode = { "n", "x" } },
						["p"] = "explorer_paste",
						["u"] = "explorer_update",
						["<c-c>"] = "tcd",
						["<leader>/"] = "picker_grep",
						["<c-t>"] = "terminal",
						["."] = "explorer_focus",
						["I"] = "toggle_ignored",
						["H"] = "toggle_hidden",
						["Z"] = "explorer_close_all",
						["]g"] = "explorer_git_next",
						["[g"] = "explorer_git_prev",
						["]d"] = "explorer_diagnostic_next",
						["[d"] = "explorer_diagnostic_prev",
						["]w"] = "explorer_warn_next",
						["[w"] = "explorer_warn_prev",
						["]e"] = "explorer_error_next",
						["[e"] = "explorer_error_prev",
					},
				},
			},
		},
		picker = {
			enabled = true,
			layout = {
				cycle = false,
			},
		},
	},
	keys = {
		--   { "<leader>lg", function() require("snacks").lazygit() end, desc="activate lazygit"},
		--   {"<leader>gl", function() require("snacks").lazygit.log() end, desc="goto lazygit logs"},
		{
			"<C-n>",
			function()
				Snacks.explorer()
			end,
			desc = "goto explorer",
		},
		--   {"<leader>rn", function() require("snacks").rename.rename_file() end, desc="Rename current file"},
		--   {"<leader>db", function() require("snacks").bufdelete() end, desc="Delete or close buffer without confirmation"}
	},
}
