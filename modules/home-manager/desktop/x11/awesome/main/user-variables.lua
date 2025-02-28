local home = os.getenv("HOME")

local _M = {
	-- This is used later as the default terminal and editor to run.
	terminal = "ghostty",

	-- Default modkey.
	modkey = "Mod1",

	-- user defined wallpaper
	--wallpaper = home .. "/Pictures/your-wallpaper-here.jpg",
}

return _M
