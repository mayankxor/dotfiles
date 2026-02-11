return {
	{
		"xeluxee/competitest.nvim",
		enabled = false,
		dependencies = {
			"MunifTanmjim/nui.nvim",
		},
		config = function()
			require("competitest").setup({})
		end,
	},
	{
		"kawre/leetcode.nvim",
		enabled = false,
		build = ":TSUpdate html",
		branch = "disable-x-requested-with-header",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanmjim/nui.nvim",
		},
		cmd = "Leet",
		config = function()
			require("leetcode").setup({
				---@alias lc.lang
				---| "cpp"
				---| "java"
				---| "python"
				---| "python3"
				---| "c"
				---| "csharp"
				---| "javascript"
				---| "typescript"
				---| "php"
				---| "swift"
				---| "kotlin"
				---| "dart"
				---| "golang"
				---| "ruby"
				---| "scala"
				---| "rust"
				---| "racket"
				---| "erlang"
				---| "elixir"
				---| "bash"

				---@alias lc.hook
				---| "enter"
				---| "question_enter"
				---| "leave"

				---@alias lc.size
				---| string
				---| number
				---| { width: string | number, height: string | number }

				---@alias lc.position "top" | "right" | "bottom" | "left"

				---@alias lc.direction "col" | "row"

				---@alias lc.inject { gap?: number, imports?: (fun(default_imports: string[]): string[])|string|string[], before?: string|string[], after?: string|string[] }

				---@alias lc.storage table<"cache"|"home", string>

				---@alias lc.picker { provider?: "fzf-lua" | "telescope" | "snacks-picker" }

				---@class lc.UserConfig
				---@type string
				arg = "leetcode.nvim", -- use directly with "nvim leetcode.nvim"

				---@type lc.lang
				lang = "cpp",

				cn = { -- leetcode.cn
					enabled = false, ---@type boolean
					translator = true, ---@type boolean
					translate_problems = true, ---@type boolean
				},

				---@type lc.storage
				storage = {
					home = vim.fn.stdpath("data") .. "/leetcode",
					cache = vim.fn.stdpath("cache") .. "/leetcode",
				},

				---@type table<string, boolean>
				plugins = {
					non_standalone = true,
				},

				---@type boolean
				logging = true,

				injector = {
					["python3"] = {
						imports = function(default_imports)
							vim.list_extend(default_imports, { "from .leetcode import *" })
							return default_imports
						end,
						after = { "def test():", "    print('test')" },
					},
					["cpp"] = {
						imports = function()
							return { "#include<bits/stdc++.h>", "using namespace std;" }
						end,
						after = "int main(){}",
					},
				}, ---@type table<lc.lang, lc.inject>

				cache = {
					update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
				},

				editor = {
					reset_previous_code = true, ---@type boolean
					fold_imports = true, ---@type boolean
				},

				console = {
					open_on_runcode = true, ---@type boolean

					dir = "row", ---@type lc.direction

					size = { ---@type lc.size
						width = "90%",
						height = "75%",
					},

					result = {
						size = "60%", ---@type lc.size
					},

					testcase = {
						virt_text = true, ---@type boolean

						size = "40%", ---@type lc.size
					},
				},

				description = {
					position = "left", ---@type lc.position

					width = "40%", ---@type lc.size

					show_stats = true, ---@type boolean
				},

				---@type lc.picker
				picker = { provider = "telescope" },

				hooks = {
					---@type fun()[]
					["enter"] = {},

					---@type fun(question: lc.ui.Question)[]
					["question_enter"] = {},

					---@type fun()[]
					["leave"] = {},
				},

				keys = {
					toggle = { "q" }, ---@type string|string[]
					confirm = { "<CR>" }, ---@type string|string[]

					reset_testcases = "r", ---@type string
					use_testcase = "U", ---@type string
					focus_testcases = "H", ---@type string
					focus_result = "L", ---@type string
				},

				---@type lc.highlights
				theme = {
					-- ["alt"] = {
					-- 	bg = "#FFFFFF",
					-- },
					-- ["normal"] = {
					-- 	fg = "#EA4AAA",
					-- },
				},

				---@type boolean
				image_support = false,
			})
		end,
	},
}
