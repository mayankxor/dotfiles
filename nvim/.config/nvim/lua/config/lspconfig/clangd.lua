--- MERGED FROM
--- https://github.com/neovim/nvim-lspconfig/blob/cfc12beefe39cdcb77ff81fa49e71cc42cdf4fbc/lsp/clangd.lua
--- AND
--- https://github.com/hrsh7th/cmp-nvim-lsp/tree/cbc7b02bb99fae35cb42f514762b89b5126651ef
---
---@brief
---
--- https://clangd.llvm.org/installation.html
---
--- - **NOTE:** Clang >= 11 is recommended! See [#23](https://github.com/neovim/nvim-lspconfig/issues/23).
--- - If `compile_commands.json` lives in a build directory, you should
---   symlink it to the root of your source tree.
---   ```
---   ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/
---   ```
--- - clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html)
---   specified as compile_commands.json, see https://clangd.llvm.org/installation#compile_commandsjson

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader

local function switch_source_header(bufnr, client)
	local method_name = "textDocument/switchSourceHeader"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

local function symbol_info(bufnr, client)
	local method_name = "textDocument/symbolInfo"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify("Clangd client not found", vim.log.levels.ERROR)
	end
	local win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, res)
		if err or #res == 0 then
			-- Clangd always returns an error, there is no reason to parse it
			return
		end
		local container = string.format("container: %s", res[1].containerName)
		local name = string.format("name: %s", res[1].name)
		vim.lsp.util.open_floating_preview({ name, container }, "", {
			height = 2,
			width = math.max(string.len(name), string.len(container)),
			focusable = false,
			focus = false,
			title = "Symbol Info",
		})
	end, bufnr)
end

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac", -- Autotools
		".git",
	},
	get_language_id = function(_, ftype)
		local t = { objc = "objective-c", objcpp = "objective-cpp", cuda = "cuda-cpp" }
		return t[ftype] or ftype
	end,
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
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
		offsetEncoding = { "utf-8", "utf-16" },
	},
	---@param init_result ClangdInitializeResult
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,
	on_attach = function(client, bufnr)
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

		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
			switch_source_header(bufnr, client)
		end, { desc = "Switch between source/header" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
			symbol_info(bufnr, client)
		end, { desc = "Show symbol info" })
	end,
})

vim.lsp.enable("clangd")
