vim.cmd("let g:netrw_banner=0") -- disable netrw banner
local opt = vim.opt

opt.nu = true -- line numbers
opt.relativenumber = true -- enable relative numbering

-- One tab is 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.autoindent = true -- get indentation from previous line
opt.smartindent = true -- } will get same indentation as corresponding {.
opt.wrap = true -- word wrapping
opt.swapfile = false -- no swap files
opt.backup = false -- no backup files
opt.undofile = true -- persistent undo
opt.incsearch = true -- keep incrementing search when args change
opt.inccommand = "split" -- show a panel of results for %s
opt.ignorecase = true -- ignore search case
opt.smartcase = true -- dont ignore case when args have atleast one uppercase character
opt.termguicolors = true -- use 24bit colors
opt.background = "dark"
opt.scrolloff = 3 -- keep a 3 lines padding when scrolling
opt.signcolumn = "yes" -- show a gutter at left for diagnostics
opt.backspace = { "indent", "eol", "start" } -- allow backspace over these items
opt.splitright = true --:vsplit will add buffer to right
opt.splitbelow = true --:split will add buffer to bottom
opt.isfname:append("@-@") -- files with '-' in their name are also considered filenames
opt.updatetime = 4000 -- if nothing happens for this many ms, swapfile is generated(given opt.swapfile is true) and CursorHold event is also generated
opt.colorcolumn = "0" -- show a colored column, 0->no column
opt.hlsearch = true -- highlights search results
opt.cursorline = true -- highlights line cursor is at
opt.list = false -- shows tabs and spaces with '>' and '-'
opt.confirm = false -- ask if the user would like to save an unsaved file when exiting, if false, it just notifies that file is unsaved
opt.autoread = true -- read when files are changed outside nvim
opt.fileignorecase = true -- ignore casing when using filenames
opt.endofline = false -- appends <EOL> for last line
opt.endoffile = false -- appends <C-z> at end of file
opt.mousehide = true -- hide mouse pointer when typing(for gvim)
opt.shell = "/usr/bin/zsh" -- shell to use for :!
opt.ruler = true -- show line coordinates in statusline
opt.smoothscroll = false -- show >>> when lines are wrapped
opt.spell = false -- spell checking
opt.timeout = true -- if no continued key is pressed after some key, its discarded
opt.timeoutlen = 1000 -- if no continued key is pressed after this many ms, the key is discarded
opt.title = false -- let nvim decide title fo window
opt.mouse = "nvic" -- mouse support for modes: normal(n), visual(v), insert(i), command line(c). Use Shift to disable temporarily
vim.g.editorconfig = true -- look for .editorconfig files in directory for extra config(for public projects)

-- disable external ruby, perl, node, python dev files check in :checkhealth
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = true,
	virtual_lines = false,
})
opt.showmode = true -- show the current mode in cmdline
opt.cmdheight =0 -- height of command line

-- ui2 shows command line when required, otherwise its invisible
require("vim._core.ui2").enable({
	enable = true, -- Whether to enable or disable the UI.
	msg = { -- Options related to the message module.
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "cmd",
		cmd = { -- Options related to messages in the cmdline window.
			height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
		},
		dialog = { -- Options related to dialog window.
			height = 0.5, -- Maximum height.
		},
		msg = { -- Options related to msg window.
			height = 0.5, -- Maximum height.
			timeout = 4000, -- Time a message is visible in the message window.
		},
		pager = { -- Options related to message window.
			height = 1, -- Maximum height.
		},
	},
})

opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
opt.shortmess:append("I") -- remove initial splash screen
