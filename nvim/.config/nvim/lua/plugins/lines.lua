--[[
Instead of nothing, add label in icon for LSP
' ' '󰊢 
Instead of location, use '%l:%c', '%p%%/%L'
]]
return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							"winenter",
							"bufenter",
							"bufwritepost",
							"sessionloadpost",
							"filechangedshellpost",
							"vimresized",
							"filetype",
							"cursormoved",
							"cursormovedi",
							"modechanged",
						},
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:sub(1, 1)
							end,
						},
					},
					lualine_b = {
						{
							"branch",
							icon = { " " },
						},
						{
							"diff",
							colored = true,
						},
						{
							"diagnostics",
							sources = {
								-- 'nvim_lsp',
								"nvim_diagnostic",
								-- 'nvim_workspace_diagnostic',
								-- 'coc',
								-- 'ale',
								-- 'vim_lsp',
							},
							sections = {
								"error",
								"warn",
								"info",
								"hint",
							},
							diagnostics_color = {
								error = "diagnosticerror",
								warn = "diagnosticwarn",
								info = "diagnosticinfo",
								hint = "diagnostichint",
							},
							symbols = {
								error = "󰅚 ",
								warn = "󰀪 ",
								info = "󰋽 ",
								hint = "󰌶 ",
							},
							colored = true,
							update_in_insert = true,
							always_visible = false,
						},
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 0,
							symbols = {
								modified = "[+]",
								readonly = "[-]",
								unnamed = "[no name]",
								newfile = "[new]",
							},
						},
					},
					lualine_x = {
						{
							function()
								local handle = io.open("/sys/class/power_supply/BAT1/capacity", "r")
								local status = io.open("/sys/class/power_supply/BAT1/status", "r")
								if handle == nil then
									return "No Battery Detected"
								end
								if status == nil then
									return "Status not detected"
								end
								local statusstr = status:read("*all"):gsub("%s+", "")
								local per = handle:read("*all"):gsub("%s+", "")
								local pernum = tonumber(per)
								if statusstr == "Discharging" then
									if pernum > 90 then
										return "󰂂 " .. per
									elseif pernum > 80 then
										return "󰂁 " .. per
									elseif pernum > 70 then
										return "󰂀 " .. per
									elseif pernum > 60 then
										return "󰁿 " .. per
									elseif pernum > 50 then
										return "󰁾" .. per
									elseif pernum > 40 then
										return "󰁽 " .. per
									elseif pernum > 30 then
										return "󰁼 " .. per
									elseif pernum > 20 then
										return "󰁻 " .. per
									elseif pernum > 10 then
										return "󰁺 " .. per
									elseif pernum > 0 then
										return "󰂃 " .. per
									end
								end
								if statusstr == "Charging" then
									if pernum > 90 then
										return "󰂋 " .. per
									elseif pernum > 80 then
										return "󰂊 " .. per
									elseif pernum > 70 then
										return "󰢞 " .. per
									elseif pernum > 60 then
										return "󰂉 " .. per
									elseif pernum > 50 then
										return "󰢝 " .. per
									elseif pernum > 40 then
										return "󰂈 " .. per
									elseif pernum > 30 then
										return "󰂇 " .. per
									elseif pernum > 20 then
										return "󰂆 " .. per
									elseif pernum > 10 then
										return "󰢜 " .. per
									elseif pernum > 0 then
										return "󰢟 " .. per
									end
								end
								if statusstr == "Full" then
									return "󰁹 100"
								end
							end,
						},
						{
							"filesize",
						},
						{
							"encoding",
							show_bomb = true,
						},
						{
							"fileformat",
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
						},
						{
							"filetype",
							colored = true,
							icon_only = true,
							icon = {
								align = "right",
							},
						},
					},
					lualine_y = { "progress" },
					lualine_z = {
						{
							"%l:%c(%L)",
						},
						{
							"datetime",
							style = "%T",
							color = {
								fg = "#000000",
								bg = "pink",
								-- gui='italic,bold',
							},
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = {
						{
							"buffers",
							show_filename_only = true,
							hide_filename_extension = true,
							show_modified_status = true,
							mode = 4,
							icons_enabled = true,
							-- max_length=vim.o.columns*2/3,
							filetype_names = {
								telescopeprompt = "telescope",
								dashboard = "dashboard",
								packer = "packer",
								fzf = "fzf",
								alpha = "alpha",
							},
							use_mode_colors = false,
							buffers_color = {},
							symbols = {
								modified = " ●", -- text to show when the buffer is modified
								alternate_file = "#", -- text to show to identify the alternate file
								directory = " ", -- text to show when the buffer is a directory
							},
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {
						{
							"lsp_status",
							icon = " LSP:", -- f013
							symbols = {
								spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
								done = "✓",
								separator = " ",
							},
							ignore_lsp = {},
						},
						{
							function()
								-- Check if 'conform' is available
								local status, conform = pcall(require, "conform")
								if not status then
									return "Conform not installed"
								end

								local lsp_format = require("conform.lsp_format")

								-- Get formatters for the current buffer
								local formatters = conform.list_formatters_for_buffer()
								if formatters and #formatters > 0 then
									local formatterNames = {}

									for _, formatter in ipairs(formatters) do
										table.insert(formatterNames, formatter)
									end

									return "󰷈 " .. table.concat(formatterNames, " ")
								end

								-- Check if there's an LSP formatter
								local bufnr = vim.api.nvim_get_current_buf()
								local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

								if not vim.tbl_isempty(lsp_clients) then
									return "󰷈 LSP Formatter"
								end

								return ""
							end,
						},
					},
					lualine_y = { "hostname" },
					lualine_z = {
						{
							"tabs",
							use_mode_colors = false,
							mode = 0,
							path = 0,
							show_modified_status = false,
							symbols = {
								modified = "[+]",
							},
						},
					},
					--[[ winbar = {          Conflicts with barbecue
    lualine_a={},
    lualine_b={},
    lualine_c={},
    lualine_x={},
    lualine_y={},
    lualien_z={},
  }, ]]
					inactive_winbar = {},
					extensions = {},
				},

				-- Uncomment to disable lualine:
				--[[
config=function()
  require('lualine').hide({
    place={'statusline', 'tabline', 'winbar'},
    unhide=false,
  })
end
]]
			})
		end,
	},
	{
		"b0o/incline.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			-- ICON+FILENAME:
			--[[
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No File Opened]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
      ]]

			-- ICON+FILENAME+NAVIC:
			--[[
			local helpers = require("incline.helpers")
			local navic = require("nvim-navic")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0, vertical = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local res = {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						guibg = "#44406e",
					}
					if props.focused then
						for _, item in ipairs(navic.get_data(props.buf) or {}) do
							table.insert(res, {
								{ " > ", group = "NavicSeparator" },
								{ item.icon, group = "NavicIcons" .. item.type },
								{ item.name, group = "NavicText" },
							})
						end
					end
					table.insert(res, " ")
					return res
				end,
			})
      ]]

			-- FILENAME+ICON+DIAGNOSTICS+GIT-DIFF
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)

					local function get_git_diff()
						local icons = { removed = "", changed = "", added = "" }
						local signs = vim.b[props.buf].gitsigns_status_dict
						local labels = {}
						if signs == nil then
							return labels
						end
						for name, icon in pairs(icons) do
							if tonumber(signs[name]) and signs[name] > 0 then
								table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
							end
						end
						if #labels > 0 then
							table.insert(labels, { "┊ " })
						end
						return labels
					end

					local function get_diagnostic_label()
						local icons = { error = "", warn = "", info = "", hint = "" }
						local label = {}

						for severity, icon in pairs(icons) do
							local n = #vim.diagnostic.get(
								props.buf,
								{ severity = vim.diagnostic.severity[string.upper(severity)] }
							)
							if n > 0 then
								table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
							end
						end
						if #label > 0 then
							table.insert(label, { "┊ " })
						end
						return label
					end

					return {
						{ get_diagnostic_label() },
						{ get_git_diff() },
						{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
						{ filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
						{ "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
					}
				end,
			})
			--
		end,
	},
}
