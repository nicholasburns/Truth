local AddonName, Addon = ...

_G[AddonName] = Addon						-- _G["Truth"] = Addon

Addon[1] = {}								-- A
Addon[2] = {}								-- C
Addon[3] = {}								-- G
Addon[4] = {}								-- L

function Addon:Unpack()
	return self[1], self[2], self[3], self[4]
end


-- Cache Environment
Addon[3] = _G								-- local select = G.select


--------------------------------------------------

local noop = function() return end				-- [No Op]eration
_G.noop = noop								-- Global reference to our noop function
Addon[3].noop = noop


--------------------------------------------------

-- Coordinates								-- Addon[3]["TexCoords"] = {0.08, 0.92, 0.08, 0.92}
local G = Addon[3]

G.TexCoords = {
	[1] = 0.08,
	[2] = 0.92,
	[3] = 0.08,
	[4] = 0.92,
}

function G.TexCoords:Unpack()
	return self[1], self[2], self[3], self[4]
end


--------------------------------------------------
--[[ _G

G.time	= _G.time

G.type	= _G.type

G.select	= _G.select
G.unpack	= _G.unpack

G.pairs	= _G.pairs
G.ipairs	= _G.ipairs

G.math	= _G.math
G.ceil	= _G.math.ceil
G.floor	= _G.math.floor
G.max	= _G.math.max
G.min	= _G.math.min

G.string	= _G.string
G.find	= _G.string.find
G.format	= _G.string.format
G.gsub	= _G.string.gsub
G.lower	= _G.string.lower
G.match	= _G.string.match
G.upper	= _G.string.upper
G.reverse	= _G.string.reverse

G.table	= _G.table
G.insert	= _G.table.insert



G.rawget = _G.rawget
G.rawset = _G.rawset
G.getmetatable = _G.getmetatable
G.setmetatable = _G.setmetatable

G.collectgarbage = _G.collectgarbage
--]]


--------------------------------------------------

