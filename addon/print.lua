local A, C, G, L = select(2, ...):Unpack()
local ADDON_HEADER = G.ADDON_HEADER


local print, debug, error, warn

local UIErrorMessage, RaidWarning, RaidNotice, SendCombatErrorMsg


--------------------------------------------------
local divider, newline, section





--------------------------------------------------

do
	local format, gsub, tostring, upper = string.format, string.gsub, tostring, string.upper
	local pairs, select = pairs, select
	local geterrorhandler = geterrorhandler
	local UIErrorsFrame = UIErrorsFrame
	local RaidWarningFrame = RaidWarningFrame
	local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
	local RaidNotice_AddMessage = RaidNotice_AddMessage


	newline = function()
		DEFAULT_CHAT_FRAME:AddMessage(" ")
	end

	divider = function(label)
		DEFAULT_CHAT_FRAME:AddMessage(" ")
		DEFAULT_CHAT_FRAME:AddMessage(L["DIV"])

		if (label) then
			DEFAULT_CHAT_FRAME:AddMessage(L["INDENT_FORMAT"]:format(label))		-- DEFAULT_CHAT_FRAME:AddMessage(("     %s"):format(label))
		end

		DEFAULT_CHAT_FRAME:AddMessage(" ")
	end


	print = function(self, key, value, ...)
		self  = ("|cff82C5FF%s|r"):format(self:gsub("^%l", upper))				-- Bnet
		key   = ("|cff3399FF%s|r"):format(tostring(key))						-- Blue
		value = ("|cffE4F3FF%s|r"):format(tostring(value and value or " "))		-- Sky

		local args = ... and ... or ""									-- if (...) then args = ... end

		DEFAULT_CHAT_FRAME:AddMessage(("%s %s %s %s|cffFFFF80 %s |r"):format(ADDON_HEADER, self, key, value, args))
	--	print(("%s %s %s %s "):format(ADDON_HEADER, self, key, value), ...)
	end


	debug = function(level, msg, ...)
		if (level > 0 or not msg) then
			return
		end

		if (...) then
			if (msg:match("%%")) then
				msg = msg:format(...)
			else
				msg = gsub(", ", msg, ...)	-- join = gsub ?
			end
		end

	--	print("debug", msg)

		DEFAULT_CHAT_FRAME:AddMessage(("%s|cffFF0000 [debug] %s |r"):format(ADDON_HEADER, msg))
	end


	error = function(msg, useUIErrorsFrame)
		if (not msg) then
			return
		end

		if (useUIErrorsFrame) then
		--	print("error", msg)
			msg = ("%s|cffFF0000 [error] %s |r"):format(ADDON_HEADER, msg)

			UIErrorsFrame:AddMessage(("%s|cffFF0000 [error] %s |r"):format(ADDON_HEADER, msg), 1, 0, 0, 1)
		else
		--	geterrorhandler()(msg)
			geterrorhandler()(("%s|cffFF0000 [error] %s |r"):format(ADDON_HEADER, msg))
		end
	end


	warn = function(self, msg)				-- , r, g, b)		-- gUI
		RaidNotice_AddMessage(RaidWarningFrame, msg, {r = 1.0, g = 0.49, b = 0.04})
	--	RaidNotice_AddMessage(RaidWarningFrame, msg, {r = r or 1.0, g = g or 0.49, b = b or 0.04})
	end

	UIErrorMessage = function(self, msg, r, g, b)
		UIErrorsFrame:AddMessage(msg, r or 1, g or 0, b or 0, 1.0)
	end

	RaidWarning = function(self, msg, r, g, b)
		RaidNotice_AddMessage(RaidWarningFrame, msg, { r = r or 1, g = g or 0.49, b = b or 0.04 })
	end

	RaidNotice = function(self, msg, r, g, b)
		if not(r) then
			RaidNotice_AddMessage(RaidBossEmoteFrame, msg, ChatTypeInfo["RAID_BOSS_EMOTE"])
		else
			RaidNotice_AddMessage(RaidBossEmoteFrame, msg, { r = r or 1, g = g or 0.49, b = b or 0.04 })
		end
	end

	SendCombatErrorMsg = function()
		print(ERR_NOT_IN_COMBAT)
	end

end

A.divider = divider
A.newline = newline

A.print = print
A.debug = debug
A.error = error
A.warn = warn

A.SendCombatErrorMsg = SendCombatErrorMsg




---------------------------------------------
local pairs = pairs
local tostring = tostring
local select = select


local echo
local table_print

