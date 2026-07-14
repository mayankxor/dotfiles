return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  enabled = true,
  config = function()
    require('nvim-treesitter').install({ 'c', 'cpp', 'rust', 'css', 'html', 'javascript', 'go' },
      { opts = { summary = true } })
    require('nvim-treesitter').setup({
      install_dir = vim.fn.stdpath('data') .. '/site',
    })
  end
}
