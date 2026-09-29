return {
  {
    "m4xshen/autoclose.nvim",
    enabled = vim.fn.has("nvim-0.7.0") == 1,
    config = function()
      require("autoclose").setup({
        keys = {
          ["("] = { escape = false, close = true, pair = "()" },
          ["["] = { escape = false, close = true, pair = "[]" },
          ["{"] = { escape = false, close = true, pair = "{}" },
          ["$"] = { escape = false, close = true, pair = "$$", enabled_filetypes = { "plaintex" } },

          [">"] = { escape = true, close = false, pair = "<>" },
          [")"] = { escape = true, close = false, pair = "()" },
          ["]"] = { escape = true, close = false, pair = "[]" },
          ["}"] = { escape = true, close = false, pair = "{}" },

          ['"'] = { escape = true, close = true, pair = '""' },
          ["'"] = { escape = true, close = true, pair = "''" },
          ["`"] = { escape = true, close = true, pair = "``" },
        },
        options = {
          disabled_filetypes = {},
          disable_when_touch = false,
          touch_regex = "[%w(%[{]",
          pair_spaces = true,
          auto_indent = true,
          disable_command_mode = false,
        },
      })
    end,
  },
  {
    "tronikelis/ts-autotag.nvim",
    enabled = true,
    config = function()
      require("ts-autotag").setup({

        opening_node_types = {
          -- templ
          "tag_start",

          -- xml,
          "STag",

          -- html
          "start_tag",

          -- jsx
          "jsx_opening_element",
        },
        identifier_node_types = {
          -- html
          "tag_name",
          "erroneous_end_tag_name",

          -- xml,
          "Name",

          -- jsx
          "member_expression",
          "identifier",

          -- templ
          "element_identifier",
        },

        disable_in_macro = true,

        -- plugin will be initialized on these filetypes
        filetypes = {
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "xml",
          "html",
          "templ",
          "php",
        },

        auto_close = {
          enabled = true,
        },
        auto_rename = {
          enabled = true,
          closing_node_types = {
            -- jsx
            "jsx_closing_element",

            -- xml,
            "ETag",

            -- html
            "end_tag",
            "erroneous_end_tag",

            -- templ
            "tag_end",
          },
        },
        -- disable plugin on some buffers
        should_attach = function(buf)
          return true
        end,
      })

      vim.keymap.set("n", "<leader>rn", function()
        -- it returns success status, thus you can fallback like so
        if not require("ts-autotag").rename() then
          vim.lsp.buf.rename()
        end
      end)
    end,
  },
}
