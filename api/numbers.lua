local A, C, G, L = select(2, ...):Unpack()

local type, unpack = type, unpack
local format, gsub, match, reverse = string.format, string.gsub, string.match, string.reverse
local floor, min = math.floor, math.min
local time = time


A.STATUSBAR_NUMBER_FORMATS = {
	['CURRENT'] 			= "%s",
	['CURRENT_MAX']		= "%s - %s",
	['CURRENT_PERCENT']		= "%s - %s%%",
	['CURRENT_MAX_PERCENT']	= "%s - %s | %s%%",
	['DEFICIT'] 			= "-%s",
	['PERCENT'] 			= "%s%%",
}



--------------------------------------------------
A.TimeRemainingToColor = function(ratio)		-- credit: MalygosStacks (by Nebula)
--	Color the text based on the remaining time
	ratio = min(1, ratio)

	return ("%02x%02x00"):format((1 - ratio) * 255, ratio * 255)

--	text:SetFormattedText("|cff%s %0.1f s|r", TimeRemainingToColor(remaining/15), remaining)
end

A.Truncate = function(number)					-- MonoUI.Tooltip
--	GameTooltipStatusBar: Truncates HP values
	if (number >= 1e6) then
		return ("%.2fm"):format(number / 1e6)
	elseif (number >= 1e4) then
		return ("%.1fk"):format(number / 1e3)
	else
		return ("%.0f"):format(number)
	end
end

--------------------------------------------------
local round = function (num)					-- HybridScrollFrame.lua
	return floor(num + 0.5)
end
A.round = round

A.Round = function(number, decimals)
--	Remove decimal from a number
	return (("%%.%df"):format(decimals or 0)):format(number)
end

--------------------------------------------------
local ToRGB, HexToRBG, RGBToHex, RGBHex, RGBtoCFF

do
	local sub = string.sub
	local tonumber = tonumber


	ToRGB = function(hex)					-- ElvUI  |  math.lua
	--	Hex to RGB

		local rhex, ghex, bhex = sub(hex, 1, 2), sub(hex, 3, 4), sub(hex, 5, 6)

		return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
	end


	HexToRBG = function(hex)					-- AzOptionsFactory
	--	Converts string colors to RGBA

		local a, r, g, b = hex:match("^|c(..)(..)(..)(..)")

		return ("%d"):format("0x"..r)/255, ("%d"):format("0x"..g)/255, ("%d"):format("0x"..b)/255, ("%d"):format("0x"..a)/255
	end


	RGBToHex = function(r, g, b)
		r = ((r <= 1) and (r >= 0)) and r or 0
		g = ((g <= 1) and (g >= 0)) and g or 0
		b = ((b <= 1) and (b >= 0)) and b or 0

		return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end


	RGBHex = function(r, g, b)					-- NeavUI  |  Plates/core.lua
		if (type(r) == "table") then
			if (r.r) then
				r, g, b = r.r, r.g, r.b
			else
				r, g, b = unpack(r)
			end
		end
		return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end


	RGBtoCFF = function(r, g, b, a)				-- Blizzard_CombatLog  |  CombatLog_Color_FloatToText(r, g, b, a)
	--	Converts 4 floats into FF code

		if (type(r) == "table") then
			r = r.r
			g = r.g
			b = r.b
			a = r.a
		end

		a = min(1, a or 1) * 255
		r = min(1, r) * 255
		g = min(1, g) * 255
		b = min(1, b) * 255

		-- local fmt = "%.2x"
		return ("|cff%.2x%.2x%.2x%.2x"):format(floor(a), floor(r), floor(g), floor(b))										-- return ("%.2x%.2x%.2x%.2x"):format(floor(a), floor(r), floor(g), floor(b))
	end
end

--	A.ToRGB = ToRGB
--	A.HexToRBG = HexToRBG
--	A.RGBToHex = RGBToHex
--	A.RGBHex = RGBHex
--	A.RGBtoCFF = RGBtoCFF


