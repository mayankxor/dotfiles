vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight parts of lines being yanked",
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function(args)
		vim.keymap.set("n", "<leader>cnr", function()
			local file = vim.fn.expand("%:p")
			local basename = vim.fn.expand("%:t:r")
			vim.cmd(
				"split | terminal echo 'Compiling...'; if gcc '"
					.. file
					.. "' -o '"
					.. basename
					.. "' -std=c17 -O2 -Wall -Wpedantic -Wextra -Wshadow -Wconversion -Wformat=2 -Wundef ; then clear; ./"
					.. basename
					.. ";fi"
			)
			vim.cmd("startinsert")
		end, { buffer = args.buf, desc = "Compile and run C file" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function(args)
		vim.keymap.set("n", "<leader>cnr", function()
			local file = vim.fn.expand("%:p")
			local basename = vim.fn.expand("%:t:r")
			vim.cmd(
				"split | terminal echo 'Compiling...'; if g++ '"
					.. file
					.. "' -o '"
					.. basename
					.. "' -std=c++17 -O2 -Wall -Wpedantic -Wextra -Wshadow -Wconversion -Wformat=2 -Wundef ; then clear; ./"
					.. basename
					.. ";fi"
			)
			vim.cmd("startinsert")
		end, { buffer = args.buf, desc = "Compile and run C++ file" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		vim.keymap.set("n", "<leader>cnr", function()
			local file = vim.fn.expand("%:p")
			local basename = vim.fn.expand("%:t:r")
			vim.cmd(
				"split | terminal echo 'Compiling...'; if javac -Xlint:all -Werror '"
					.. file
					.. "'; then clear; java "
					.. basename
					.. ";fi"
			)
			vim.cmd("startinsert")
		end, { buffer = args.buf, desc = "Compile and run Java file" })
	end,
})
