--- MERGED FROM
--- https://github.com/neovim/nvim-lspconfig/blob/5a49a97f9d3de5c39a2b18d583035285b3640cb0/lsp/tombi.lua
--- AND
--- https://github.com/hrsh7th/cmp-nvim-lsp/tree/cbc7b02bb99fae35cb42f514762b89b5126651ef
---
---@brief
---
--- https://tombi-toml.github.io/tombi/
---
--- Language server for Tombi, a TOML toolkit.
---

vim.lsp.config("tombi", {
  cmd = { 'tombi', 'lsp' },
  filetypes = { 'toml' },
  root_markers = { 'tombi.toml', 'pyproject.toml', '.git' },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          deprecatedSupport = true,
          insertReplaceSupport = true,
          insertTextModeSupport = {
            valueSet = { 1, 2 }
          },
          labelDetailsSupport = true,
          preselectSupport = true,
          resolveSupport = {
            properties = { "documentation", "additionalTextEdits", "insertTextFormat", "insertTextMode", "command" }
          },
          snippetSupport = true,
          tagSupport = {
            valueSet = { 1 }
          }
        },
        completionList = {
          itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
        },
        contextSupport = true,
        dynamicRegistration = false,
        insertTextMode = 1
      },
    },
  },
  on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    map("<leader>sd", vim.diagnostic.open_float, "Show diagnostics")
    map("[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Goto previous diagnostic")
    map("]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Goto next diagnostic")
    map("<leader>q", vim.diagnostic.setloclist)
    map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
    map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
    map("gT", vim.lsp.buf.type_definition, "[g]o to [T]ype definition")
    map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format")
  end,
})
vim.lsp.enable("tombi")
