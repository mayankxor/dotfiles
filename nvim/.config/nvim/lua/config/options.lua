vim.cmd("let g:netrw_banner=0") -- disable netrw banner
local opt = vim.opt

opt.nu = true -- enable line numbers
opt.relativenumber = true -- enable relative line numbers

opt.tabstop = 2 -- 1 <TAB> = 2 spaces(visually)
opt.softtabstop = 2
opt.shiftwidth = 2 -- 2 spaces as autoindent
opt.expandtab = true -- use tabs instead of spaces
opt.autoindent = true -- indentation same as previous line
opt.smartindent = true -- indentation based upon identifiers like if and while and braces{}()[]. Most useful for C type languages
opt.wrap = true -- word wrapping

opt.swapfile = false -- disable creation of swapfile while editing
opt.backup = false -- makes no backup files
opt.undofile = true -- enables undoing file even after reloading nvim

opt.incsearch = true -- shows search highlights while typing
opt.inccommand = "split" -- shows a separate panel at bottom containing lines that match the search while substituting using %s
opt.ignorecase = true -- ignores cases while searching or substituting
opt.smartcase = true -- dont ignore cases when searching string contains atleast one upper case character

opt.termguicolors = true -- use 24 BIT colors
opt.background = "dark" -- NEVER USE LIGHT
opt.scrolloff = 3 -- while scrolling, keep a 3 lines padding
opt.signcolumn = "yes" -- show extra column for diagnostics at all times

opt.backspace = { "indent", "eol", "start" } -- allows backspace to delete content in indent, beyond line and beyond the position insert mode was activated from

opt.splitright = true -- :vsplit will add buffer to right
opt.splitbelow = true -- :split will add buffer to left

opt.isfname:append("@-@") -- files will "-" in their name are considered filenames
opt.updatetime = 50 -- cursorhold events are triggered after 50ms of inactivity
opt.colorcolumn = "80" -- visually enforce line limit length of 80 columns

-- Sync OS clipboard to nvim clipboard (Set it after UI attach to not increase startup time)
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		opt.clipboard = "unnamedplus"
	end,
})
opt.hlsearch = true
opt.cursorline = false -- Highlights the line cursor is at
opt.list = false -- Show tabs and spaces
opt.confirm = false -- Instead of telling that file is unsaved upon :q, ask if you'd like to save it.
opt.autoread = true -- read files when changed externally
opt.fileignorecase = true -- Ignore casing when using file names
opt.endofline = false -- Add <EOL> for last line of file
opt.endoffile = false -- Write <CTRL-Z> at the end of file
opt.mousehide = true -- hide mouse pointer while typing
opt.shell = "/bin/zsh" -- shell used in terminal mode and command line
opt.ruler = false -- shown by lualine
opt.smoothscroll = true -- Scroll screen line wise when scrolling through wrapped lines
opt.spell = false -- spell checking
opt.timeout = true -- set a timeout for incomplete commands
opt.timeoutlen = 1000 -- 1000 milliseconds(1 second) of timeout
opt.title = false -- let vim select title of window

-- Show yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight parts of lines being yanked",
	callback = function()
		vim.hl.on_yank()
	end,
})

opt.mouse = "a"
vim.g.editorconfig = false -- consistent formatting across filetypes. Prefer off, may turn on for public projects.

-- Handled by Telescope
-- vim.cmd[[colorscheme tokyonight]]

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
vim.o.showmode = false

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "ron",
-- 	callback = function()
-- 		vim.bo.commentstring = "// %s"
-- 	end,
-- })

vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon0-TermCursor"
