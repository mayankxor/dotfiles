--- MERGED FROM
--- https://github.com/neovim/nvim-lspconfig/blob/5a49a97f9d3de5c39a2b18d583035285b3640cb0/lsp/qmlls.lua
--- AND
--- https://github.com/hrsh7th/cmp-nvim-lsp/tree/cbc7b02bb99fae35cb42f514762b89b5126651ef
---
---@brief
---
--- https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html
---
--- > QML Language Server is a tool shipped with Qt that helps you write code in your favorite (LSP-supporting) editor.
---
--- Source in the [QtDeclarative repository](https://code.qt.io/cgit/qt/qtdeclarative.git/)

vim.lsp.config("qmlls", {
  cmd = { '/usr/lib/qt6/bin/qmlls', "-I", "/usr/lib/qt6/qml" },
  filetypes = { 'qml', 'qmljs' },
  root_markers = { '.git', '.qmlls.ini' },
  on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end,
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
      }
    }
  }
})
vim.lsp.enable("qmlls")
