return {
  {
    'nvim-mini/mini.surround',
    version = '*',
    enabled = true,
    config = function()
      require("mini.surround").setup()
    end
  },
  {
    "m4xshen/autoclose.nvim",
    enabled = true,
    config = function()
      require("autoclose").setup()
    end
  }
}
