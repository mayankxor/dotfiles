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
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function(args)
    vim.opt.makeprg = "g++ -Wall -O2 -std=c++11 % -o %:r"
    vim.keymap.set("n", "<leader>cnr", function()
      vim.cmd("make")
      vim.cmd("copen")
    end)
  end
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function(args)
--     vim.keymap.set("n", "<leader>cnr", function()
--       local file = vim.fn.expand("%:p")
--       local basename = vim.fn.expand("%:t:r")
--
--       vim.cmd("split")
--       vim.cmd("enew")
--
--       vim.fn.jobstart(
--         "echo 'Compiling...'; if g++ '"
--         .. file
--         .. "' -o '"
--         .. basename
--         .. "' -std=c++11 -Wall -O2; then clear; ./"
--         .. basename
--         .. "; fi",
--         {
--           term = true,
--           on_exit = function()
--             vim.schedule(function()
--               vim.cmd("stopinsert")
--               vim.cmd("checktime")
--             end)
--           end,
--         }
--       )
--
--       vim.cmd("startinsert")
--       -- local file = vim.fn.expand("%:p")
--       -- local basename = vim.fn.expand("%:t:r")
--       --
--       -- vim.cmd("split")
--       --
--       -- local cmd = string.format( "echo 'Compiling...'; if g++ '%s' -o '%s' -std=c++11 -Wall -O2; then clear; ./'%s'; fi", file, basename, basename)
--       --
--       -- vim.fn.termopen({ "sh", "-c", cmd }, {
--       --   on_exit = function()
--       --     vim.schedule(function()
--       --       vim.cmd("checktime")
--       --     end)
--       --   end,
--       -- })
--       --
--       -- vim.cmd("startinsert")
--     end, { buffer = args.buf, desc = "Compile and run cpp file" })
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function(args)
--     vim.keymap.set("n", "<leader>cnr", function()
--       local file = vim.fn.expand("%:p")
--       local basename = vim.fn.expand("%:t:r")
--       vim.cmd(
--         "split | terminal echo 'Compiling...'; if g++ '"
--         .. file
--         .. "' -o '"
--         .. basename
--         .. "' -std=c++11 -Wall -O2 ; then clear; ./"
--         .. basename
--         .. ";fi"
--       )
--       vim.cmd("startinsert")
--     end, { buffer = args.buf, desc = "Compile and run cpp file" })
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "term://*",
  callback = function()
    vim.o.signcolumn = "no"
    vim.o.number = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
    vim.keymap.set("n", "<leader>cnr", function()
      local file = vim.fn.expand("%:p")
      local basename = vim.fn.expand("%:t:r")
      vim.cmd(
        "split | terminal echo 'Compiling...'; if go build "
        .. "-o '"
        .. basename
        .. "' '" .. file .. "'; then clear; ./"
        .. basename
        .. ";fi"
      )
      vim.cmd("startinsert")
    end, { buffer = args.buf, desc = "Compile and run Go file" })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'rust',
    'go',
    'css',
    'javascript',
  },
  callback = function(ev)
    vim.treesitter.start(ev.buf)
    -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo[0][0].foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    vim.wo.foldenable = false
    vim.wo.foldlevel = 6
    vim.keymap.set("n", "zf", "zf", { desc = "Create fold (zf + motion)", noremap = true, silent = true })
    vim.keymap.set("n", "zd", "zd", { desc = "Delete fold under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zD", "zD", { desc = "Delete all folds in buffer", noremap = true, silent = true })
    vim.keymap.set("n", "zo", "zo", { desc = "Open fold under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zO", "zO", { desc = "Recursively open all folds under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zc", "zc", { desc = "Close fold under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zC", "zC", { desc = "Recursively close all folds under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zA", "zA", { desc = "Recursively toggle folds under cursor", noremap = true, silent = true })
    vim.keymap.set("n", "zr", "zr", { desc = "Open folds one level deeper", noremap = true, silent = true })
    vim.keymap.set("n", "zR", "zR", { desc = "Open all folds in buffer", noremap = true, silent = true })
    vim.keymap.set("n", "zm", "zm", { desc = "Close folds one level deeper", noremap = true, silent = true })
    vim.keymap.set("n", "zM", "zM", { desc = "Close all folds in buffer", noremap = true, silent = true })
    vim.keymap.set("n", "[z", "[z", { desc = "Jump to start of open fold", noremap = true, silent = true })
    vim.keymap.set("n", "]z", "]z", { desc = "Jump to end of open fold", noremap = true, silent = true })
  end,
})
