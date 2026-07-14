return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    local util = require("conform.util")
    require("conform").setup({
      formatters = {
        stylua = {
          meta = {
            url = "https://github.com/JohnnyMorganz/StyLua",
            description = "An opinionated code formatter for Lua.",
          },
          command = "stylua",
          args = {
            "--color",
            "Auto",
            "--num-threads",
            "4",
            "--output-format",
            "Standard",
            "--search-parent-directories",
            "--respect-ignores",
            "--stdin-filepath",
            "$FILENAME",
            "-",
          },
          stdin = true,
          range_args = function(self, ctx)
            local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
            return {
              "--color",
              "Auto",
              "--num-threads",
              "4",
              "--output-format",
              "Standard",
              "--search-parent-directories",
              "--stdin-filepath",
              "$FILENAME",
              "--range-start",
              tostring(start_offset),
              "--range-end",
              tostring(end_offset),
              "-",
            }
          end,
          cwd = util.root_file({
            ".stylua.toml",
            "stylua.toml",
          }),
        },
        clang_format = {
          meta = {
            url = "https://clang.llvm.org/docs/ClangFormat.html",
            description = "Tool to format C/C++/… code according to a set of rules and heuristics.",
          },
          command = "clang-format",
          args = { "--fail-on-incomplete-format", "-ferror-limit", "0", "-assume-filename", "$FILENAME" },
          range_args = function(self, ctx)
            local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
            local length = end_offset - start_offset
            return {
              "-assume-filename",
              "$FILENAME",
              "--offset",
              tostring(start_offset),
              "--length",
              tostring(length),
            }
          end,
        },
        qmlformat = {
          command = "/usr/lib/qt6/bin/qmlformat",
          args = { "-i", "$FILENAME" },
          stdin = false,
        }
      },
      formatters_by_ft = {
        jsonc = { "prettierd" },
        lua = { "stylua" },
        qml = { "qmlformat" }
      },
      format_on_save = {
        timeout_ms = 500,
        bufnr = 0,
        async = false,
        undojoin = false,
        stop_after_first = false,
        quiet = false,
        lsp_format = "fallback",
      },
      timeout_ms = 1000,
      lsp_format = "fallback",
      quite = false,
      stop_after_first = false,
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      notify_no_formatters = true,
    })
  end,
}
