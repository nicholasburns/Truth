local A, C, G, L = select(2, ...):Unpack()

if (not C["Bar"]["Enable"] or not C["Bar"]["Hotkeys"]["Enable"]) then
	return
end

local M = C["Bar"]["Hotkeys"]


local UpdateHotkey

do
	local gsub = string.gsub
	local unpack = unpack
	local hooksecurefunc = hooksecurefunc


	UpdateHotkey = function(self)
		local hotkey = _G[("%sHotKey"):format(self:GetName())]		-- local hotkey = _G[self:GetName() .. "HotKey"]
		local T = hotkey:GetText()


		-- Modifiers
		T = (T):gsub("(a%-)",				L["KEY_ALT"])		--> AM5		( Alt-MouseButton5 )
		T = (T):gsub("(c%-)", 				L["KEY_CTRL"])		--> CM5		( Ctrl-MouseButton5 )
		T = (T):gsub("(s%-)", 				L["KEY_SHIFT"])	--> SM5		( Shift-MouseButton5 )
		T = (T):gsub(CAPSLOCK_KEY_TEXT,		L["KEY_CAPSLOCK"])


		-- Spaces
		T = (T):gsub(KEY_BACKSPACE,			L["KEY_BACKSPACE"])
		T = (T):gsub(KEY_ENTER,				L["KEY_ENTER"])
		T = (T):gsub(KEY_SPACE,				L["KEY_SPACE"])
		T = (T):gsub(KEY_TAB,				L["KEY_TAB"])


		-- Characters
		T = (T):gsub(KEY_APOSTROPHE,			L["KEY_APOSTROPHE"])
		T = (T):gsub(KEY_MINUS,				L["KEY_MINUS"])
		T = (T):gsub(KEY_PLUS,				L["KEY_PLUS"])
		T = (T):gsub(KEY_TILDE,				L["KEY_TILDE"])


		-- Groups
		T = (T):gsub(KEY_PRINTSCREEN,			L["KEY_PRINTSCREEN"])
		T = (T):gsub(KEY_PAUSE,				L["KEY_PAUSE"])
		T = (T):gsub(KEY_INSERT,				L["KEY_INSERT"])
		T = (T):gsub(KEY_HOME,				L["KEY_HOME"])
		T = (T):gsub(KEY_PAGEUP,				L["KEY_PAGEUP"])
		T = (T):gsub(KEY_DELETE,				L["KEY_DELETE"])
		T = (T):gsub(KEY_END,				L["KEY_END"])
		T = (T):gsub(KEY_PAGEDOWN,			L["KEY_PAGEDOWN"])
		T = (T):gsub(KEY_UP,				L["KEY_UP"])
		T = (T):gsub(KEY_DOWN,				L["KEY_DOWN"])
		T = (T):gsub(KEY_LEFT,				L["KEY_LEFT"])
		T = (T):gsub(KEY_RIGHT,				L["KEY_RIGHT"])


		-- Numpad
		T = (T):gsub(KEY_NUMPADDIVIDE,		L["KEY_NUMPADDIVIDE"])
		T = (T):gsub(KEY_NUMPADMULTIPLY,		L["KEY_NUMPADMULTIPLY"])
		T = (T):gsub(KEY_NUMPAD0,			L["KEY_NUMPAD0"])
		T = (T):gsub(KEY_NUMPAD1,			L["KEY_NUMPAD1"])
		T = (T):gsub(KEY_NUMPAD2,			L["KEY_NUMPAD2"])
		T = (T):gsub(KEY_NUMPAD3,			L["KEY_NUMPAD3"])
		T = (T):gsub(KEY_NUMPAD4,			L["KEY_NUMPAD4"])
		T = (T):gsub(KEY_NUMPAD5,			L["KEY_NUMPAD5"])
		T = (T):gsub(KEY_NUMPAD6,			L["KEY_NUMPAD6"])
		T = (T):gsub(KEY_NUMPAD7,			L["KEY_NUMPAD7"])
		T = (T):gsub(KEY_NUMPAD8,			L["KEY_NUMPAD8"])
		T = (T):gsub(KEY_NUMPAD9,			L["KEY_NUMPAD9"])


		-- Mouse
		T = (T):gsub(KEY_BUTTON1,			L["KEY_BUTTON1"])
		T = (T):gsub(KEY_BUTTON2,			L["KEY_BUTTON2"])
		T = (T):gsub(KEY_BUTTON3,			L["KEY_BUTTON3"])
		T = (T):gsub(KEY_BUTTON4,			L["KEY_BUTTON4"])
		T = (T):gsub(KEY_BUTTON5,			L["KEY_BUTTON5"])
		T = (T):gsub(KEY_MOUSEWHEELUP,		L["KEY_MOUSEWHEELUP"])
		T = (T):gsub(KEY_MOUSEWHEELDOWN,		L["KEY_MOUSEWHEELDOWN"])


		-- Text
		hotkey:SetText(T)

		hotkey:SetFont(unpack(M["Font"]))

		hotkey:SetShadowOffset(M["Font"][4] or 0, -M["Font"][4] or 0)
		hotkey:SetShadowColor(unpack(M["Font"][5]))

		hotkey:SetTextColor(unpack(M["Text"]["Color"]))

		-- Layout
		hotkey:Width(self:GetWidth())
		hotkey:Point(unpack(M["Point"]))
	end

	hooksecurefunc("ActionButton_UpdateHotkeys", UpdateHotkey)
