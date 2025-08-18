--[[
Instead of nothing, add label in icon for LSP
' ' '󰊢 
Instead of location, use '%l:%c', '%p%%/%L'
]]
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		--
		-- -- NOTE: Uncomment this part to truncate components on smaller window, I dont really see a difference tho
		-- --
		-- --- TRUNCATE COMPONENTS ON SMALLER WINDOW
		-- --- @param trunc_width number trunctates component when screen width is less then trunc_width
		-- --- @param trunc_len number truncates component to trunc_len number of chars
		-- --- @param hide_width number hides component when window width is smaller then hide_width
		-- --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
		-- --- return function that can format the component accordingly
		-- local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
		-- 	return function(str)
		-- 		local win_width = vim.fn.winwidth(0)
		-- 		if hide_width and win_width < hide_width then
		-- 			return ""
		-- 		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
		-- 			return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
		-- 		end
		-- 		return str
		-- 	end
		-- end
		--
		-- require("lualine").setup({
		-- 	lualine_a = {
		-- 		{ "mode", fmt = trunc(80, 4, nil, true) },
		-- 		{ "filename", fmt = trunc(90, 30, 50) },
		-- 		{
		-- 			function()
		-- 				return require("lsp-status").status()
		-- 			end,
		-- 			fmt = trunc(120, 20, 60),
		-- 		},
		-- 	},
		-- })
		--
		--
		--
		--
		--
		-- NOTE: THIS IS SOME DUMP CODE FOR A COMPONENT THAT SHOWS FILENAME AND CHANGES ITS COLOR BASED ON MODIFICATION STATUS OF BUFFER
		local custom_fname = require("lualine.components.filename"):extend()
		local highlight = require("lualine.highlight")
		local default_status_colors = { saved = "#228B22", modified = "#C70039" }
		function custom_fname:init(options)
			custom_fname.super.init(self, options)
			self.status_colors = {
				saved = highlight.create_component_highlight_group(
					{ bg = default_status_colors.saved },
					"filename_status_saved",
					self.options
				),
				modified = highlight.create_component_highlight_group(
					{ bg = default_status_colors.modified },
					"filename_status_modified",
					self.options
				),
			}
			if self.options.color == nil then
				self.options.color = ""
			end
		end

		function custom_fname:update_status()
			local data = custom_fname.super.update_status(self)
			data = highlight.component_format_highlight(
				vim.bo.modified and self.status_colors.modified or self.status_colors.saved
			) .. data
			return data
		end
		--
		--

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
					-- TESTING:
					--
					-- 1. show the last line with trailing whitespaces(not needed cuz formatters)
					{
						function()
							local space = vim.fn.search([[\s\+$]], "nwc")
							return space ~= 0 and "TW:" .. space or ""
						end,
					},

					-- 2. Show next line with mixed indent(space+tab)
					{
						function()
							local space_pat = [[\v^ +]]
							local tab_pat = [[\v^\t+]]
							local space_indent = vim.fn.search(space_pat, "nwc")
							local tab_indent = vim.fn.search(tab_pat, "nwc")
							local mixed = (space_indent > 0 and tab_indent > 0)
							local mixed_same_line
							if not mixed then
								mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
								mixed = mixed_same_line > 0
							end
							if not mixed then
								return ""
							end
							if mixed_same_line ~= nil and mixed_same_line > 0 then
								return "MI:" .. mixed_same_line
							end
							local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
							local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
							if space_indent_cnt > tab_indent_cnt then
								return "MI:" .. tab_indent
							else
								return "MI:" .. space_indent
							end
						end,
					},

					-- 3. Show current keymap: (DOESNT WORK FOR SOME REASON)
					{
						function()
							if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
								return "⌨ " .. vim.b.keymap_name
							end
							return ""
						end,
					},

					-- Shows window number
					{
						function()
							return vim.api.nvim_win_get_number(0)
						end,
					},

					-- 4. Show filename and change its color based on modification status of buffer:
					-- Its dependency functions are defined above this require block
					{
						custom_fname,
					},

					-- TESTING:

					{
						-- TODO: Handle the 100 percent case, since this thing sometimes show 90 percent icon for 100 percent and it doesnt show charging in 100% whatsoever
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
}
