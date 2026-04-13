local keymap = vim.keymap -- for conciseness
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definition"
    keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>gbd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts) -- jump to previous diagnostic in buffer
    --
    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

-- vim.lsp.inlay_hint.enable(true)

-- local severity = vim.diagnostic.severity
--
-- vim.diagnostic.config({
--   signs = {
--     text = {
--       [severity.ERROR] = " ",
--       [severity.WARN] = " ",
--       [severity.HINT] = "󰠠 ",
--       [severity.INFO] = " ",
--     },
--   },
-- })

-- lua-language-server(lua_ls)
local luarootmarkers1={
  '.emmyrc.json',
  '.luarc.json',
  '.luarc.jsonc'
}
local luarootmarkers2={
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}
vim.lsp.config("lua_ls", {
  cmd = {"lua-language-server"},
  filetypes={"lua"},
  capabilities=capabilities,
  root_markers={luarootmarkers1, luarootmarkers2, '.git'},
  settings = {
    Lua = {
      codeLens={
        enable=true,
      },
      diagnostics = {
        globals = { "vim" },
      },
      hint={
        enable=true,
        semicolon="Disable",
      },
      workspace = {
        -- library = vim.api.nvim_get_runtime_file("", true),
        -- library={
          -- [vim.fn.expand("$VIMRUNTIME/lua")]=true,
          -- [vim.fn.stdpath("config") .. "/lua"] = true,
        -- },
        checkThirdParty = false,
      },
    },
  },
})
-- vim.lsp.enable("lua_ls")

-- clangd
local function switch_source_header(bufnr, client)
  local method_name = 'textDocument/switchSourceHeader'
  if not client or not client:supports_method(method_name) then
    return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info(bufnr, client)
  local method_name = 'textDocument/symbolInfo'
  if not client or not client:supports_method(method_name) then
    return vim.notify('Clangd client not found', vim.log.levels.ERROR)
  end
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  client:request(method_name, params, function(err, res)
    if err or #res == 0 then
      return
    end
    local container = string.format('container: %s', res[1].containerName) ---@type string
    local name = string.format('name: %s', res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, '', {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      title = 'Symbol Info',
    })
  end, bufnr)
end

vim.lsp.config("clangd", {
  cmd = {"clangd"},
  capabilities=capabilities,
  filetypes={'c', 'cpp', 'objc', 'objcpp', 'cuda'},
  root_markers={
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  },
on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
      switch_source_header(bufnr, client)
    end, { desc = 'Switch between source/header' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdShowSymbolInfo', function()
      symbol_info(bufnr, client)
    end, { desc = 'Show symbol info' })
  end,
})
-- vim.lsp.enable("clangd")

-- rust_analyzer
local function reload_workspace(bufnr)
  local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'rust_analyzer' }
  for _, client in ipairs(clients) do
    vim.notify 'Reloading Cargo Workspace'
    ---@diagnostic disable-next-line:param-type-mismatch
    client:request('rust-analyzer/reloadWorkspace', nil, function(err)
      if err then
        error(tostring(err))
      end
      vim.notify 'Cargo workspace reloaded'
    end, 0)
  end
end

local function user_sysroot_src()
  return vim.tbl_get(vim.lsp.config['rust_analyzer'], 'settings', 'rust-analyzer', 'cargo', 'sysrootSrc')
end

