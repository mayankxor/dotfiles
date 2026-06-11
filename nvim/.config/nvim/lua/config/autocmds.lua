-- Sync OS clipboard to nvim clipboard
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Sync OS clipboard to nvim",
  callback = function()
    vim.opt.clipboard = "unnamedplus"
  end,
})

-- Show yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight parts of line being yanked",
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 150,
      on_macro = false,
      on_visual = true,
      event = vim.v.event,
      priority = vim.hl.priorities.user,
    })
  end,
})

vim.api.nvim_create_autocmd(
  "QuickFixCmdPost",
  { desc = "Whenever using vimgrep, automatically open qflist", pattern = "vimgrep", command = "copen" }
)
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
        .. "' -std=c17 -Wall -Wpedantic -Wextra -Wshadow -Wconversion -Wformat=2 -Wundef ; then clear; ./"
        .. basename
        .. ";fi"
      )
      vim.cmd("startinsert")
    end, { buffer = args.buf, desc = "Compile and run C file" })
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "term://*",
  callback = function()
    vim.o.signcolumn = "no"
  end
})