end


--------------------------------------------------
-- local hook = CreateFrame('Frame')
-- hook:RegisterEvent("PLAYER_ENTERING_WORLD")
-- hook:SetScript('OnEvent', function(self, event, ...)
	-- hooksecurefunc("ActionButton_UpdateHotkeys", UpdateHotkey)
	-- self:UnregisterEvent(event)
-- end)

--------------------------------------------------
--[[ Debug

	Printing Button Text
	--------------------
	/d MultiBarBottomRightButton8HotKey:GetText()	--> 'Capslock'

	/d MultiBarRightButton10HotKey:GetText()		--> '*0'

	/d MultiBarBottomRightButton9HotKey:GetText()	--> 'Mouse Button 5'

--]]
--------------------------------------------------

--[[ s:gsub(pattern, replace, [n])

	This is a very powerful function and can be used in multiple ways.
	Used simply it can replace all instances of the pattern provided with the replacement.
	A pair of values is returned, the modified string and the number of substitutions made.
	The optional fourth argument n can be used to limit the number of substitutions made:

		string.gsub("Hello banana", "banana", "Lua user")

		> Hello Lua user  1


	Pattern Capture
	The most commonly seen pattern capture instances could be:

		"(.-)"   ==>  "{(.-)}" means capture any characters between the curly braces {}
					(lazy match, i.e. as few characters as possible)

		"(.*)"   ==>  "{(.*)}" means capture any characters between the curly braces {}
					(greedy match, i.e. as many characters as possible)

		string.gsub("The big {brown} fox jumped {over} the lazy {dog}.", "{(.-)}", function(a)  print(a) end )

		> brown
		> over
		> dog

--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local DEFAULT_HOTKEY_MAP = {

	-- Modifiers
	KEY_ALT			= L["KEY_ALT"],
	LALT_KEY_TEXT		= L["LALT_KEY_TEXT"],
	RALT_KEY_TEXT		= L["RALT_KEY_TEXT"],
	KEY_CTRL			= L["KEY_CTRL"],
	LCTRL_KEY_TEXT		= L["LCTRL_KEY_TEXT"],
	RCTRL_KEY_TEXT		= L["RCTRL_KEY_TEXT"],
	KEY_SHIFT			= L["KEY_SHIFT"],
	LSHIFT_KEY_TEXT	= L["LSHIFT_KEY_TEXT"],
	RSHIFT_KEY_TEXT	= L["RSHIFT_KEY_TEXT"],

	-- Spaces
	KEY_BACKSPACE		= L["KEY_BACKSPACE"],
	KEY_ENTER			= L["KEY_ENTER"],
	KEY_SPACE			= L["KEY_SPACE"],
	KEY_TAB			= L["KEY_TAB"],

	-- Characters
	KEY_APOSTROPHE		= L["KEY_APOSTROPHE"],
	KEY_BACKSLASH		= L["KEY_BACKSLASH"],
	KEY_COMMA			= L["KEY_COMMA"],
	KEY_LEFTBRACKET	= L["KEY_LEFTBRACKET"],
	KEY_MINUS			= L["KEY_MINUS"],
	KEY_PERIOD		= L["KEY_PERIOD"],
	KEY_PLUS			= L["KEY_PLUS"],
	KEY_RIGHTBRACKET	= L["KEY_RIGHTBRACKET"],
	KEY_SEMICOLON		= L["KEY_SEMICOLON"],
	KEY_SLASH			= L["KEY_SLASH"],
	KEY_TILDE			= L["KEY_TILDE"],

	-- Groups
	KEY_PRINTSCREEN	= L["KEY_PRINTSCREEN"],
	KEY_SCROLLOCK		= L["KEY_SCROLLOCK"],
	KEY_PAUSE			= L["KEY_PAUSE"],
	KEY_INSERT		= L["KEY_INSERT"],
	KEY_HOME			= L["KEY_HOME"],
	KEY_PAGEUP		= L["KEY_PAGEUP"],
	KEY_DELETE		= L["KEY_DELETE"],
	KEY_END			= L["KEY_END"],
	KEY_PAGEDOWN		= L["KEY_PAGEDOWN"],
	KEY_UP			= L["KEY_UP"],
	KEY_DOWN			= L["KEY_DOWN"],
	KEY_LEFT			= L["KEY_LEFT"],
	KEY_RIGHT			= L["KEY_RIGHT"],

	-- Numpad
	KEY_NUMPAD		= L["KEY_NUMPAD"],
	KEY_NUMLOCK		= L["KEY_NUMLOCK"],
	KEY_NUMPADDIVIDE	= L["KEY_NUMPADDIVIDE"],
	KEY_NUMPADMULTIPLY	= L["KEY_NUMPADMULTIPLY"],
	KEY_NUMPADMINUS	= L["KEY_NUMPADMINUS"],
	KEY_NUMPADPLUS		= L["KEY_NUMPADPLUS"],
	KEY_NUMPADDECIMAL	= L["KEY_NUMPADDECIMAL"],
	KEY_NUMPAD0		= L["KEY_NUMPAD0"],
	KEY_NUMPAD1		= L["KEY_NUMPAD1"],
	KEY_NUMPAD2		= L["KEY_NUMPAD2"],
	KEY_NUMPAD3		= L["KEY_NUMPAD3"],
	KEY_NUMPAD4		= L["KEY_NUMPAD4"],
	KEY_NUMPAD5		= L["KEY_NUMPAD5"],
	KEY_NUMPAD6		= L["KEY_NUMPAD6"],
	KEY_NUMPAD7		= L["KEY_NUMPAD7"],
	KEY_NUMPAD8		= L["KEY_NUMPAD8"],
	KEY_NUMPAD9		= L["KEY_NUMPAD9"],

	-- Mouse
	KEY_MOUSEBUTTON	= L["KEY_MOUSEBUTTON"],
	KEY_BUTTON1		= L["KEY_BUTTON1"],
	KEY_BUTTON2		= L["KEY_BUTTON2"],
	KEY_BUTTON3		= L["KEY_BUTTON3"],
	KEY_BUTTON4		= L["KEY_BUTTON4"],
	KEY_BUTTON5		= L["KEY_BUTTON5"],
	KEY_MOUSEWHEELUP	= L["KEY_MOUSEWHEELUP"],
	KEY_MOUSEWHEELDOWN	= L["KEY_MOUSEWHEELDOWN"],
}
--]]