--------------------------------------------------
A.Comma = function(n)						-- AsphyxiaUI | Handler/Math.lua
--	Add comma to separate thousands
	local left, number, right = n:match("^([^%d]*%d)(%d*)(.-)$")
	return left .. (number:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
end

--[[ Example Usage

--	FontString:SetText(("%s: %s"):format("TOTAL_RAID_DAMAGE", A.Comma(value)))

	print(Commas(9))					=>  9
	print(Commas(999))                 	=>  999
	print(Commas(1000))                	=>  1,000
	print(Commas('1333444.10'))        	=>  1,333,444.10
	print(Commas('US$1333400'))        	=>  US$1,333,400
	print(Commas('-$22333444.56'))     	=>  -$22,333,444.56
	print(Commas('($22333444.56)'))    	=>  ($22,333,444.56)
	print(Commas('NEG $22333444.563')) 	=>  NEG $22,333,444.563

	Credit: lua-users.org/wiki/FormattingNumbers
--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ GetLastTime

	local L_ONE_MINUTE		= L["TIME_ONE_MINUTE"]			-- ONE_MINUTE	= 60
	local L_ONE_HOUR		= L["TIME_ONE_HOUR"]          	-- ONE_HOUR	= 60 * ONE_MINUTE
	local L_ONE_DAY		= L["TIME_ONE_DAY"]           	-- ONE_DAY	= 24 * ONE_HOUR
	local L_ONE_MONTH		= L["TIME_ONE_MONTH"]         	-- ONE_MONTH	= 30 * ONE_DAY
	local L_ONE_YEAR 		= L["TIME_ONE_YEAR"]          	-- ONE_YEAR	= 12 * ONE_MONTH
	local L_FORMAT_SECS		= L["TIME_FORMAT_SECS"]       	-- LASTONLINE_SECS    = "< a minute"
	local L_FORMAT_MINUTES	= L["TIME_FORMAT_MINUTES"]    	-- LASTONLINE_MINUTES = "%d |4minute:minutes"
	local L_FORMAT_HOURS	= L["TIME_FORMAT_HOURS"]      	-- LASTONLINE_HOURS   = "%d |4hour:hours"
	local L_FORMAT_DAYS		= L["TIME_FORMAT_DAYS"]       	-- LASTONLINE_DAYS    = "%d |4day:days"
	local L_FORMAT_MONTHS	= L["TIME_FORMAT_MONTHS"]     	-- LASTONLINE_MONTHS  = "%d |4month:months"
	local L_FORMAT_YEARS	= L["TIME_FORMAT_YEARS"]      	-- LASTONLINE_YEARS   = "%d |4year:years"

	A.GetLastTime = function(TimeDifference, isAbsolute)		-- credit: FriendsFrame.lua [ FriendsFrame_GetLastOnline (func) ]
	--	Get amount of time since "last occurance"
	--	Usage: text = BNET_LAST_ONLINE_TIME:format(A.GetLastTime(LastOnline))

		if (not isAbsolute) then
			TimeDifference = time() - TimeDifference
		end
		local s = TimeDifference

		if     (s <  L_ONE_MINUTE) then return L_FORMAT_SECS
		elseif (s >= L_ONE_MINUTE  and s < L_ONE_HOUR)  then return (L_FORMAT_MINUTES):format(floor(s / L_ONE_MINUTE))
		elseif (s >= L_ONE_HOUR    and s < L_ONE_DAY)   then return (L_FORMAT_HOURS  ):format(floor(s / L_ONE_HOUR))
		elseif (s >= L_ONE_DAY     and s < L_ONE_MONTH) then return (L_FORMAT_DAYS   ):format(floor(s / L_ONE_DAY))
		elseif (s >= L_ONE_MONTH   and s < L_ONE_YEAR)  then return (L_FORMAT_MONTHS ):format(floor(s / L_ONE_MONTH))
		else return (L_FORMAT_YEARS):format(floor(s / L_ONE_YEAR))
		end
	end
--]]

--[[ Short Value (negative)

	A.ShortValueNegative = function(v)
		if (v <= 999) then
			return v
		end
		if (v >= 1000000) then
			local value = format("%.1fm", v / 1000000)
			return value
		elseif (v >= 1000) then
			local value = format("%.1fk", v / 1000)
			return value
		end
	end
--]]

--[[ Short Value

	A.ShortValue = function(v)
		if (v >= 1e9) then
			return ("%.1fb"):format(v / 1e9):gsub("%.?0+([kmb])$", "%1")
		elseif (v >= 1e6) then
			return ("%.1fm"):format(v / 1e6):gsub("%.?0+([kmb])$", "%1")
		elseif (v >= 1e3 or v <= -1e3) then
			return ("%.1fk"):format(v / 1e3):gsub("%.?0+([kmb])$", "%1")
		else
			return v
		end
	end
--]]

--[[ Format Number

	A.FormatNumber = function(nf, min, max)
		assert(NumberFormats[nf], 'Invalid number format (nf): ' .. nf)
		assert(min, 'Current value required.  Usage:  A.FormatNumber(nf, min, max)')
		assert(max, 'Maximum value required.  Usage:  A.FormatNumber(nf, min, max)')

		if (max == 0) then
			max = 1
		end

		local useNF = NumberFormats[nf]

		if (nf == 'DEFICIT') then
			local deficit = max - min
			if (deficit <= 0) then
				return ''
			else
				return format(useNF, ShortValue(deficit))
			end

		elseif (nf == 'PERCENT') then
			local s = format(useNF, format("%.1f", min / max * 100))
			s = s:gsub(".0%%", "%%")
			return s

		elseif (nf == 'CURRENT' or ((nf == 'CURRENT_MAX' or nf == 'CURRENT_MAX_PERCENT' or nf == 'CURRENT_PERCENT') and min == max)) then
			return format(NumberFormats['CURRENT'], ShortValue(min))

		elseif (nf == 'CURRENT_MAX') then
			return format(useNF, ShortValue(min), ShortValue(max))

		elseif (nf == 'CURRENT_PERCENT') then
			local s = format(useNF, ShortValue(min), format("%.1f", min / max * 100))
			s = s:gsub(".0%%", "%%")
			return s

		elseif (nf == 'CURRENT_MAX_PERCENT') then
			local s = format(useNF, ShortValue(min), ShortValue(max), format("%.1f", min / max * 100))
			s = s:gsub(".0%%", "%%")
			return s
		end
	end
--]]

--[[ IsPositiveNumber (boolean)

	A.IsPositiveNumber = function(value)
		if (type(value) ~= 'number') then
			error(format('%s must be a number, got %s.', '%s', type(value)))
		end

		if (value <= 0) then
			error('%s must be greater than zero.')
		end

		return value
	end
--]]

--[[ Counter / Tracker

	A.Counter = function(start, increment)
	--  usage:
	--	odds = Counter(1, 2)
	--	by10 = Counter(0, 10)

		local count = start

		return function()
			local n = count
			count = increment

			return n
		end
	end
--]]

