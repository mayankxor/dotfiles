return {
  "barrettruth/live-server.nvim",
  config=function()
    vim.g.live_server = {
      port=5555, -- (integer?) Port for the HTTP server. Default: `5500`
      browser=false, -- (boolean?) Auto-open browser on start. Default: `true`
      debounce=120, -- (integer?) Debounce interval in ms for file changes. Default: `120`
      ignore={}, -- (string[]?) Lua patterns for file paths to ignore when watching for changes. Deafult: `{}`
      css_inject=true, -- (boolean?) Hot-swap CSS without full page reload. Default: `true`
      debug=false, -- Log each step of the hot-reload chain via `vim.notify()` at DEBUG level. Default: `false`
    }
  end,
}
