return {
	"xeluxee/competitest.nvim",
	dependencies = {
		"MunifTanmjim/nui.nvim",
	},
	config = function()
		require("competitest").setup({})
	end,
}
