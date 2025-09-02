local options = { noremap = true, silent = true }
local set = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO:
-- Figure out how to strip away the extension and make it dynamic
-- set('n', '<C-M-b>', [[<cmd>let save_view = winsaveview() | execute "update main.cpp | update inputf.in | update outputf.in" | call winrestview(save_view)<CR><cmd>!g++ % -o %:r && timeout 4 ./%:r < ./inputf.in > ./outputf.in<CR>]], { noremap = true, silent = true })
set("n", "<M-h>", "<C-w><C-h>")
set("n", "<M-j>", "<C-w><C-j>")
set("n", "<M-k>", "<C-w><C-k>")
set("n", "<M-l>", "<C-w><C-l>")

set("n", "<M-Left>", "<C-w>5<")
set("n", "<M-right>", "<C-w>5>")
set("n", "<M-up>", "<C-w>+")
set("n", "<M-down>", "<C-w>-")
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) up", silent = true })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) down", silent = true })

set(
	"n",
	"J",
	"mzJ`z",
	{ desc = "Joins(with space in between) line below cursor with line of cursor keeping cursor in place." }
)

set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls down half page with cursor centred" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls up half page with cursor centred" })

set("n", "n", "nzzzv", { desc = "Goes to next search result with cursor centred" })
set("n", "N", "Nzzzv", { desc = "Goes to previous search result with cursor centred" })

set("v", "<", "<gv", { desc = "indent selected line to right without desecting them" })
set("v", ">", ">gv", { desc = "indent selected line to left without desecting them" })

set("v", "<leader>p", [["_dP]], { desc = "Paste over selection without loosing pasted content from clipboard" })
set("v", "p", [["_dp]], options)

-- set({ "v", "n" }, "<leader>d", '"_d', { desc = "Delete and forget" })
set("i", "<C-c>", "<Esc>", { desc = "fuck the edge case" })
set("n", "<C-c>", ":nohl<CR>", { desc = "remove highlights from search", silent = true })

set("n", "x", [["_x]], { desc = "delete character under cursor without yanking", silent = true, noremap = true })
set("n", "X", [["_X]], { desc = "delete character before cursor without yanking", silent = true, noremap = true })

set("n", "<leader>ruc", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor globally" })
-- set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {desc="Make current buffer executable", noremap=true})

-- tab management
set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open a new tab" })
set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
set("n", "<leader>tn", "<cmd>tabNext<CR>", { desc = "Go to next tab" })
set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" })
set("n", "<leader>td", "<cmd>tabnew %<CR>", { desc = "Duplicate current tab:" })

-- Split screen management
set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
set("n", "<leader>se", "<C-w>=", { desc = "Equalize split" })
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

set("n", "<leader>yfp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("Filepath copied to clipboard: " .. filePath)
end, { desc = "Copy filepath of current file relative to home directory" })

set("n", "<leader>so", "<cmd>update<CR><cmd>source %<CR>", { desc = "Shoutout" })
set("n", "<leader>db", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })
-- set("n", "<C-`>", "<cmd>bot term<CR>", { desc = "Open bottom terminal" })
set("t", "<esc><esc>", "<c-\\><c-n>")

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "cpp",
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>cnr", function()
-- 			local file = vim.fn.expand("%:p")
-- 			local basename = vim.fn.expand("%:t:r")
-- 			vim.cmd("!g++" .. file .. " -o " .. basename .. " && " .. "./" .. basename)
-- 		end, { buffer = true, desc = "Compile CPP and run." })
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.keymap.set("n", "<leader>cnr", function()
			local file = vim.fn.expand("%:p")
			local basename = vim.fn.expand("%:t:r")
			-- Open a horizontal split terminal running g++
			vim.cmd("split | terminal !g++" .. file .. " -o " .. basename .. " && " .. "./" .. basename)
		end, { buffer = true, desc = "Compile C++ file (terminal)" })
	end,
})
set("n", "<M-z>", ":!zathura <C-r>=expand('%:r)<cr>.pdf & <cr>")

set("n", "j", "gj")
set("n", "k", "gk")
