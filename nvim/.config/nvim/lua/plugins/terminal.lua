-- Shoutout TJ Devris
-- https://youtu.be/5PIiKDES_wc

local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(opts)
  opts = opts or { }
  local width  = opts.width or math.floor(vim.o.columns * 0.6)
  local height = opts.height or math.floor(vim.o.lines * 0.6)
  local col = math.floor((vim.o.columns - width)/2)
  local row = math.floor((vim.o.lines - height)/2)

  local buffer = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buffer = opts.buf
  else
    buffer = vim.api.nvim_create_buf(false, true)
  end
  local winconfig = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  }
  local window = vim.api.nvim_open_win(buffer, true, winconfig)
  return {buf = buffer, win =  window}
end

local function toggle_floating_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win)then
    state.floating = create_floating_window({buf=state.floating.buf})
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
vim.api.nvim_create_user_command("Floaterm", toggle_floating_terminal, {})
vim.keymap.set("n", "`", toggle_floating_terminal)
return {}