--[[ Unused

	-- Modifiers
	T = (T):gsub("ALT%-", 			L["KEY_ALT"])		--> a-...
	T = (T):gsub("CTRL%-",			L["KEY_CTRL"])		--> c-...
	T = (T):gsub("SHIFT%-", 			L["KEY_SHIFT"])	--> s-...
	 --
	T = (T):gsub(KEY_ALT,			L["KEY_ALT"])
	T = (T):gsub(LALT_KEY_TEXT,		L["LALT_KEY_TEXT"])
	T = (T):gsub(RALT_KEY_TEXT,		L["RALT_KEY_TEXT"])
	T = (T):gsub(KEY_CTRL,			L["KEY_CTRL"])
	T = (T):gsub(LCTRL_KEY_TEXT,		L["LCTRL_KEY_TEXT"])
	T = (T):gsub(RCTRL_KEY_TEXT,		L["RCTRL_KEY_TEXT"])
	T = (T):gsub(KEY_SHIFT,			L["KEY_SHIFT"])
	T = (T):gsub(LSHIFT_KEY_TEXT,		L["LSHIFT_KEY_TEXT"])
	T = (T):gsub(RSHIFT_KEY_TEXT,		L["RSHIFT_KEY_TEXT"])

	-- Characters
	T = (T):gsub(KEY_BACKSLASH,		L["KEY_BACKSLASH"])
	T = (T):gsub(KEY_COMMA,			L["KEY_COMMA"])
	T = (T):gsub(KEY_LEFTBRACKET,		L["KEY_LEFTBRACKET"])
	T = (T):gsub(KEY_PERIOD,			L["KEY_PERIOD"])
	T = (T):gsub(KEY_RIGHTBRACKET, 	L["KEY_RIGHTBRACKET"])
	T = (T):gsub(KEY_SEMICOLON,		L["KEY_SEMICOLON"])
	T = (T):gsub(KEY_SLASH,			L["KEY_SLASH"])

	-- Groups
	T = (T):gsub(KEY_SCROLLOCK,		L["KEY_SCROLLOCK"])

	-- Numpad
	T = (T):gsub(KEY_NUMPAD,			L["KEY_NUMPAD"])
	T = (T):gsub(KEY_NUMLOCK,			L["KEY_NUMLOCK"])
	T = (T):gsub(KEY_NUMPADMINUS,		L["KEY_NUMPADMINUS"])		-- No change necessary
	T = (T):gsub(KEY_NUMPADPLUS,		L["KEY_NUMPADPLUS"])		-- No change necessary
	T = (T):gsub(KEY_NUMPADDECIMAL,	L["KEY_NUMPADDECIMAL"])		-- No change necessary

	-- Mouse
	T = (T):gsub("Mouse Button %",	L["KEY_MOUSEBUTTON"])	-- "M")
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ L["KEY_BINDING"] = "Key Binding"				-- Strings
	L["KEY_BINDINGS"] = "Key Bindings"
	L["KEY_UNBOUND_ERROR"] = "|cffff0000%s Function is Now Unbound!|r"

	L["LALT_KEY_TEXT"] = "Left ALT"				-- ALT
	L["RALT_KEY_TEXT"] = "Right ALT"
	L["LCTRL_KEY_TEXT"] = "Left CTRL"				-- CTRL
	L["RCTRL_KEY_TEXT"] = "Right CTRL"
	L["LSHIFT_KEY_TEXT"] = "Left SHIFT"			-- SHIFT
	L["RSHIFT_KEY_TEXT"] = "Right SHIFT"

	L["KEY_ESCAPE"] = "Escape"

	L["KEY_APOSTROPHE"] = "'"
	L["KEY_BACKSLASH"] = "\\"
	L["KEY_BACKSPACE"] = "Backspace"
	L["KEY_COMMA"] = ","
	L["KEY_ENTER"] = "Enter"
	L["KEY_LEFTBRACKET"] = "["
	L["KEY_MINUS"] = "-"
	L["KEY_PERIOD"] = "."
	L["KEY_PLUS"] = "+"
	L["KEY_RIGHTBRACKET"] = "]"
	L["KEY_SEMICOLON"] = ""
	L["KEY_SLASH"] = "/"
	L["KEY_SPACE"] = "Spacebar"
	L["KEY_TAB"] = "Tab"
	L["KEY_TILDE"] = "~"
	L["KEY_BUTTON1"]  = "Left Mouse Button"		-- ( 34 ) Mouse Buttons
	L["KEY_BUTTON2"]  = "Right Mouse Button"
	L["KEY_BUTTON3"]  = "Middle Mouse"
	L["KEY_BUTTON4"]  = "Mouse Button 4"
	L["KEY_BUTTON5"]  = "Mouse Button 5"
	L["KEY_BUTTON6"]  = "Mouse Button 6"
	L["KEY_BUTTON7"]  = "Mouse Button 7"
	L["KEY_BUTTON8"]  = "Mouse Button 8"
	L["KEY_BUTTON9"]  = "Mouse Button 9"
	L["KEY_BUTTON10"] = "Mouse Button 10"
	L["KEY_BUTTON11"] = "Mouse Button 11"
	L["KEY_BUTTON12"] = "Mouse Button 12"
	L["KEY_BUTTON13"] = "Mouse Button 13"
	L["KEY_BUTTON14"] = "Mouse Button 14"
	L["KEY_BUTTON15"] = "Mouse Button 15"
	L["KEY_BUTTON16"] = "Mouse Button 16"
	L["KEY_BUTTON17"] = "Mouse Button 17"
	L["KEY_BUTTON18"] = "Mouse Button 18"
	L["KEY_BUTTON19"] = "Mouse Button 19"
	L["KEY_BUTTON20"] = "Mouse Button 20"
	L["KEY_BUTTON21"] = "Mouse Button 21"
	L["KEY_BUTTON22"] = "Mouse Button 22"
	L["KEY_BUTTON23"] = "Mouse Button 23"
	L["KEY_BUTTON24"] = "Mouse Button 24"
	L["KEY_BUTTON25"] = "Mouse Button 25"
	L["KEY_BUTTON26"] = "Mouse Button 26"
	L["KEY_BUTTON27"] = "Mouse Button 27"
	L["KEY_BUTTON28"] = "Mouse Button 28"
	L["KEY_BUTTON29"] = "Mouse Button 29"
	L["KEY_BUTTON30"] = "Mouse Button 30"
	L["KEY_BUTTON31"] = "Mouse Button 31"
	L["KEY_MOUSEWHEELDOWN"] = "Mouse Wheel Down"
	L["KEY_MOUSEWHEELUP"]   = "Mouse Wheel Up"
	L["KEY_DOWN"] = "Down Arrow"				-- ( 4 ) Arrows
	L["KEY_LEFT"] = "Left Arrow"
	L["KEY_RIGHT"] = "Right Arrow"
	L["KEY_UP"] = "Up Arrow"
	L["KEY_PRINTSCREEN"] = "Print Screen"		-- ( 3 ) Bank @ Print Screen
	L["KEY_SCROLLOCK"] = "Scroll Lock"
	L["KEY_PAUSE"] = "Pause"
	L["KEY_INSERT"] = "Insert"				-- ( 6 ) Bank above Arrows
	L["KEY_HOME"] = "Home"
	L["KEY_PAGEUP"] = "Page Up"
	L["KEY_DELETE"] = "Delete"
	L["KEY_END"] = "End"
	L["KEY_PAGEDOWN"] = "Page Down"
	L["KEY_NUMLOCK"] = "Num Lock"				-- ( 17 ) Numpad
	L["KEY_NUMPAD0"] = "Num Pad 0"
	L["KEY_NUMPAD1"] = "Num Pad 1"
	L["KEY_NUMPAD2"] = "Num Pad 2"
	L["KEY_NUMPAD3"] = "Num Pad 3"
	L["KEY_NUMPAD4"] = "Num Pad 4"
	L["KEY_NUMPAD5"] = "Num Pad 5"
	L["KEY_NUMPAD6"] = "Num Pad 6"
	L["KEY_NUMPAD7"] = "Num Pad 7"
	L["KEY_NUMPAD8"] = "Num Pad 8"
	L["KEY_NUMPAD9"] = "Num Pad 9"
	L["KEY_NUMPADDECIMAL"] = "Num Pad ."
	L["KEY_NUMPADDIVIDE"] = "Num Pad /"
	L["KEY_NUMPADMINUS"] = "Num Pad -"
	L["KEY_NUMPADMULTIPLY"] = "Num Pad *"
	L["KEY_NUMPADPLUS"] = "Num Pad +"
--]]

