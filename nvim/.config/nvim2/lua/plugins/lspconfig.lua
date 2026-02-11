return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				PATH = "prepend",
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
				registries = {
					"github:mason-org/mason-registry",
				},
				providers = {
					"mason.providers.registry-api",
					"mason.providers.client",
				},
				github = {
					download_url_template = "https://github.com/%s/releases/download/%s/%s",
				},
				pip = {
					upgrade_pip = false,
					install_args = {},
				},
				ui = {
					check_outdated_packages_on_open = true,
					border = nil,
					backdrop = 60,
					width = 0.8,
					height = 0.9,
					icons = {
						package_installed = "󱘩 ",
						package_pending = "󱦟 ",
						package_uninstalled = " ",
					},
					keymaps = {
						toggle_package_expand = "<CR>",
						install_package = "i",
						update_package = "u",
						check_package_version = "v",
						update_all_packages = "U",
						check_outdated_packages = "C",
						uninstall_package = "X",
						cancel_installation = "<C-c>",
						apply_language_filter = "<C-f>",
						toggle_package_install_log = "<CR>",
						toggle_help = "g?",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = false,
				ensure_installed = { "lua_ls", "clangd", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		event = { "BufReadPre", "BufEnter" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local on_attach = function(client, bufnr)
				local map = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end
				map("<leader>sd", vim.diagnostic.open_float, "Show diagnostics")
				map("[d", vim.diagnostic.goto_prev, "Goto next diagnostic")
				map("]d", vim.diagnostic.goto_next, "Goto previous diagnostic")
				map("<leader>q", vim.diagnostic.setloclist)
				map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
				map("gD", vim.lsp.buf.declaration, "[g]o to [D]efinition")
				map("gT", vim.lsp.buf.type_definition, "[g]o to [T]ype definition")
				map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")
			end
			local servers = {
				-- TODO: Install g++ 14 and put clang to that
				clangd = {
					capabilities = capabilities,
					cmd = {
						"clangd",
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					root_markers = {
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git",
					},
				},
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = {
									"vim",
								},
							},
							completion = {
								callSnippet = "Replace",
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				pyright = { capabilities = capabilities },
				texlab = { capabilities = capabilities },
				tinymist = {
					capabilities = capabilities,
					settings = {
						formatterMode = "typstyle",
						exportPdf = "never",
						semanticTokens = "disable",
					},
				},
			}
			for name, opts in pairs(servers) do
				opts.on_attach = on_attach
				lspconfig[name].setup(opts)
			end
		end,
	},
	-- {
	--  "neovim/nvim-lspconfig",
	--   enabled=true,
	--   config=function()
	--     local lspconfig=require("lspconfig")
	--     -- local on_attach=function(client, bufnr)
	--     lspconfig.lua_ls.setup({})
	--     lspconfig.clangd.setup({})
	--     lspconfig.pyright.setup({})
	--   end
	-- }
	{
		"nvimtools/none-ls.nvim",
		enabled = true,
		config = function()
			local null_ls = require("null-ls")
			local formatters = require("null-ls").builtins.formatting
			local completitions = require("null-ls").builtins.completion
			local diagnostics = require("null-ls").builtins.diagnostics
			null_ls.setup({
				sources = {
					diagnostics.pylint.with({
						diagnostic_config = {
							underline = true,
							virtual_text = true,
							virtual_lines = false,
							signs = true,
						},
						method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
					}),
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			vim.keymap.set({ "n", "v" }, "<leader>cff", '<cmd>lua require("conform").format()<CR>')
			conform.setup({
				format_on_save = {},
				async = false,
				timeout_ms = 1500,
				lsp_format = "fallback",
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					rust = { "rustfmt" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		enabled = true,
	},
	{
		"L3MON4D3/LuaSnip", -- snippet expansion
		enabled = true,
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- make your own snippet expansion candidates
			"rafamadriz/friendly-snippets",
		},
		version = "v2.4.0",
		run = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = "~/.config/nvim/lua/snippets",
			})
			local ls = require("luasnip")
			vim.keymap.set({ "i" }, "<C-K>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},

	{
		"hrsh7th/nvim-cmp", -- sort and filter completions
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- "hrsh7th/cmp-calc",
			-- "PhilRunninger/cmp-rpncalc",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			-- "hrsh7th/cmp-emoji",

			-- TODO:
			-- Make these 2 load only at latex files
			-- "kdheepak/cmp-latex-symbols",
			-- "max397574/cmp-greek",
		},
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local in_snippet = function()
				local session = require("luasnip.session")
				local node = session.current_nodes[vim.api.nvim_get_current_buf()]
				if not node then
					return false
				end
				local snippet = node.parent.snippet
				local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
				local pos = vim.api.nvim_win_get_cursor(0)
				if pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1] then
					return true
				end
			end
			local lspkind = require("lspkind")

			-- SETUP
			cmp.setup({
				experimental = {
					ghost_text = false,
				},
				completion = {
					-- completeopt = "fuzzy,menu,menuone,noinsert"
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				-- formatting = {
				-- 	format = function(entry, vim_item)
				-- 		vim_item.menu = ({
				-- 			nvim_lsp = "[LSP]",
				-- 			luasnip = "[Snippet]",
				-- 			buffer = "[Buffer]",
				-- 			path = "[Path]",
				-- 			codecompanion = "[CodeCompanion]",
				-- 		})[entry.source.name]
				-- 		return vim_item
				-- 	end,
				-- },
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = {
							-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							-- can also be a function to dynamically calculate max width such as
							-- menu = function() return math.floor(0.45 * vim.o.columns) end,
							menu = 30, -- leading text (labelDetails)
							abbr = 50, -- actual suggestion item
						},
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = false, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							-- ...
							return vim_item
						end,
					}),
					symbol_map = {
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "",
					},
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- ["<CR>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		if luasnip.expandable() then
					-- 			luasnip.expand()
					-- 		else
					-- 			cmp.confirm({
					-- 				select = true,
					-- 			})
					-- 		end
					-- 	else
					-- 		fallback()
					-- 	end
					-- end),

					-- TODO: Look into this implementation, I think its a little redundant power usage and potential time waste
					-- DONE:
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entries = cmp.get_entries()
							if #entries == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif in_snippet() and luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif in_snippet() and luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		if #cmp.get_entries() == 1 then
					-- 			cmp.confirm({ select = true })
					-- 		else
					-- 			cmp.select_next_item()
					-- 		end
					-- 	elseif luasnip.locally_jumpable(1) then
					-- 		luasnip.jump(1)
					-- 	elseif has_words_before() then
					-- 		cmp.complete()
					-- 		if #cmp.get_entries == 1 then
					-- 			cmp.confirm({ select = true })
					-- 		end
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item()
					-- 	elseif in_snippet() and luasnip.locally_jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					-- { name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = "codecompanion" },
				}, {
					{
						name = "path",
						option = {
							---@type boolean
							trailing_slash = true, -- completed directory names should have a trailing slash
							label_trailing_slash = true, -- show trailing slash in menu
						},
					},
					{
						name = "buffer",
						option = {
							---@type number
							keyword_length = 3, -- How many keystrokes must be completed to trigger this
							---@type string
							keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]], -- Create word list from buffer content
							---@type fun(): number[]
							get_bufnrs = function() -- Which bufnr to see as source
								--[[
	                   This function uses current buffer as source only if it doesnt exceed 1 MB.
	                   Otherwise the file can take 10's of MBs in memory and slow down the program.
	                 -- ]]
								local buf = vim.api.nvim_get_current_buf()
								local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
								if byte_size > 1024 * 1024 then
									return {}
								end
								return { buf }
							end,
							--[[
	               FOR CURRENT BUFFER WITHOUT RESTRICTION:
	               function()
	               return vim.api.nvim_get_current_buf()
	               --]]
							--[[
	               FOR ALL BUFFERS:
	               function()
	                 return vim.api.nvim_list_bufs()
	               end
	               --]]

							--[[
	               FOR ALL VISIBLE BUFFERS:
	               function()
	                 local bufs={}
	                 for _,win in ipairs(vim.api.nvim_list_wins()) do
	                   bufs[vim.api.nvim_win_get_buf(win)] == true
	                 end
	                 return vim.tbl_keys(bufs)
	               end
	               --]]

							---@type number
							indexing_interval = 100, -- Duration between index pulls in milliseconds
							---@type number
							indexing_batch_size = 1000, -- Lines pulled with each index pull (negative value will switch to asynchronous mode)
							---@type number
							max_indexed_line_length = 1024 * 40, -- The amount of data from each line to be pulled in bytes. Remaining part of line is not sourced
						},
					},
					-- {
					-- 	name = "calc",
					-- },
					-- {
					-- 	name = "rpncalc",
					-- },
					-- {
					-- 	name = "emoji",
					-- 	option = {
					-- 		---@type boolean
					-- 		insert = false,
					-- 	},
					-- },
					-- {
					-- 	name = "greek",
					-- },
					-- {
					-- 	name = "latex_symbols",
					-- 	option = {
					-- 		---@type number
					-- 		strategy = 0,
					-- 		--[[
					--                0: Show command and insert symbol
					--                1: Show and insert symbol
					--                2: Show and insert command
					--            --]]
					-- 	},
					-- },
				}),
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							buffer = "[Buffer]",
							path = "[Path]",
							cmdline = "[Cmdline]",
							-- codecompanion = "[CodeCompanion]",
						})[entry.source.name]
						return vim_item
					end,
				},
				sources = cmp.config.sources({
					{
						name = "path",
						option = {
							---@type boolean
							trailing_slash = true, -- completed directory names should have a trailing slash
							label_trailing_slash = true, -- show trailing slash in menu
						},
					},
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			-- / cmdline setup
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{
						name = "buffer",
					},
				},
			})

			-- GHOST TEXT:
			local config = require("cmp.config")
			local toggle_ghost_text = function()
				if vim.api.nvim_get_mode() ~= "i" then
					return
				end
				local cursor_column = vim.fn.col(".")
				local current_line_content = vim.fn.getline(".")
				local character_after_cursor = current_line_content:sub(cursor_column, cursor_column)

				local should_enable_ghost_text = character_after_cursor == ""
					or vim.fn.match(character_after_cursor, [[\k]]) == -1

				local current = config.get().experimental.ghost_text
				if current ~= should_enable_ghost_text then
					config.set_global({
						experimental = {
							ghost_text = should_enable_ghost_text,
						},
					})
				end
			end

			vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
				callback = toggle_ghost_text,
			})
			--
			--
			-- cmp.setup.cmdline({ "/", "?" }, {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = "buffer" },
			-- 	},
			-- })
		end,
	},

	-- TODO: Figure out how to get DAP working
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			{
				"nvim-neotest/nvim-nio",
				enabled = true,
			},
			{
				"rcarriga/nvim-dap-ui",
				enabled = true,
			},
		},
		config = function()
			local set = vim.keymap.set
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Select and attach to process",
					type = "gdb",
					request = "attach",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					pid = function()
						local name = vim.fn.input("Executable name (filter): ")
						return require("dap.utils").pick_process({ filter = name })
					end,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to gdbserver :1234",
					type = "gdb",
					request = "attach",
					target = "localhost:1234",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			set("n", "<Leader>dt", dap.toggle_breakpoint)
			set("n", "<leader>dc", dap.continue)
		end,
	},
	-- {
	--   "rcarriga/nvim-dap-ui",
	--   enabled=true,
	--   config=function ()
	--     local dapui = require("dapui")
	--     dap.listeners.before.attach.dapui_config = function()
	-- 		dapui.open()
	-- 	end
	-- 	dap.listeners.before.launch.dapui_config = function()
	-- 		dapui.open()
	-- 	end
	-- 	dap.listeners.before.event_terminated.dapui_config = function()
	-- 		dapui.close()
	-- 	end
	-- 	dap.listeners.before.event_exited.dapui_config = function()
	-- 		dapui.close()
	-- 	end
	--   end
	-- }
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"nvim-neotest/nvim-nio",
	-- 	},
	-- 	config = function()
	-- 		local dap = require("dap")
	-- 		local dapui = require("dapui")
	-- 		dap.adapters.gdb = {
	-- 			type = "executable",
	-- 			command = "gdb",
	-- 			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	-- 		}
	-- 		dap.configurations.c = {
	-- 			{
	-- 				name = "Launch",
	-- 				type = "gdb",
	-- 				request = "launch",
	-- 				program = function()
	-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 				end,
	-- 				cwd = "${workspaceFolder}",
	-- 				stopAtBeginningOfMainSubprogram = false,
	-- 			},
	-- 			{
	-- 				name = "Select and attach to process",
	-- 				type = "gdb",
	-- 				request = "attach",
	-- 				program = function()
	-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 				end,
	-- 				pid = function()
	-- 					local name = vim.fn.input("Executable name (filter): ")
	-- 					return require("dap.utils").pick_process({ filter = name })
	-- 				end,
	-- 				cwd = "${workspaceFolder}",
	-- 			},
	-- 			{
	-- 				name = "Attach to gdbserver :1234",
	-- 				type = "gdb",
	-- 				request = "attach",
	-- 				target = "localhost:1234",
	-- 				program = function()
	-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 				end,
	-- 				cwd = "${workspaceFolder}",
	-- 			},
	-- 		}
	-- 		dap.listeners.before.attach.dapui_config = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.launch.dapui_config = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated.dapui_config = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited.dapui_config = function()
	-- 			dapui.close()
	-- 		end
	-- 	end,
	-- },
	--

	-- NOTE:
	-- This plugin has really minimal design for completions, really really good
	-- Try to figure out if it can be integrated with the already used sources and maybe it can replace nvim-cmp
	{
		"echasnovski/mini.completion",
		dependencies = { "echasnovski/mini.snippets", enabled = true },
		enabled = false,
		config = function()
			require("mini.completion").setup({
				-- Delay (debounce type, in ms) between certain Neovim event and action.
				-- This can be used to (virtually) disable certain automatic actions by
				-- setting very high delay time (like 10^7).
				delay = { completion = 100, info = 100, signature = 50 },

				-- Configuration for action windows:
				-- - `height` and `width` are maximum dimensions.
				-- - `border` defines border (as in `nvim_open_win()`; default "single").
				window = {
					info = { height = 25, width = 80, border = nil },
					signature = { height = 25, width = 80, border = nil },
				},

				-- Way of how module does LSP completion
				lsp_completion = {
					-- `source_func` should be one of 'completefunc' or 'omnifunc'.
					source_func = "completefunc",

					-- `auto_setup` should be boolean indicating if LSP completion is set up
					-- on every `BufEnter` event.
					auto_setup = true,

					-- A function which takes LSP 'textDocument/completion' response items
					-- (each with `client_id` field for item's server) and word to complete.
					-- Output should be a table of the same nature as input. Common use case
					-- is custom filter/sort. Default: `default_process_items`
					process_items = nil,

					-- A function which takes a snippet as string and inserts it at cursor.
					-- Default: `default_snippet_insert` which tries to use 'mini.snippets'
					-- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
					snippet_insert = nil,
				},

				-- Fallback action as function/string. Executed in Insert mode.
				-- To use built-in completion (`:h ins-completion`), set its mapping as
				-- string. Example: set '<C-x><C-l>' for 'whole lines' completion.
				fallback_action = "<C-n>",

				-- Module mappings. Use `''` (empty string) to disable one. Some of them
				-- might conflict with system mappings.
				mappings = {
					-- Force two-step/fallback completions
					force_twostep = "<C-Space>",
					force_fallback = "<A-Space>",

					-- Scroll info/signature window down/up. When overriding, check for
					-- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
					-- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
			})
		end,
	},
}
