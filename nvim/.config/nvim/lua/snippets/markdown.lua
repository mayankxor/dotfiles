local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local function timestring()
	return os.date("%B%d,%Y;%H:%M:%S")
end

return {
	s("timeput", {
		f(function()
			return timestring()
		end),
	}),
}
