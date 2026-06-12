require("git"):setup {
  -- Order of status signs showing in the linemode
  order = 1500,
}

-- default config
require('font-sample'):setup {
  text = 'ABCDEF abcdef\n0123456789 \noO08 iIlL1 g9qCGQ\n8%& <([{}])>\n.,;: @#$-_="\n== <= >= != ffi\nâéùïøçÃĒÆœ\n및개요これ直楽糸',
  canvas_size = '750x800',
  font_size = 80,
  -- https://imagemagick.org/script/color.php
  bg = 'white',
  fg = 'black',
}

require("bookmarks"):setup({
  last_directory = { enable = false, persist = false, mode = "dir" },
  persist = "none",
  desc_format = "full",
  custom_desc_input = false,
  notify = {
    enable = true,
    timeout = 5,
    message = {
      new = "New bookmark '<key>' -> '<folder>'",
      delete = "Deleted bookmark in '<key>",
      delete_all = "Deleted all bookmarks"
    }
  }
})
