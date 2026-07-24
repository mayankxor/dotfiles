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
  callback = function()
    vim.keymap.set("n", "<leader>cnr", function()
      local filename = vim.fn.expand("%:p")
      local basename = vim.fn.expand("%:r")
      local scratch_buffer = vim.api.nvim_create_buf(false, true)
      local warningcount = 0
      local errorcount = 0
      local errorandwarninglinenumber = 0

      -- Highlight Groups
      vim.api.nvim_set_hl(0, "CompilerHeadingErrorAndWarnings", {
        fg = "#DC143C",
        bold = true,
        underline = true,
      })
      vim.api.nvim_set_hl(0, "PathsHighlightError", {
        fg = "#FFB4B4",
        bg = "#4A1515",
        bold = true
      })

      vim.api.nvim_set_hl(0, "PathsHighlightWarning", {
        fg = "#FFD27F",
        bg = "#4A3510",
        bold = true
      })
      vim.api.nvim_set_hl(0, "LineNumberHighlightError", {
        fg = "#E09D7D"
      })
      vim.api.nvim_set_hl(0, "MarkerHighlight", {
        fg = "#DC143C",
        bold = true,
        underline = true,
      })
      vim.api.nvim_set_hl(0, "QuotesHighlight", {
        bold = true
      })

      -- Procedure
      vim.cmd("split")
      vim.cmd("enew")
      vim.api.nvim_win_set_buf(0, scratch_buffer)
      vim.keymap.set("n", "<CR>", function()
        vim.api.nvim_buf_delete(scratch_buffer, { force = true, })
      end, { buf = scratch_buffer })
      vim.api.nvim_buf_set_lines(scratch_buffer, 0, -1, false, { "Compiling..." })
      vim.system({ "g++", "-O2", "-std=c++11", "-Wall", filename, "-o", basename, },
        { cwd = vim.fn.fnamemodify(filename, ":h") },
        function(obj)
          vim.schedule(function()
            local output = obj.stdout
            local error = obj.stderr
            local code = obj.code
            local headingns = vim.api.nvim_create_namespace("Headings")
            local pathsns = vim.api.nvim_create_namespace("Paths")
            local linenumns = vim.api.nvim_create_namespace("Line numbers")
            local errornons = vim.api.nvim_create_namespace("Error count")
            local markerns = vim.api.nvim_create_namespace("Markers")
            local quotens = vim.api.nvim_create_namespace("Quotes")


            vim.api.nvim_buf_set_lines(scratch_buffer, 0, -1, false, { "Exit code: " .. code })
            if error then
              errorandwarninglinenumber = vim.api.nvim_buf_line_count(scratch_buffer)

              vim.api.nvim_buf_set_lines(scratch_buffer, -1, -1, false, { "Errors and Warnings:" })
              vim.api.nvim_buf_add_highlight(
                scratch_buffer,
                headingns,
                "CompilerHeadingErrorAndWarnings",
                errorandwarninglinenumber,
                0, -1
              )
              vim.api.nvim_buf_set_lines(scratch_buffer, -1, -1, false, vim.split(error, "\n", { plain = true }))
            end

            -- Scan for regex patterns
            for i, line in ipairs(vim.api.nvim_buf_get_lines(scratch_buffer, 0, -1, false)) do
              if line:match("^.-:%d+:%d+: error: ") then
                errorcount = errorcount + 1
                local file_s, file_e = line:find("^[^:]+")
                local line_s, line_e = line:find("%d+", file_e + 2)
                local col_s, col_e = line:find("%d+", line_e + 2)
                vim.api.nvim_buf_add_highlight(scratch_buffer, pathsns, "PathsHighlightError", i - 1, file_s - 1, file_e)
                vim.api.nvim_buf_add_highlight(scratch_buffer, linenumns, "LineNumberHighlightError", i - 1, line_s - 1,
                  line_e)
                vim.api.nvim_buf_add_highlight(scratch_buffer, linenumns, "LineNumberHighlightError", i - 1, col_s - 1,
                  col_e)
              elseif line:match("^.-:%d+:%d+: warning: .* %b[]$") then
                warningcount = warningcount + 1
                local file_s, file_e = line:find("^[^:]+")
                local line_s, line_e = line:find("%d+", file_e + 2)
                local col_s, col_e = line:find("%d+", line_e + 2)
                local warning_s, warning_e = line:find("%b[]$")
                vim.api.nvim_buf_add_highlight(scratch_buffer, pathsns, "PathsHighlightWarning", i - 1, file_s - 1,
                  file_e)
                vim.api.nvim_buf_add_highlight(scratch_buffer, linenumns, "LineNumberHighlightError", i - 1, line_s - 1,
                  line_e)
                vim.api.nvim_buf_add_highlight(scratch_buffer, linenumns, "LineNumberHighlightError", i - 1, col_s - 1,
                  col_e)
                vim.api.nvim_buf_add_highlight(scratch_buffer, linenumns, "LineNumberHighlightError", i - 1,
                  warning_s - 1,
                  warning_e)
              elseif line:match("^%s*|%s*%^~*$") then
                local marker_s, marker_e = line:find("%^~*$")
                vim.api.nvim_buf_add_highlight(scratch_buffer, markerns, "MarkerHighlight", i - 1, marker_s - 1, marker_e)
              end
              local quote_s, quote_e = line:find("‘[^’]+’")
              if quote_s and quote_e then
                vim.api.nvim_buf_add_highlight(scratch_buffer, quotens, "QuotesHighlight", i - 1, quote_s - 1, quote_e)
              end
            end

            -- fg = "#E711F4",
            vim.api.nvim_buf_set_extmark(scratch_buffer, errornons, errorandwarninglinenumber, -1,
              { virt_text = { { tostring(errorcount) .. "E", "CompilerHeadingErrorAndWarnings" } }, virt_text_pos = "eol" })
            vim.api.nvim_buf_set_extmark(scratch_buffer, errornons, errorandwarninglinenumber, -1,
              {
                virt_text = { { tostring(warningcount) .. "W", "CompilerHeadingErrorAndWarnings" } },
                virt_text_pos =
                "eol"
              })
            vim.api.nvim_buf_set_lines(scratch_buffer, -1, -1, false, vim.split(output, "\n", { plain = true }))
          end)
        end)

      -- TODO: Append this
      vim.api.nvim_buf_set_lines(scratch_buffer, -1, -1, false, { "Running..." })
      vim.system({ "./" .. basename }, function(obj)
        vim.schedule(function()
          vim.cmd("checktime")
        end)
      end)
    end)
  end
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function(args)
--     vim.opt.makeprg = "g++ -Wall -O2 -std=c++11 % -o %:r"
--     vim.keymap.set("n", "<leader>cnr", function()
--       vim.cmd("make")
--       vim.cmd("copen")
--     end)
--   end
-- })
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
