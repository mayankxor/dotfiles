local set = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move through splits using <m-h/j/k/l>
set("n", "<m-h>", "<c-w><c-h>", { desc = "Move to left pane" })
set("n", "<m-j>", "<c-w><c-j>", { desc = "Move to down pane" })
set("n", "<m-k>", "<c-w><c-k>", { desc = "Move to up pane" })
set("n", "<m-l>", "<c-w><c-l>", { desc = "Move to right pane" })

-- Resize splits sing <m-left/right/up/down>
set("n", "<m-left>", "<c-w>5<", { desc = "Make the split horizontally smaller by 5 points" })
set("n", "<m-S-left>", "<c-w><", { desc = "Make the split horizontally smaller by 1 point" })
set("n", "<m-right>", "<c-w>5>", { desc = "Make the split horizontally larger by 5 points" })
set("n", "<m-S-right>", "<c-w>>", { desc = "Make the split horizontally larger by 1 point" })
set("n", "<m-up>", "<c-w>+", { desc = "Make the split vertically larger by 1 point" })
set("n", "<m-down>", "<c-w>-", { desc = "Make the split vertically smaller by 1 point" })

-- Move selected lines up and down respecting environment's indentation
set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selected lines(in visual mode) down 1 line keeping indentation" })
set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selected lines(in visual mode) down 1 line keeping indentation" })

-- Indent selected line without deselecting them
set("v", "<", "<gv", { desc = "Indent selected line to left without deselecting them" })
set("v", ">", ">gv", { desc = "Indent selected line to right without deselecting them" })

-- Scroll with cursor centered
set("n", "<c-d>", "<c-d>zz", { desc = "Scroll half a page down with cursor centered" })
set("n", "<c-u>", "<c-u>zz", { desc = "Scroll half a page up with cursor centered" })

-- Clipboard control
set("n", "x", [["_x]], { desc = "Remove character from under the cursor without yanking it" })
set("n", "X", [["_X]], { desc = "Remove character from under the cursor without yanking it" })

-- Replace under cursor
set(
	"n",
	"<leader>ruc",
	[[:%s/\<<c-r><c-w>\>//gI<left><left><left>]],
	{ desc = "Substitute word under cursor throughout the buffer" }
)
set(
	"v",
	"<leader>ruc",
	[[:<bs><bs><bs><bs><bs>%s/<c-r>=getline("'<")[col("'<")-1 : col("'>")-1]<cr>//gI<left><left><left>]],
	{ desc = "Substitute data selected throughout the buffer(doesnt work for multiline selection)" }
)

-- tab management
set("n", "to", "<cmd>tabnew<cr>", { desc = "Open a new tab" })
set("n", "tx", "<cmd>tabclose<cr>", { desc = "Close the tab" })
set("n", "tn", "<cmd>tabnext<cr>", { desc = "Go to next tab" })
set("n", "tp", "<cmd>tabprevious<cr>", { desc = "Go to previous tab" })
set("n", "td", "<cmd>tabnew %<cr>", { desc = "Duplicate the current tab" })

-- split screen management
set("n", "sv", "<c-w>v", { desc = "Make a vertical split" })
set("n", "sh", "<c-w>s", { desc = "Make a horizontal split" })
set("n", "se", "<c-w>=", { desc = "Equalize splits" })
set("n", "sx", "<cmd>close<cr>", { desc = "Close split" })

-- smoother navigation
set("n", "j", "gj")
set("n", "k", "gk")

-- Miscellaneous
set("n", "<c-c>", "<cmd>nohl<cr>", { desc = "Remove search highlights from buffer", silent = true })
set(
	"n",
	"<leader>x",
	"<cmd>silent !chmod +x %<cr><cmd>lua print('Current buffer is now executable')<cr>",
	{ desc = "Make current buffer executable" }
)
set(
	"n",
	"so",
	"<cmd>silent update<cr><cmd>source %<cr><cmd>lua print('File sourced')<cr>",
	{ desc = "Source the current buffer" }
)
set("n", "<leader>db", "<cmd>bdelete<cr>", { desc = "Remove current saved buffer from memory" })
set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit from terminal mode" })
set(
	"n",
	"J",
	"mzJ`z",
	{ desc = "Does what 'J' does but keeps the cursor in place instead of moving it to beginning of next line" }
)
set("n", "<leader>ex", "<cmd>Ex<cr>", { desc = "Open file explorer" })
set("n", "<m-tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