local function default_sysroot_src()
  local sysroot = vim.tbl_get(vim.lsp.config['rust_analyzer'], 'settings', 'rust-analyzer', 'cargo', 'sysroot')
  if not sysroot then
    local rustc = os.getenv 'RUSTC' or 'rustc'
    local result = vim.system({ rustc, '--print', 'sysroot' }, { text = true }):wait()

    local stdout = result.stdout
    if result.code == 0 and stdout then
      if string.sub(stdout, #stdout) == '\n' then
        if #stdout > 1 then
          sysroot = string.sub(stdout, 1, #stdout - 1)
        else
          sysroot = ''
        end
      else
        sysroot = stdout
      end
    end
  end

  return sysroot and vim.fs.joinpath(sysroot, 'lib/rustlib/src/rust/library') or nil
end

local function is_library(fname)
  local user_home = vim.fs.normalize(vim.env.HOME)
  local cargo_home = os.getenv 'CARGO_HOME' or user_home .. '/.cargo'
  local registry = cargo_home .. '/registry/src'
  local git_registry = cargo_home .. '/git/checkouts'

  local rustup_home = os.getenv 'RUSTUP_HOME' or user_home .. '/.rustup'
  local toolchains = rustup_home .. '/toolchains'

  local sysroot_src = user_sysroot_src() or default_sysroot_src()

  for _, item in ipairs { toolchains, registry, git_registry, sysroot_src } do
    if item and vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients { name = 'rust_analyzer' }
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
end
local ra_capabilities = vim.tbl_deep_extend(
  "force",
    capabilities,
  {
    experimental = {
      serverStatusNotification = true,
      commands = {
        commands = {
          'rust-analyzer.showReferences',
          'rust-analyzer.runSingle',
          'rust-analyzer.debugSingle',
        },
      },
    },
  }
)
---@type vim.lsp.Config
vim.lsp.config("rust_analyzer", {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local reused_dir = is_library(fname)
    if reused_dir then
      on_dir(reused_dir)
      return
    end

    local cargo_crate_dir = vim.fs.root(fname, { 'Cargo.toml' })
    local cargo_workspace_root

    if cargo_crate_dir == nil then
      on_dir(
        vim.fs.root(fname, { 'rust-project.json' })
          or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
      )
      return
    end

    local cmd = {
      'cargo',
      'metadata',
      '--no-deps',
      '--format-version',
      '1',
      '--manifest-path',
      cargo_crate_dir .. '/Cargo.toml',
    }

    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          local result = vim.json.decode(output.stdout)
          if result['workspace_root'] then
            cargo_workspace_root = vim.fs.normalize(result['workspace_root'])
          end
        end

        on_dir(cargo_workspace_root or cargo_crate_dir)
      else
        vim.schedule(function()
          vim.notify(('[rust_analyzer] cmd failed with code %d: %s\n%s'):format(output.code, cmd, output.stderr))
        end)
      end
    end)
  end,
  capabilities = ra_capabilities,
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ['rust-analyzer'] = {
      lens = {
        debug = { enable = true },
        enable = true,
        implementations = { enable = true },
        references = {
          adt = { enable = true },
          enumVariant = { enable = true },
          method = { enable = true },
          trait = { enable = true },
        },
        run = { enable = true },
        updateTest = { enable = true },
      },
    },
  },
  before_init = function(init_params, config)
    -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
    if config.settings and config.settings['rust-analyzer'] then
      init_params.initializationOptions = config.settings['rust-analyzer']
    end
    ---@param command table{ title: string, command: string, arguments: any[] }
    vim.lsp.commands['rust-analyzer.runSingle'] = function(command)
      local r = command.arguments[1]
      local cmd = { 'cargo', unpack(r.args.cargoArgs) }
      if r.args.executableArgs and #r.args.executableArgs > 0 then
        vim.list_extend(cmd, { '--', unpack(r.args.executableArgs) })
      end

      local proc = vim.system(cmd, { cwd = r.args.cwd, env = r.args.environment })

      local result = proc:wait()

      if result.code == 0 then
        vim.notify(result.stdout, vim.log.levels.INFO)
      else
        vim.notify(result.stderr, vim.log.levels.ERROR)
      end
    end
  end,
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoReload', function()
      reload_workspace(bufnr)
    end, { desc = 'Reload current cargo workspace' })
  end,
})
-- vim.lsp.enable("rust_analyzer") {eats up memory like a dumbledore}
