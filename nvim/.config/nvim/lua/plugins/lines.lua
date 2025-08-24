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
					lualine_x = { },
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
						-- {
						-- 	"buffers",
						-- 	show_filename_only = true,
						-- 	hide_filename_extension = true,
						-- 	show_modified_status = true,
						-- 	mode = 4,
						-- 	icons_enabled = true,
						-- 	-- max_length=vim.o.columns*2/3,
						-- 	filetype_names = {
						-- 		telescopeprompt = "telescope",
						-- 		dashboard = "dashboard",
						-- 		packer = "packer",
						-- 		fzf = "fzf",
						-- 		alpha = "alpha",
						-- 	},
						-- 	use_mode_colors = false,
						-- 	buffers_color = {},
						-- 	symbols = {
						-- 		modified = " ●", -- text to show when the buffer is modified
						-- 		alternate_file = "#", -- text to show to identify the alternate file
						-- 		directory = " ", -- text to show when the buffer is a directory
						-- 	},
						-- },
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {
						-- {
						-- 	"lsp_status",
						-- 	icon = " LSP:", -- f013
						-- 	symbols = {
						-- 		spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						-- 		done = "✓",
						-- 		separator = ",",
						-- 	},
						-- 	ignore_lsp = {},
						-- },
						-- {
						-- 	function()
						-- 		-- Check if 'conform' is available
						-- 		local status, conform = pcall(require, "conform")
						-- 		if not status then
						-- 			return "Conform not installed"
						-- 		end
						--
						-- 		local lsp_format = require("conform.lsp_format")
						--
						-- 		-- Get formatters for the current buffer
						-- 		local formatters = conform.list_formatters_for_buffer()
						-- 		if formatters and #formatters > 0 then
						-- 			local formatterNames = {}
						--
						-- 			for _, formatter in ipairs(formatters) do
						-- 				table.insert(formatterNames, formatter)
						-- 			end
						--
						-- 			return "󰷈 " .. table.concat(formatterNames, " ")
						-- 		end
						--
						-- 		-- Check if there's an LSP formatter
						-- 		local bufnr = vim.api.nvim_get_current_buf()
						-- 		local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })
						--
						-- 		if not vim.tbl_isempty(lsp_clients) then
						-- 			return "󰷈 LSP Formatter"
						-- 		end
						--
						-- 		return ""
						-- 	end,
						-- },
					},
					-- lualine_y = { "hostname" },
					lualine_z = {
						-- {
						-- 	"tabs",
						-- 	use_mode_colors = false,
						-- 	mode = 0,
						-- 	path = 0,
						-- 	show_modified_status = false,
						-- 	symbols = {
						-- 		modified = "[+]",
						-- 	},
						-- },
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
}
