local A, C, G, L = select(2, ...):Unpack()

if (not C["Addon"]["DB"]["Enable"]) then
	return
end

local print = function(...)
	A.print("DB", ...)
end


-- Time
L["TIME_ONE_MINUTE"] 	= 60						-- ONE_MINUTE	= 60
L["TIME_ONE_HOUR"] 		= 60 * L["TIME_ONE_MINUTE"]	-- ONE_HOUR	= 60 * ONE_MINUTE
L["TIME_ONE_DAY"] 		= 24 * L["TIME_ONE_HOUR"]	-- ONE_DAY	= 24 * ONE_HOUR
L["TIME_ONE_MONTH"] 	= 30 * L["TIME_ONE_DAY"]		-- ONE_MONTH	= 30 * ONE_DAY
L["TIME_ONE_YEAR"] 		= 12 * L["TIME_ONE_MONTH"]	-- ONE_YEAR	= 12 * ONE_MONTH

L["TIME_FORMAT_SECS"] 	= "< a minute"				-- LASTONLINE_SECS    = "< a minute"
L["TIME_FORMAT_MINUTES"] = "%d |4minute:minutes;"		-- LASTONLINE_MINUTES = "%d |4minute:minutes;"
L["TIME_FORMAT_HOURS"] 	= "%d |4hour:hours;"		-- LASTONLINE_HOURS   = "%d |4hour:hours;"
L["TIME_FORMAT_DAYS"] 	= "%d |4day:days;"			-- LASTONLINE_DAYS    = "%d |4day:days;"
L["TIME_FORMAT_MONTHS"] 	= "%d |4month:months;"		-- LASTONLINE_MONTHS  = "%d |4month:months;"
L["TIME_FORMAT_YEARS"] 	= "%d |4year:years;"		-- LASTONLINE_YEARS   = "%d |4year:years;"





--------------------------------------------------


local EmptyDB = {
	["Eventstamp"] = {
		["ADDON_LOADED"] = true,
		["PLAYER_ENTERING_WORLD"] = true,
	},
	["Datestamp"] = {
		["Login"] = true,
		["ZoneIn"] = true,
		["Logout"] = true,
		["Slash"] = true,
	},
	["Timestamp"] = {
		["Login"] = 0,
		["ZoneIn"] = 0,
		["Logout"] = 0,
		["Slash"] = 0,
	},
	["Counter"] = {
		["Login"] = 0,
		["ZoneIn"] = 0,
		["Logout"] = 0,
		["Slash"] = 0,
	},
}


local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('PLAYER_LOGOUT')
f:SetScript('OnEvent', function(self, event, addon)

	if (event == 'ADDON_LOADED' and addon == 'AddOn') then					-- print('Event', 'ADDON_LOADED')
		TruthDB["Eventstamp"]["ADDON_LOADED"] = date()
		TruthDB["Datestamp"]["Login"] = date()
		TruthDB["Timestamp"]["Login"] = time()
		TruthDB["Counter"]["Login"] = TruthDB["Counter"]["Login"] + 1
	end

	if (event == 'PLAYER_ENTERING_WORLD') then							-- print('Event', 'PLAYER_ENTERING_WORLD')
		TruthDB["Eventstamp"]["PLAYER_ENTERING_WORLD"] = date()
		TruthDB["Datestamp"]["ZoneIn"] = date()
		TruthDB["Timestamp"]["ZoneIn"] = time()
		TruthDB["Counter"]["ZoneIn"] = TruthDB["Counter"]["ZoneIn"] + 1
	end

	if (event == 'PLAYER_LOGOUT') then
		TruthDB["Datestamp"]["Logout"] = date()
		TruthDB["Timestamp"]["Logout"] = time()
		TruthDB["Counter"]["Logout"] = TruthDB["Counter"]["Logout"] + 1
	end

end)


SlashCmdList["TRUTH_DATE"] = function()			-- Date
	TruthDB["Datestamp"]["Slash"] = date()
	TruthDB["Counter"]["Slash"] = TruthDB["Counter"]["Slash"] + 1
	print('Slash: ', 'TRUTH_DATE')
end

SlashCmdList["TRUTH_TIME"] = function()			-- Time
	TruthDB["Timestamp"]["Slash"] = time()
	TruthDB["Counter"]["Slash"] = TruthDB["Counter"]["Slash"] + 1
	print('Slash: ', 'TRUTH_TIME')
end

_G['SLASH_TRUTH_DATE1'] = '/truthdate'
_G['SLASH_TRUTH_TIME1'] = '/truthtime'



--------------------------------------------------
--	Reference
--------------------------------------------------
--[[ FriendsFrame_GetLastOnline (edited)

	local ONE__MINUTE	= 60
	local ONE__HOUR	= 60 * ONE__MINUTE
	local ONE__DAY		= 24 * ONE__HOUR
	local ONE__MONTH	= 30 * ONE__DAY
	local ONE__YEAR	= 12 * ONE__MONTH

	local function FriendsFrame_GetLastOnline(timeDifference, isAbsolute)
		if (not isAbsolute) then
			timeDifference = time() - timeDifference
		end

		local year, month, day, hour, minute

		if (timeDifference < ONE__MINUTE) then
			return LASTONLINE_SECS

		elseif (timeDifference >= ONE__MINUTE and timeDifference < ONE__HOUR) then
			return format(LASTONLINE_MINUTES, floor(timeDifference / ONE__MINUTE))

		elseif (timeDifference >= ONE__HOUR and timeDifference < ONE__DAY) then
			return format(LASTONLINE_HOURS, floor(timeDifference / ONE__HOUR))

		elseif (timeDifference >= ONE__DAY and timeDifference < ONE__MONTH) then
			return format(LASTONLINE_DAYS, floor(timeDifference / ONE__DAY))

		elseif (timeDifference >= ONE__MONTH and timeDifference < ONE__YEAR) then
			return format(LASTONLINE_MONTHS, floor(timeDifference / ONE__MONTH))

		else
			return format(LASTONLINE_YEARS, floor(timeDifference / ONE__YEAR))
		end
	end
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ TruthDB = {
		["Eventstamp"] = {
			["ADDON_LOADED"] = true,
			["PLAYER_ENTERING_WORLD"] = true,
		},
		["Datestamp"] = {
			["Login"] = true,
			["ZoneIn"] = true,
			["Logout"] = true,
			["Slash"] = true,
		},
		["Timestamp"] = {
			["Login"] = true,
			["ZoneIn"] = true,
			["Logout"] = true,
			["Slash"] = true,
		},
		["Counter"] = {
			["Login"] = 0,
			["ZoneIn"] = 0,
			["Logout"] = 0,
			["Slash"] = 0,
		},
	}
--]]
