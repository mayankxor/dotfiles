return {
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
