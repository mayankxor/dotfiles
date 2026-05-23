--- MERGED FROM
--- https://github.com/neovim/nvim-lspconfig/blob/cab9d27b23b5dadf19f799fe05118a1439c286a9/lsp/lua_ls.lua
--- AND
--- https://github.com/hrsh7th/cmp-nvim-lsp/tree/cbc7b02bb99fae35cb42f514762b89b5126651ef
---
---@brief
---
--- https://github.com/luals/lua-language-server
---
--- Lua language server.
---
--- `lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).
---
--- The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.
---
--- If you primarily use `lua-language-server` for Neovim, and want to provide completions,
--- analysis, and location handling for plugins on runtime path, you can use the following
--- settings.
---
--- ```lua
--- vim.lsp.config('lua_ls', {
---   on_init = function(client)
---     if client.workspace_folders then
---       local path = client.workspace_folders[1].name
---       if
---         path ~= vim.fn.stdpath('config')
---         and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
---       then
---         return
---       end
---     end
---
---     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
---       runtime = {
---         -- Tell the language server which version of Lua you're using (most
---         -- likely LuaJIT in the case of Neovim)
---         version = 'LuaJIT',
---         -- Tell the language server how to find Lua modules same way as Neovim
---         -- (see `:h lua-module-load`)
---         path = {
---           'lua/?.lua',
---           'lua/?/init.lua',
---         },
---       },
---       -- Make the server aware of Neovim runtime files
---       workspace = {
---         checkThirdParty = false,
---         library = {
---           vim.env.VIMRUNTIME,
---           -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
---           vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
---         },
---         -- Or pull in all of 'runtimepath'.
---         -- NOTE: this is a lot slower and will cause issues when working on
---         -- your own configuration.
---         -- See https://github.com/neovim/nvim-lspconfig/issues/3189
---         -- library = vim.api.nvim_get_runtime_file('', true),
---       },
---     })
---   end,
---   settings = {
---     Lua = {},
---   },
--- })
--- ```
---
--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
---

local root_markers1 = {
	".emmyrc.json",
	".luarc.json",
	".luarc.jsonc",
}
local root_markers2 = {
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),

	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					commitCharactersSupport = true,
					deprecatedSupport = true,
					insertReplaceSupport = true,
					insertTextModeSupport = {
						valueSet = { 1, 2 },
					},
					labelDetailsSupport = true,
					preselectSupport = true,
					resolveSupport = {
						properties = {
							"documentation",
							"additionalTextEdits",
							"insertTextFormat",
							"insertTextMode",
							"command",
						},
					},
					snippetSupport = true,
					tagSupport = {
						valueSet = { 1 },
					},
				},
				completionList = {
					itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
				},
				contextSupport = true,
				dynamicRegistration = false,
				insertTextMode = 1,
			},
		},
	},

	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			diagnostics = {
			},
			completion = { callSnippet = "Replace" },
			codeLens = { enable = true },
			hint = { enable = true, semicolon = "Disable" },
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
vim.lsp.enable("lua_ls")