do
	echo = function(...)
		local msg = ""

		for k, v in pairs({...}) do
			msg = msg .. k .. "=[" .. tostring(v)  .. "] "
		end

	--	print("echo", msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end


	table_print = function(...)
		local args = ...

		local function getVals(...)
			return { select("#", ...), ... }
		end

	--   print("tprint", msg)
		DEFAULT_CHAT_FRAME:AddMessage(getVals(args))
	end
end

A.echo = echo
A.table_print = table_print
A.tprint = table_print


--------------------------------------------------
--	Print Function Example
--------------------------------------------------
--[[ Inefficient Function

	local function print(...)
		local output = ""
		local n = select("#", ...)

		for i = 1, (n) do
			output = output .. tostring(select(i, ...))
			if (i < n) then
				output = output .. ", "
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage("MyAddon: " .. output)
	end

	-- Improved Function

	local function toManyStrings(...)
		if (select("#", ...) > 0) then
			return tostring((...)), toManyStrings(select(2, ...))
		end
	end

	local function print(...)
		DEFAULT_CHAT_FRAME:AddMessage("MyAddon: " .. strjoin(", ", toManyStrings(...)))
	end
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ A.print

	A.print = function(file, key, value, ...)
		file  = format("%s%s", BATTLENET_FONT_COLOR_CODE, file:gsub("^%l", upper))
		key   = format("%s%s", MY_BLU_COLOR_CODE, tostring(key))
		value = format("%s%s", MY_SKY_COLOR_CODE, tostring(value and value or " "))
		print(format("%s %s:  %s  %s ", AddonName, file, key, value), ...)					-- DEFAULT_CHAT_FRAME:AddMessage(format("%s %s:  %s  %s", AddonName, file, key, value))
	end
--]]

--[[ Addon.Print (credit: _Dev)

	local Print
	do
		local tostring = tostring
		local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
		local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
		Print = function(message, frame, color)
			message = tostring(message)
			frame = frame and frame or DEFAULT_CHAT_FRAME
			color = color and color or NORMAL_FONT_COLOR
			frame:AddMessage(message, color.r, color.g, color.b, color.id)
		end
	end
--]]

--[[	Addon.Error (credit: _Dev)

	local Error
	do
		local geterrorhandler = geterrorhandler
		local RED_FONT_COLOR = RED_FONT_COLOR
		Error = function(message, forceprint)
			if (forceprint) then
				A.Print(message, nil, RED_FONT_COLOR)
			else
				geterrorhandler()(message)
			end

		end
	end
--]]

--[[	Section

	section = function(func)
		divider()
		func()
		divider()
	end
	A.section = section
--]]

--------------------------------------------------
--	Pattern Matching
--------------------------------------------------
--[[ Search for a date in the format:  dd/mm/yyyy
	using the pattern:  "%d%d/%d%d/%d%d%d%d":

		s = "Deadline is 30/05/1999, firm"
		date = "%d%d/%d%d/%d%d%d%d"
		print(sub(s, find(s, date))) --> 30/05/1999

	The following table lists all character classes:

	----------------------------------------
			  Character Classes
	----------------------------------------
	  .  all characters
	 %a  letters
	 %c  control characters
	 %d  digits
	 %g  printable characters except spaces
	 %l  lower-case letters
	 %p  punctuation characters
	 %s  space characters
	 %u  upper-case letters
	 %w  alphanumeric characters
	 %x  hexadecimal digits
	----------------------------------------

	Examples
	--------
	"%.2f"		means:  format this var as a number with two decimal places
				usage:  text = format("%.2f, %.2f”, x, y)
--]]

--------------------------------------------------
--	Custom Print Function (credit: QTip)
--------------------------------------------------
--[[	local D

	do
		local print = print
		local upper = string.upper

		D = function(tag, msg, ...)
			local tag = '|cffCC3333 Truth|r:' .. '|cffDB7070' .. upper(tag) .. '|r '
			local msg = '|cffFFFFFF' .. msg .. '|r '
			local dot = ''

			if (...) then
				dot = '|cffFFFF80' .. ... .. '|r'
			end

			DEFAULT_CHAT_FRAME:AddMessage(tag .. msg .. dot)
		end
	end

	D(format('%s%s%s: %s%s %s%s', L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.COLOR_GREY, L.N_L_QTIP, L.NOT_QTIP, L.COLOR_STOP))

	A.print = D
--]]

--------------------------------------------------
--	SysMsg
--------------------------------------------------
--[[ A.sysmsg = function(...)
		print(self:tostring(" ", 200, ...), 1, .5, 0)
	end
--]]