-- Frames
G.UIParent = CreateFrame('Frame', "TruthUIParent", UIParent)								-- Everything in Truth UI should be anchored here
G.UIParent:SetFrameLevel(UIParent:GetFrameLevel())
G.UIParent:SetPoint('CENTER', UIParent, 'CENTER')
G.UIParent:SetSize(UIParent:GetSize())													-- G["snapBars"][#G["snapBars"] + 1] = G.UIParent

G.HiddenFrame = CreateFrame('Frame')
G.HiddenFrame:Hide()




--------------------------------------------------
--	Bindings.xml
--------------------------------------------------
-- <Bindings>

--[[		<!-- Debug -->

		<Binding name="DUMP_FRAME_AT_CURSOR" header="TRUTH">
			Truth:DebugFrameAtCursor()
		</Binding>

		<Binding name="LIST_TEXTURES"> Truth:ListTextures() </Binding>
		<Binding name="LIST_CHILDREN"> Truth:ListChildren() </Binding>


		<!-- CopyText -->

		<Binding name="MOUSEOVER_FRAME"> CopyThat:ScrapeMouseoverFrame() </Binding>
		<Binding name="TOOLTIP_FRAME">   CopyThat:ScrapeGameTooltip()    </Binding>
--]]

-- </Bindings>


--------------------------------------------------
--	 Bindings
--------------------------------------------------
BINDING_HEADER_TRUTH			= "|cff82C5FFTruth|r"

BINDING_HEADER_TRUTH_DEBUG		= "|cff82C5FFTruth|r  Debug Lists to Chat"

BINDING_NAME_TRUTH_DUMP			= "Dump"
BINDING_NAME_TRUTH_LISTTEXTURES	= "Textures"
BINDING_NAME_TRUTH_LISTCHILDREN	= "Children"


BINDING_HEADER_TRUTH_COPYTEXT		= "|cff82C5FFTruth|r  Frame Text to Memory (copy/paste)"

BINDING_NAME_TRUTH_MOUSEOVERTEXT	= "Mouseover Frame"
BINDING_NAME_TRUTH_TOOLTIPTEXT	= "Tooltip Text"



--[[ _Dev Bindings

	BINDING_HEADER__DEV				= "_|cffcccc88Dev|r"
	BINDING_NAME__DEV_RELOADUI		= "Reload UI"
	BINDING_NAME__DEV_OPENCHATSCRIPT	= "Open Script"
	BINDING_NAME__DEV_FRAMESTOGGLE 	= "Toggle Frames Browsing"
]]



--------------------------------------------------
--	Engine
--------------------------------------------------
--[[ Revert Code (stable)

	local ADDON_NAME, TruthUI = ...				-- local TruthUI = select(2, ...)
	_G[ADDON_NAME] = TruthUI

	TruthUI[1] = {}	-- A
	TruthUI[2] = {}	-- C
	TruthUI[3] = {}	-- G
	TruthUI[4] = {}	-- L

	function TruthUI:Unpack()
		return self[1], self[2], self[3], self[4]
	end
--]]

--------------------------------------------------
--	Bindings
--------------------------------------------------
--[[ Original

	local format, upper = string.format, string.upper
	local ADDON_NAME = AddonName:upper()

--	Binding Header: TRUTH
	_G[("BINDING_HEADER_%s"):format(ADDON_NAME)] = ADDON_NAME

--	Binding Name: Format String
	local BINDING_FORMAT = ("BINDING_NAME_%s_"):format(ADDON_NAME_UPPERCASE) .. "%s"				-- local BINDING_FORMAT = "BINDING_NAME_TRUTH_%s"

--	Binding Name: Values
	_G[BINDING_FORMAT:format("DUMP")] 				= "Dump"
	_G[BINDING_FORMAT:format("DEBUG_TEXTURES")]		= "Textures"
	_G[BINDING_FORMAT:format("DEBUG_CHILDREN")]		= "Children"
	_G[BINDING_FORMAT:format("COPYTEXT_MOUSEOVER")]	= "Mouseover"
	_G[BINDING_FORMAT:format("COPYTEXT_TOOLTIP")]	= "Tooltip"
--]]

--[[ EZ Binds

	BINDING_NAME_TRUTH_DEBUG_MOUSEFOCUS 			= "Debug Mousefocus"
	BINDING_NAME_TRUTH_DEBUG_TEXTURES 			= "List Textures"
	BINDING_NAME_TRUTH_DEBUG_CHILDREN 			= "List Children"
	BINDING_NAME_TRUTH_COPYTEXT_MOUSEOVER 		= "Copy Text - Mouseover"
	BINDING_NAME_TRUTH_COPYTEXT_TOOLTIP 			= "Copy Text - Tooltip"
--]]

--------------------------------------------------
--	Page Headers
--------------------------------------------------
--[[ local AddOn, Addon = ...
	local C, API = unpack(Addon)
	if (not C["Skin"]["Enable"]) then return end
	local print = function(...) Addon.print('filename', ...) end
--]]

--------------------------------------------------
--	Asphyxia\Handler\Engine.lua
--------------------------------------------------
--[[	local AddOn, Engine = ...

	Engine[1] = {} -- A, Functions
	Engine[2] = {} -- C, Configuration
	Engine[3] = {} -- L, localization
	Engine[4] = {} -- U, UnitFrames
	Engine[5] = {} -- M, Modules
	Engine[6] = {} -- P, PlugIns

	function Engine:Unpack()
		return self[1], self[2], self[3], self[4], self[5], self[6]
	end

	_G.AsphyxiaUI = Engine
--]]

--------------------------------------------------
--	Database
--------------------------------------------------
--[[	DB Defaults

	local db

	local Defaults = {
		Time = {
			['Login'] = date(),
			['Logout'] = time(),
		},
		Reputation = {
			['EventCounter'] = 0,
			['EventTimestamp'] = date('*t'),
			['EventAnnouncements'] = true,
		},
	}
--]]

--------------------------------------------------
--	DB
--------------------------------------------------
--[[ Database

	source: 	 Wowpedia Tutorial
	title:	'Saving variables between game sessions'
	link:	 http://wowpedia.org/Saving_variables_between_game_sessions
--]]

--[[ Database Init

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:RegisterEvent('PLAYER_LOGOUT')
	f:SetScript('OnEvent', function(self, event, database)
		if (event == 'ADDON_LOADED') then self:UnregisterEvent('ADDON_LOADED') -- self.ADDON_LOADED = nil
			if (TruthDB == nil) then
				TruthDB = {
					Time = {
						['Login'] = time(),
						['Logout'] = '',
					},
					Reputation = {
						['EVENT_COUNTER'] = 0,
						['EVENT_TIMESTAMP'] = '',
						['EVENT_ANNOUNCEMENTS'] = true,
					},
				}
			else
				TruthDB.Time.LOGIN = time()
			end
		elseif (event == 'PLAYER_LOGOUT') then
			TruthDB.Time.LOGOUT = time()								-- Final save occurs when the character logs out
		end
	end)
--]]

--------------------------------------------------
--	Macros
--------------------------------------------------
--[[ Framestack (adds border to frame)

	/framestack
	/script MN=GetMouseFocus():GetName()DEFAULT_CHAT_FRAME:AddMessage(MN)
	/run MF=_G[MN] MFB=CreateFrame('Frame',nil,MF )MFB:SetAllPoints()MFB:SetBackdrop({edgeFile='Interface\\BUTTONS\\WHITE8X8',edgeSize=5})MFB:SetBackdropBorderColor(1,0,0,1)
 --]]

--------------------------------------------------
--	Resources
--------------------------------------------------
--[[ MSBT (by Mikk) Addon Variables

	DEFAULT_PROFILE_NAME 		= 'Default'	-- Profile Constant

	SAVED_MEDIA_NAME			= 'TruthDBM'	-- MediaStorage

	SAVED_VARS_NAME			= 'TruthDB'	-- SavedVariables (TOC Global)
	SAVED_VARS_PER_CHAR_NAME		= 'TruthDBPC'	-- SavedVariablesPerCharacter (TOC Global)
--]]

--[[	Important

	●	WoW Constants
		http://www.wowwiki.com/Talk:WoW_constants
		Regex Instructions for parsing GlobalStrings.lua
     ●

--]]
--------------------------------------------------

