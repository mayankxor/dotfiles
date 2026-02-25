return {
  {
    "hrsh7th/cmp-nvim-lsp",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "hrsh7th/nvim-cmp",
    config=function()
      local cmp = require("cmp")
      cmp.setup({
        window={
          completion={
            border="none",
            side_padding=0,
            padding=0,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
        sources = {
          {name="nvim_lsp"},
        },
      })
    end
  }
}
