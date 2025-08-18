return {
  "kdheepak/lazygit.nvim",
  lazy=true,
  cmd={
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies={
    "nvim-lua/plenary.nvim"
  },
  keys={
    {'<leader>lg', "<cmd>LazyGit<CR>", desc="Open lazygit"},
    {'<leader>gl', "<cmd>LazyGitLog<CR>", desc="LazyGit logs"}
  }
    -- An extension of LazyGit is available for telescope but requires lazy=false,
    -- TODO
    -- Check if the lazy=true feature is available for telescope extension
}
