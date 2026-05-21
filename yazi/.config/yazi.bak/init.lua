function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b%d-%Y-%H:%M", time)
	else
		time = os.date("%b %d %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode = "dir" },
	persist = "none",
	desc_format = "full",
	file_picker_mode = "hover",
	custom_desc_input = false,
	show_keys = false,
	notify = {
		enable = true,
		timeout = 5,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})

th.git = th.git or {}
th.git.untracked = ui.Style():bold()
th.git.unknown = ui.Style():bold()
th.git.modified = ui.Style():bold()
th.git.added = ui.Style():bold()
th.git.ignored = ui.Style():bold()
th.git.deleted = ui.Style():bold()
th.git.updated = ui.Style():bold()
th.git.clean = ui.Style():bold()
require("git"):setup({
	order = 1500,
})
