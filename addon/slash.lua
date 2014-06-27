local A, C, G, L = select(2, ...):Unpack()

local ADDON_NAME = A.ADDON_NAME:upper()			-- SlashCmds require UPPERCASE

local print = function(...) A.print("Slash", ...) end
local error = function(...) A.error(...) end


local Slash
local SlashList
local OnEvent

do
	local type = type
	local pairs = pairs
	local lower, upper = string.lower, string.upper
	local SlashCmdList = SlashCmdList
	local IsAddOnLoaded = IsAddOnLoaded


	Slash = function(cmd, name, func)
		if (not cmd or not name or not func) then
			error("function Slash(CommandString, NameString, Function)\nSlash can not accept null values")  return
		end
		if (type(cmd) ~= "string") or (not name or type(name) ~= "string") or (not func or type(func) ~= "function") then
			print("usage:", "Slash(CommandString, NameString, Function)")  return
		end

		cmd  = ("/%s"):format(cmd:lower())								-- "/reload"
		name = ("%s_%s"):format(ADDON_NAME, name:upper())					-- "TRUTH_RELOAD_UI"

		_G[("SLASH_%s1"):format(name)] = cmd							-- _G["SLASH_TRUTH_RELOAD_UI1"]

		SlashCmdList[name] = func									--  SlashCmdList["TRUTH_RELOAD_UI"]
	end


	SlashList = {
		["rl"]	= { name = "RELOAD",	func = ReloadUI },
		["d"]	= { name = "DUMP",		func = SlashCmdList["DUMP"] },
		["out"]	= { name = "OUTLINE",	func = SlashCmdList["FRAMESTACK"] },
		["rc"]	= { name = "READYCHECK",	func = DoReadyCheck },
		["rg"]	= { name = "RESTARTGX",	func = RestartGx },
	}


	OnEvent = function(self, event, addon, ...)					-- if (not IsAddOnLoaded("_Dev")) then print("_Dev not loaded.") else
		for cmd, slash in pairs(SlashList) do

			if (IsAddOnLoaded("_Dev")) then
				SlashList["out"]["func"] = SlashCmdList["_DEV_OUTLINE"]
			else
				print("_Dev", "not loaded")
			end

			Slash(cmd, slash.name, slash.func)
		end

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', OnEvent)
end

A.Slash = Slash


--[[ Slash List

	SlashList = {
		["rl"] = {
			name = "RELOAD",
			func = ReloadUI,
		},
		["d"] = {
			name = "DUMP",
			func = SlashCmdList["DUMP"]
		},
		["out"] = {
			name = "OUTLINE",
			func = SlashCmdList["FRAMESTACK"]		-- Prevents errors when _Dev (addon) is disabled
		},
		["rc"] = {
			name = "READYCHECK",
			func = DoReadyCheck,
		},
		["rg"] = {
			name = "RESTARTGX",
			func = RestartGx,
		},
	}

	SlashList = {
		["rl"]	= { "RELOAD", ReloadUI },
		["d"]	= { "DUMP", SlashCmdList["DUMP"] },
		["out"]	= { "OUTLINE", SlashCmdList["FRAMESTACK"] },
		["rc"]	= { "READYCHECK", DoReadyCheck },
		["rg"]	= { "RESTARTGX", RestartGx },
	}
--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Custom Framestack
do
	local format = string.format
	local UIParent = UIParent
	local GetMouseFocus = GetMouseFocus

	A.Slash("CFS", "CUSTOM_FRAMESTACK", function(F)
		F = F and _G[F] or GetMouseFocus()
		if (F and F:GetName()) then
			local Parent = F:GetParent() and F:GetParent() or A.UIParent
			local p1, p2, p3, p4, p5 = F:GetPoint()
			local anchor = p2 and p2 or A.UIParent

			DEFAULT_CHAT_FRAME:AddMessage("\n")
			print(L["DIV"])
			print(L["FRAME"],  format("  %s", F:GetName()), format("(%s)", (F ~= Parent) and Parent:GetName() or L["UNKNOWN"]))
			print(L["SIZE"],   format("   %.1f,", F:GetWidth()), format("%.1f", F:GetHeight()))
			print(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, anchor:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
			print(L["SCALE"],  format("  %.1f", F:GetScale()), format("(%.1f)", F:GetEffectiveScale()))
			print(L["ALPHA"],  format("  %.1f", F:GetAlpha()), format("(%.1f)", F:GetEffectiveAlpha()))
			print(L["STRATA"], format(" %s", F.GetFrameStrata and F:GetFrameStrata()), format("(%d)", F:GetFrameLevel()))
			print(L["DIV"])
			DEFAULT_CHAT_FRAME:AddMessage("\n")
		end
	end)
end
--]]

--[[ Resolution

	local GetCurrentResolution = GetCurrentResolution
	local GetScreenResolutions = GetScreenResolutions
	local SetCVar = SetCVar

	A.Slash("RESO", "RESOLUTION", function()
		if (({GetScreenResolutions()})[GetCurrentResolution()] == "2560x1440") then
			SetCVar("gxWindow", 1)
			SetCVar("gxResolution", "1920x1080")
		else
			SetCVar("gxWindow", 0)
			SetCVar("gxResolution", "2560x1440")
		end
		RestartGx()
	end)
--]]

--------------------------------------------------
--	Slash - API Description
--------------------------------------------------
--[[ Slash(cmd, name, func)

	usage:	>  A.Slash("rl", "RELOAD_UI", ReloadUI)

	step 1:	Register our cmd with the global slash handler
			>  _G['SLASH_' .. ADDON .. '_RELOAD_UI1'] = '/rl'

	step 2:	Create smart entry for SlashCmdList
			>  SlashCmdList[ADDON .. '_RELOAD_UI'] = ReloadUI
--]]

--------------------------------------------------
--	A.Slash EXAMPLES
--------------------------------------------------
--[[ New Slashes (hardcoded)

	A.Slash("RL", "RELOAD_UI", ReloadUI)
	A.Slash("D", "DUMP", SlashCmdList['DUMP'])
	A.Slash("OUT", "OUTLINE", SlashCmdList['_DEV_OUTLINE'] or SlashCmdList['FRAMESTACK'])
--]]

--------------------------------------------------
--	Backup (original hardcoded slash cmds) [WORKING CODE ONLY]
--------------------------------------------------
--[[ Reload UI
	--
	_G['SLASH_' .. ADDON .. '_RELOAD_UI1'] = '/rl'
	SlashCmdList[ADDON .. '_RELOAD_UI'] = ReloadUI


	_Dev Outline Alias
	--
	SLASH_TRUTH_OUTLINE1 = '/out'
	SlashCmdList['TRUTH_OUTLINE'] = SlashCmdList['_DEV_OUTLINE']


	Dump Alias
	--
	SLASH_TRUTH_DUMP1 = '/d'
	SlashCmdList['TRUTH_DUMP'] = SlashCmdList['DUMP']
--]]

--------------------------------------------------
--	TexBrowser
--------------------------------------------------
--[[	if (not IsAddOnLoaded("TexBrowser")) then
		LoadAddOn("TexBrowser")
	end

	SlashCmdList["TRUH_LOD"] = function()
		if (IsAddOnLoaded("TexBrowser")) then
			return
		else
			LoadAddOn("TexBrowser")
		end
	end

	SLASH_TRUTH_LOD1 = "/tb"
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Assert

	assert(_Dev, '_Dev not found')

--]]




