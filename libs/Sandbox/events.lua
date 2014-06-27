local pairs = pairs
local select = select
local unpack = unpack
local ceil = math.ceil
local setmetatable = setmetatable
local IsLoggedIn = IsLoggedIn
--------------------------------------------------
--	Addon
--------------------------------------------------
local A, C, G, L = select(2, ...):Unpack()

local print = function(...) A.print('Events', ...) end


--------------------------------------------------
--	Saved Variables
--------------------------------------------------
A.dbname = "TruthDB"
A.dbpcname = "TruthDBPC"

A.dbdefaults = {
	["Welcome"] = false,
	["Counters"] = {						-- ["Slash"] = 0,
		["Enable"] = false,
		["Loaded"] = 0,
		["Login"] = 0,
		["ZoneIn"] = 0,
		["Logout"] = 0,
	},
	["Slashcount"] = 0,
	["Timestamps"] = {
		["Enable"] = false,
		["ADDON_LOADED"] = true,
		["PLAYER_LOGIN"] = true,
		["PLAYER_ENTERING_WORLD"] = true,
		["PLAYER_LOGOUT"] = true,
	},
}
A.dbpcdefaults = {
	["Welcome"] = false,
	["Counters"] = {
		["Enable"] = true,
	},
	["Slashcount"] = 0,
	["Timestamps"] = {
		["Enable"] = true,
	},
}


--------------------------------------------------
--	Addon
--------------------------------------------------
local E = CreateFrame('Frame')				--, "TruEvent")


--------------------------------------------------
--	Event Mapping
--------------------------------------------------
function A.RegisterEvent(event, func)
	if (func) then
		A[event] = func
	end

	E:RegisterEvent(event)
end

function A.UnregisterEvent(event)
	E:UnregisterEvent(event)
end

function A.UnregisterAllEvents()
	E:UnregisterAllEvents()
end


--------------------------------------------------
--	Event Handlers
--------------------------------------------------
local ProcessOnLogin, ProcessOnLoad, ProcessLogout

ProcessOnLogin = function()
--	Handles special OnLogin code for when the PLAYER_LOGIN event is fired.
--	If our addon is loaded after that event is fired, then we call it immediately
--	after the OnLoad handler is processed

	if (A.OnLogin) then
		A.OnLogin()
		A.OnLogin = nil
	end

	ProcessOnLogin = nil

	if (not A.PLAYER_LOGIN) then
		E:UnregisterEvent("PLAYER_LOGIN")
	end
end

ProcessOnLoad = function(addon)
	if (addon ~= AddOn) then return end

	if (A.dbname) then
		local defaults = A.dbdefaults or {}
		local Database = _G[A.dbname]
		Database = setmetatable(Database or {}, {__index = defaults})
		A.db = Database
	end

	if (A.dbpcname) then
		local defaults = A.dbpcdefaults or {}
		local DatabasePerChar = _G[A.dbpcname]
		DatabasePerChar = setmetatable(DatabasePerChar or {}, {__index = defaults})
		A.dbpc = DatabasePerChar
	end

	if (A.OnLoad) then
		A.OnLoad()
		A.OnLoad = nil
	end

	ProcessOnLoad = nil

	if (not A.ADDON_LOADED) then				-- If A.ADDON_LOADED is defined, the ADDON_LOADED event is not unregistered
		E:UnregisterEvent("ADDON_LOADED")
	end

	if (A.dbdefaults or A.dbpcdefaults) then
		A.RegisterEvent("PLAYER_LOGOUT")
	end

	if (IsLoggedIn()) then
		ProcessOnLogin()
	else
		E:RegisterEvent("PLAYER_LOGIN")
	end
end

ProcessLogout = function()
--	Remove defaults from DB & DBPC during logout
	if (A.dbdefaults) then
		for i, v in pairs(A.dbdefaults) do
			if (A.db[i] == v) then
				A.db[i] = nil
			end
		end
	end
	if (A.dbpcdefaults) then
		for i, v in pairs(A.dbpcdefaults) do
			if (A.dbpc[i] == v) then
				A.dbpc[i] = nil
			end
		end
	end
end


--------------------------------------------------
--	Events
--------------------------------------------------
E:RegisterEvent("ADDON_LOADED")
E:SetScript("OnEvent", function(self, event, arg1, ...)

	if (ProcessOnLoad and event == "ADDON_LOADED") then
		ProcessOnLoad(arg1)
	end

	if (ProcessOnLogin and event == "PLAYER_LOGIN") then
		ProcessOnLogin()
	end

	if (event == "PLAYER_LOGOUT") then
		ProcessLogout()
	end

	if (A[event]) then
		A[event](event, arg1, ...)
	end

end)