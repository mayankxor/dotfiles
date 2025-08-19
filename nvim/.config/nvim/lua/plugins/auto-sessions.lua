return {
	"rmagatti/auto-session",
	enabled = true,
	lazy = false,
	-- TODO:
	-- read readme and configure correctly
	--
	-- keys = {
	--   -- will use telescope if installed or a vim.ui.select picker otherwise
	--   { "<leader>wr", "<cmd>sessionsearch<cr>", desc = "session search" },
	--   { "<leader>ws", "<cmd>sessionsave<cr>", desc = "save session" },
	--   { "<leader>wa", "<cmd>sessiontoggleautosave<cr>", desc = "toggle autosave" },
	-- },
	---enables autocomplete for opts
	---@module "auto-session"
	---@type autosession.config
	config = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		require("auto-session").setup({
			enabled = true, -- enables/disables auto creating, saving and restoring
			root_dir = vim.fn.stdpath("data") .. "/sessions/", -- root dir where sessions will be stored
			auto_save = true, -- enables/disables auto saving session on exit
			auto_restore = true, -- enables/disables auto restoring session on start
			auto_create = false, -- enables/disables auto creating new session files. can take a function that should return true/false if a new session file should be created or not
			suppressed_dirs = nil, -- suppress session restore/create in certain directories
			allowed_dirs = nil, -- allow session restore/create in certain directories
			auto_restore_last_session = false, -- on startup, loads the last saved session if session for cwd does not exist
			git_use_branch_name = false, -- include git branch name in session name
			git_auto_restore_on_branch_change = false, -- should we auto-restore the session when the git branch changes. requires git_use_branch_name
			lazy_support = true, -- automatically detect if lazy.nvim is being used and wait until lazy is done to make sure session is restored correctly. does nothing if lazy isn't being used. can be disabled if a problem is suspected or for debugging
			bypass_save_filetypes = nil, -- list of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
			ignore_filetypes_on_save = { "checkhealth" }, -- list of filetypes to close buffers of before saving a session, ignores checkhealth by default
			close_unsupported_windows = true, -- close windows that aren't backed by normal file before autosaving a session
			args_allow_single_directory = true, -- follow normal session save/load logic if launched with a single directory as the only argument
			args_allow_files_auto_save = false, -- allow saving a session even when launched with a file argument (or multiple files/dirs). it does not load any existing session first. while you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. see documentation for more detail
			continue_restore_on_error = true, -- keep loading the session even if there's an error
			show_auto_restore_notif = true, -- whether to show a notification when auto-restoring
			cwd_change_handling = false, -- follow cwd changes, saving a session before change and restoring after
			lsp_stop_on_restore = false, -- should language servers be stopped when restoring a session. can also be a function that will be called if set. not called on autorestore from startup
			restore_error_handler = nil, -- called when there's an error restoring. by default, it ignores fold errors otherwise it displays the error and returns false to disable auto_save
			purge_after_minutes = nil, -- sessions older than purge_after_minutes will be deleted asynchronously on startup, e.g. set to 14400 to delete sessions that haven't been accessed for more than 10 days, defaults to off (no purging), requires >= nvim 0.10
			log_level = "error", -- sets the log level of the plugin (debug, info, warn, error).

			session_lens = {
				load_on_setup = true, -- initialize on startup (requires telescope)
				picker_opts = nil, -- table passed to telescope / snacks to configure the picker. see below for more information
				mappings = {
					-- mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = { "i", "<c-d>" },
					alternate_session = { "i", "<c-s>" },
					copy_session = { "i", "<c-y>" },
				},

				session_control = {
					control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- auto session control dir, for control files, like alternating between two sessions with session-lens
					control_filename = "session_control.json", -- file name of the session control file
				},
			},
		})
	end,
}