--------------------------------------------------
--	VarDump from GlobalStrings.lua
--------------------------------------------------
--[[ LALT_KEY_TEXT = "Left ALT"
	LCTRL_KEY_TEXT = "Left CTRL"
	LSHIFT_KEY_TEXT = "Left SHIFT"
	RALT_KEY_TEXT = "Right ALT"
	RCTRL_KEY_TEXT = "Right CTRL"
	RSHIFT_KEY_TEXT = "Right SHIFT"
	KEY_APOSTROPHE = "'"
	KEY_BACKSLASH = "\\"
	KEY_BACKSPACE = "Backspace"
	KEY_BACKSPACE_MAC = "Delete"
	KEY_BINDING = "Key Binding"
	KEY_BINDINGS = "Key Bindings"
	KEY_BINDINGS_MAC = "Bindings"
	KEY_BOUND = "Key Bound Successfully"
	KEY_BUTTON1 = "Left Mouse Button"
	KEY_BUTTON10 = "Mouse Button 10"
	KEY_BUTTON11 = "Mouse Button 11"
	KEY_BUTTON12 = "Mouse Button 12"
	KEY_BUTTON13 = "Mouse Button 13"
	KEY_BUTTON14 = "Mouse Button 14"
	KEY_BUTTON15 = "Mouse Button 15"
	KEY_BUTTON16 = "Mouse Button 16"
	KEY_BUTTON17 = "Mouse Button 17"
	KEY_BUTTON18 = "Mouse Button 18"
	KEY_BUTTON19 = "Mouse Button 19"
	KEY_BUTTON2 = "Right Mouse Button"
	KEY_BUTTON20 = "Mouse Button 20"
	KEY_BUTTON21 = "Mouse Button 21"
	KEY_BUTTON22 = "Mouse Button 22"
	KEY_BUTTON23 = "Mouse Button 23"
	KEY_BUTTON24 = "Mouse Button 24"
	KEY_BUTTON25 = "Mouse Button 25"
	KEY_BUTTON26 = "Mouse Button 26"
	KEY_BUTTON27 = "Mouse Button 27"
	KEY_BUTTON28 = "Mouse Button 28"
	KEY_BUTTON29 = "Mouse Button 29"
	KEY_BUTTON3 = "Middle Mouse"
	KEY_BUTTON30 = "Mouse Button 30"
	KEY_BUTTON31 = "Mouse Button 31"
	KEY_BUTTON4 = "Mouse Button 4"
	KEY_BUTTON5 = "Mouse Button 5"
	KEY_BUTTON6 = "Mouse Button 6"
	KEY_BUTTON7 = "Mouse Button 7"
	KEY_BUTTON8 = "Mouse Button 8"
	KEY_BUTTON9 = "Mouse Button 9"
	KEY_COMMA = ","
	KEY_DELETE = "Delete"
	KEY_DELETE_MAC = "Del"
	KEY_DOWN = "Down Arrow"
	KEY_END = "End"
	KEY_ENTER = "Enter"
	KEY_ENTER_MAC = "Return"
	KEY_ESCAPE = "Escape"
	KEY_HOME = "Home"
	KEY_INSERT = "Insert"
	KEY_INSERT_MAC = "Help"
	KEY_LEFT = "Left Arrow"
	KEY_LEFTBRACKET = "["
	KEY_MINUS = "-"
	KEY_MOUSEWHEELDOWN = "Mouse Wheel Down"
	KEY_MOUSEWHEELUP = "Mouse Wheel Up"
	KEY_NUMLOCK = "Num Lock"
	KEY_NUMLOCK_MAC = "Clear"
	KEY_NUMPAD0 = "Num Pad 0"
	KEY_NUMPAD1 = "Num Pad 1"
	KEY_NUMPAD2 = "Num Pad 2"
	KEY_NUMPAD3 = "Num Pad 3"
	KEY_NUMPAD4 = "Num Pad 4"
	KEY_NUMPAD5 = "Num Pad 5"
	KEY_NUMPAD6 = "Num Pad 6"
	KEY_NUMPAD7 = "Num Pad 7"
	KEY_NUMPAD8 = "Num Pad 8"
	KEY_NUMPAD9 = "Num Pad 9"
	KEY_NUMPADDECIMAL = "Num Pad ."
	KEY_NUMPADDIVIDE = "Num Pad /"
	KEY_NUMPADMINUS = "Num Pad -"
	KEY_NUMPADMULTIPLY = "Num Pad *"
	KEY_NUMPADPLUS = "Num Pad +"
	KEY_PAGEDOWN = "Page Down"
	KEY_PAGEUP = "Page Up"
	KEY_PAUSE = "Pause"
	KEY_PAUSE_MAC = "F15"
	KEY_PERIOD = "."
	KEY_PLUS = "+"
	KEY_PRINTSCREEN = "Print Screen"
	KEY_PRINTSCREEN_MAC = "F13"
	KEY_RIGHT = "Right Arrow"
	KEY_RIGHTBRACKET = "]"
	KEY_SCROLLOCK = "Scroll Lock"
	KEY_SCROLLLOCK_MAC = "F14"
	KEY_SEMICOLON = ""
	KEY_SLASH = "/"
	KEY_SPACE = "Spacebar"
	KEY_TAB = "Tab"
	KEY_TILDE = "~"
	KEY_UNBOUND_ERROR = "|cffff0000%s Function is Now Unbound!|r"
	KEY_UP = "Up Arrow"
--]]

