return {

	-- To download servers
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({

				---@since 1.0.0
				-- Where Mason should put its bin location in your PATH. Can be one of:
				-- - "prepend" (default, Mason's bin location is put first in PATH)
				-- - "append" (Mason's bin location is put at the end of PATH)
				-- - "skip" (doesn't modify PATH)
				---@type '"prepend"' | '"append"' | '"skip"'
				PATH = "prepend",

				---@since 1.0.0
				-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
				-- debugging issues with package installations.
				log_level = vim.log.levels.INFO,

				---@since 1.0.0
				-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
				-- packages that are requested to be installed will be put in a queue.
				max_concurrent_installers = 4,

				---@since 1.0.0
				-- [Advanced setting]
				-- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
				-- multiple registries, the registry listed first will be used.
				registries = {
					"github:mason-org/mason-registry",
				},

				---@since 2.3.0
				-- [Advanced setting]
				-- The registries to source system packages from. Accepts multiple entries. Should a package with the same name exist in
				-- multiple registries, the registry listed first will be used.
				system_registries = { "github:mason-org/mason-system-registry" },

				---@since 1.0.0
				-- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
				-- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
				-- Builtin providers are:
				--   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
				--   - mason.providers.client        - uses only client-side tooling to resolve metadata
				providers = {
					"mason.providers.registry-api",
					"mason.providers.client",
				},
				github = {
					---@since 1.0.0
					-- The template URL to use when downloading assets from GitHub.
					-- The placeholders are the following (in order):
					-- 1. The repository (e.g. "rust-lang/rust-analyzer")
					-- 2. The release version (e.g. "v0.3.0")
					-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
					download_url_template = "https://github.com/%s/releases/download/%s/%s",
				},
				pip = {
					---@since 1.0.0
					-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
					upgrade_pip = false,

					---@since 1.0.0
					-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
					-- and is not recommended.
					--
					-- Example: { "--proxy", "https://proxyserver" }
					install_args = {},
				},
				npm = {
					---@since 2.3.0
					-- These args will be added to `npm install` calls. Note that setting extra args might impact intended behavior
					-- and is not recommended.
					--
					-- Example: { "--registry", "https://registry.npmjs.org/" }
					install_args = {},
				},
				ui = {

					---@since 1.0.0
					-- Whether to automatically check for new versions when opening the :Mason window.
					check_outdated_packages_on_open = true,

					---@since 1.0.0
					-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
					-- Defaults to `:h 'winborder'` if nil.
					border = nil,

					---@since 1.11.0
					-- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
					backdrop = 60,

					---@since 1.0.0
					-- Width of the window. Accepts:
					-- - Integer greater than 1 for fixed width.
					-- - Float in the range of 0-1 for a percentage of screen width.
					width = 0.8,

					---@since 1.0.0
					-- Height of the window. Accepts:
					-- - Integer greater than 1 for fixed height.
					-- - Float in the range of 0-1 for a percentage of screen height.
					height = 0.9,
					icons = {
						---@since 1.0.0
						-- The list icon to use for installed packages.
						package_installed = "󱘩 ",
						---@since 1.0.0
						-- The list icon to use for packages that are installing, or queued for installation.
						package_pending = "󱦟 ",
						---@since 1.0.0
						-- The list icon to use for packages that are not installed.
						package_uninstalled = " ",
					},

					keymaps = {
						---@since 1.0.0
						-- Keymap to expand a package
						toggle_package_expand = "<CR>",
						---@since 1.0.0
						-- Keymap to install the package under the current cursor position
						install_package = "i",
						---@since 1.0.0
						-- Keymap to reinstall/update the package under the current cursor position
						update_package = "u",
						---@since 1.0.0
						-- Keymap to check for new version for the package under the current cursor position
						check_package_version = "c",
						---@since 1.0.0
						-- Keymap to update all installed packages
						update_all_packages = "U",
						---@since 1.0.0
						-- Keymap to check which installed packages are outdated
						check_outdated_packages = "C",
						---@since 1.0.0
						-- Keymap to uninstall a package
						uninstall_package = "X",
						---@since 1.0.0
						-- Keymap to cancel a package installation
						cancel_installation = "<C-c>",
						---@since 1.0.0
						-- Keymap to apply language filter
						apply_language_filter = "<C-f>",
						---@since 1.1.0
						-- Keymap to toggle viewing package installation log
						toggle_package_install_log = "<CR>",
						---@since 1.8.0
						-- Keymap to toggle the help view
						toggle_help = "g?",
					},
				},
			})
		end,
	},

	-- To get extra capabilities
	{
		"hrsh7th/cmp-nvim-lsp",
		enabled = true,
	},

	-- Frontend
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				-- Where completions come from
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Only accept explicitly selected completion
					-- Tab => if there's only one completion possible, accept it
					--     => if there's more than one possible completion, select the next one
					--     => If there's no completion, act as regular tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entries = cmp.get_entries()
							if #entries == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						else
							fallback()
						end
					end, { "i", "s" }),
					-- S-Tab => If there's completion, select previous one
					--       => If there's no completion, act as regular tab
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				-- Disable completions in certain contexts, such as comments
				enabled = function()
					local disabled = false
					disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
					disabled = disabled or (vim.fn.reg_recording() ~= "")
					disabled = disabled or (vim.fn.reg_executing() ~= "")
					disabled = disabled or require("cmp.config.context").in_treesitter_capture("comment")
					return not disabled
				end,
			})
		end,
	},
}
