local A, C, G, L = select(2, ...):Unpack()
local ADDON_NAME = select(1, ...)
local print = print
local format = string.format





--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Addon  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
A.ADDON_NAME			= ADDON_NAME
A.ADDON_TITLE			= GetAddOnMetadata(ADDON_NAME, "Title")
A.ADDON_VERSION		= GetAddOnMetadata(ADDON_NAME, "Version")
A.ADDON_NOTES			= GetAddOnMetadata(ADDON_NAME, "Notes")
A.ADDON_AUTHOR			= GetAddOnMetadata(ADDON_NAME, "Author")
G.ADDON_HEADER			= ("|cff99CC99%s|r"):format(ADDON_NAME)


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Player  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
A.PLAYER_NAME			= UnitName("player")			--> "Truthmachine"
A.PLAYER_FACTION		= UnitFactionGroup("player")       --> "Horde"
A.PLAYER_LEVEL			= UnitLevel("player")              -->  90
A.PLAYER_REALM			= GetRealmName()                   --> "Mal'Ganis"
A.PLAYER_RACE			= select(2, UnitRace("player"))	--> "Orc", "Orc"  = UnitRace("unit")
A.PLAYER_CLASS			= select(2, UnitClass("player"))	--> "Rogue", "ROGUE" = UnitClass("player")


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Color  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
local CUSTOM_CLASS_COLORS = {
	["WARRIOR"]		= {r = 0.78 * 0.85, g = 0.61 * 0.85, b = 0.43 * 0.85, colorStr = 'ffC79C6E'},
	["DEATHKNIGHT"]	= {r = 0.77 * 0.85, g = 0.12 * 0.85, b = 0.23 * 0.85, colorStr = 'ffC41F3B'},
	["PALADIN"]		= {r = 0.96 * 0.85, g = 0.55 * 0.85, b = 0.73 * 0.85, colorStr = 'ffF58CBA'},
	["MONK"]			= {r = 0.00 * 0.85, g = 0.78 * 0.85, b = 0.48 * 0.85, colorStr = 'ff00FF96'},
	["PRIEST"]		= {r = 0.90 * 0.85, g = 0.90 * 0.85, b = 0.90 * 0.85, colorStr = 'ffFFFFFF'},
	["SHAMAN"]		= {r = 0.00 * 0.85, g = 0.44 * 0.85, b = 0.87 * 0.85, colorStr = 'ff0070DE'},
	["DRUID"]			= {r = 1.00 * 0.85, g = 0.49 * 0.85, b = 0.04 * 0.85, colorStr = 'ffFF7D0A'},
	["ROGUE"]			= {r = 1.00 * 0.85, g = 0.96 * 0.85, b = 0.41 * 0.85, colorStr = 'ffFFF569'},
	["MAGE"]			= {r = 0.41 * 0.85, g = 0.80 * 0.85, b = 0.94 * 0.85, colorStr = 'ff69CCF0'},
	["WARLOCK"]		= {r = 0.58 * 0.85, g = 0.51 * 0.85, b = 0.79 * 0.85, colorStr = 'ff9482C9'},
	["HUNTER"]		= {r = 0.67 * 0.85, g = 0.83 * 0.85, b = 0.45 * 0.85, colorStr = 'ffABD473'},
	["UNKNOWN"]		= {r = 0.50,        g = 0.50,        b = 0.50,        colorStr = 'ff808080'},
}

A.CLASS_COLORS = CUSTOM_CLASS_COLORS or _G.RAID_CLASS_COLORS
A.PLAYER_COLOR = A.CLASS_COLORS[ A.PLAYER_CLASS ]
A.PLAYER_COLOR_CFF = ("|c%s"):format( A.PLAYER_COLOR.colorStr )


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Globals  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
G.SCALE			= 1
--
G.MARGIN			= 10
G.PAD			= 5
--
G.BUTTON_WIDTH		= 80 					--150
G.BUTTON_HEIGHT	= 22
G.CHECKBUTTON_SIZE	= 20						--16
--
G.NUM_CHAT_FRAMES	= 4
--
G.FONT_FILE = [=[Interface\AddOns\Truth\media\font\myriad.ttf]=]
G.FONT_SIZE = 10
G.FONT_FLAG = "OUTLINE"
G.FONT_FLAGS = {
	[0] = "",
	[1] = "OUTLINE",						-- Font is displayed with a black outline
	[2] = "THICKOUTLINE",					-- Font is displayed with a thick black outline
	[3] = "MONOCHROME",						-- Font is rendered without antialiasing
	[4] = "MONOCHROME, OUTLINE",
	[5] = "MONOCHROME, THICKOUTLINE",
}
--
G.PANEL_MARGIN_TOP = 28
G.PANEL_MARGIN_BOTTOM = 50
--
G.SCROLLBAR_WIDTH = 28
G.SCROLLBAR_BUTTON_SIZE = 16
G.SCROLLBAR_THUMB_TEXTURE = [=[Interface\Buttons\UI-ScrollBar-Knob]=]



--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Frames  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
G['UIParent'] = UIParent
G['GameTooltip'] = GameTooltip
G['ItemRefTooltip'] = ItemRefTooltip
G['GameTooltipStatusBar'] = GameTooltipStatusBar

-- Hider
G['HiddenFrame'] = CreateFrame('Frame', "TruthHider", UIParent)
G['HiddenFrame']:Hide()

-- Font
G['Font'] = CreateFont("TruthFont")


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Events  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
local mod = CreateFrame('Frame')
mod:RegisterEvent('ADDON_LOADED')
mod:SetScript('OnEvent', function(self, event, ...)
	self[event](self, ...)
end)

function mod:ADDON_LOADED(arg1)
	if (arg1 ~= ADDON_NAME) then
		return
	end
	self:SetScript('OnEvent', nil)			-- Release
	self:UnregisterAllEvents()
	self = nil
end


----------------------------------------------------------------------------------------------------
--	UI Mappers
----------------------------------------------------------------------------------------------------
--[[ UI.xsd

	local UI = {
		["FRAMEPOINT"] = {					-- FRAMEPOINT
			[1] = "TOPLEFT",
			[2] = "TOPRIGHT",
			[3] = "BOTTOMLEFT",
			[4] = "BOTTOMRIGHT",
			[5] = "TOP",
			[6] = "BOTTOM",
			[7] = "LEFT",
			[8] = "RIGHT",
			[9] = "CENTER",
		},
		["FRAMESTRATA"] = {					-- FRAMESTRATA:   Valid values for frames
			[1] = "PARENT",
			[2] = "BACKGROUND",				-- Used by default for static UI elements such as the PlayerFrame and Minimap
			[3] = "LOW",					-- Used by default for lower-priority UI elements such as the party member and target frames
			[4] = "MEDIUM",				-- Default strata (for general usage)
			[5] = "HIGH",					-- Used by default for higher priority UI elements such as the Calendar and Loot frames
			[6] = "DIALOG",				-- Used by default for alerts and other dialog boxes which should appear over nearly all other UI elements
			[7] = "FULLSCREEN",				-- Used by default for fullscreen windows such as the World Map
			[8] = "FULLSCREEN_DIALOG",		-- Used by default for alerts or dialog boxes which should appear even when a fullscreen window is visible
			[9] = "TOOLTIP",				-- Used for mouse cursor tooltips, ensuring they appear over all other UI elements
		},
		["DRAWLAYER"] = {					-- DRAWLAYER:     Regions of graphics are drawn relative to those of other regions in the same frame
			[1] = "BACKGROUND",				-- Layer 1.  Background ( lowest layer )
			[2] = "BORDER",				-- Layer 2.  Artwork
			[3] = "ARTWORK",				-- Layer 3.  Artwork ** [DEFAULT] When layer is not specified
			[4] = "OVERLAY",				-- Layer 4.  Text, Objects & Buttons
			[5] = "HIGHLIGHT",				-- Layer 5.  Text, Objects & Buttons - Regions on this layer are auto-shown when mousing-over the containing frame
		},
		["ALPHAMODE"] = {					-- ALPHAMODE:     Valid font outlines
			[1] = "DISABLE",
			[2] = "BLEND",
			[3] = "ALPHAKEY",
			[4] = "ADD",
			[5] = "MOD",
		},
		["OUTLINETYPE"] = {					-- OUTLINETYPE
			[1] = "NONE",
			[2] = "NORMAL",
			[3] = "THICK",
		},
		["JUSTIFYVTYPE"] = {				-- JUSTIFYVTYPE
			[1] = "TOP",
			[2] = "MIDDLE",
			[3] = "BOTTOM",
		},
		["JUSTIFYHTYPE"] = {				-- JUSTIFYHTYPE
			[1] = "LEFT",
			[2] = "CENTER",
			[3] = "RIGHT",
		},
		["INSERTMODE"] = {					-- INSERTMODE
			[1] = "TOP",
			[2] = "BOTTOM",
		},
		["ORIENTATION"] = {					-- ORIENTATION
			[1] = "HORIZONTAL",
			[2] = "VERTICAL",
		}
		["ATTRIBUTETYPE"] = {				-- ATTRIBUTETYPE
			[1] = "nil",
			[2] = "boolean",
			[3] = "number",
			[3] = "string",
		},
	}


	UI["Font"] = {
		["Parameters"] = {
			["FontHeight"] = "Value",
			["Color"] = "ColorType",
			["Shadow"] = "ShadowType",
		},
		["name"] = "string",
		["inherits"] = "string",
		["virtual"] = "boolean",					-- default = "false"
		["font"] = "string",
		["spacing"] = "float",                       -- default = "0"
		["outline"] = "OUTLINETYPE",                 -- default = "NONE"
		["monochrome"] = "monochrome",               -- default = "false"
		["justifyV"] = "JUSTIFYVTYPE",               -- default = "MIDDLE"
		["justifyH"] = "JUSTIFYHTYPE",			-- default = "CENTER"
	}

	UI["LayoutFrame"] = {
		["Parameters"] = {
			["Size"] = "Dimension",
			["Anchors"] = {
				["Anchor"] = {
					["Offset"] = "Dimension",
					["Shadow"] = "ShadowType",
					["Shadow"] = "ShadowType",
					["Shadow"] = "ShadowType",
					["Shadow"] = "ShadowType",
				},
			},
		},
		["name"] = "string",
		["inherits"] = "string",
		["virtual"] = "boolean",					-- default = "false"
		["font"] = "string",
		["spacing"] = "float",                       -- default = "0"
	}
--]]

----------------------------------------------------------------------------------------------------
--	Pathing
----------------------------------------------------------------------------------------------------
--[[ Primary Values

	A.ADDON_PATH		= ("Interface\\AddOns\\%s\\"):format(ADDON_NAME)	-- "Interface\\AddOns\\Truth\\"
	A.MEDIA_PATH		= ("%smedia\\"):format(A.ADDON_PATH)			-- "Interface\\AddOns\\Truth\\media\\"
	A.BACKGROUND_PATH	= ("%sbackground\\"):format(A.MEDIA_PATH)		-- "Interface\\AddOns\\Truth\\media\\background\\"
	A.BORDER_PATH		= ("%sborder\\"):format(A.MEDIA_PATH)			-- "Interface\\AddOns\\Truth\\media\\border\\"
	A.FONT_PATH		= ("%sfont\\"):format(A.MEDIA_PATH)			-- "Interface\\AddOns\\Truth\\media\\font\\"
	A.STATUSBAR_PATH	= ("%sstatusbar\\"):format(A.MEDIA_PATH)		-- "Interface\\AddOns\\Truth\\media\\statusbar\\"
	A.SOUND_PATH		= ("%ssound\\"):format(A.MEDIA_PATH)			-- "Interface\\AddOns\\Truth\\media\\sound\\"
--]]

--[[ Previous Versions

	A["PATH"]			= "Interface\\AddOns\\" .. ADDON_NAME .. "\\"
	A["MEDIAS"]		= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\"
	A["BACKGROUNDS"]	= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\background\\"
	A["BORDERS"]		= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\border\\"
	A["FONTS"]		= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\font\\"
	A["STATUSBARS"]	= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\statusbar\\"
	A["SOUNDS"]		= "Interface\\AddOns\\" .. ADDON_NAME .. "\\media\\sound\\"

	A.ADDON_PATH		= "Interface\\AddOns\\Truth\\"
	A.MEDIA_PATH		= "Interface\\AddOns\\Truth\\media\\"
	A.BACKGROUNDS		= "Interface\\AddOns\\Truth\\media\\background\\"
	A.BORDERS			= "Interface\\AddOns\\Truth\\media\\border\\"
	A.FONTS			= "Interface\\AddOns\\Truth\\media\\font\\"
	A.STATUSBARS		= "Interface\\AddOns\\Truth\\media\\statusbar\\"
	A.SOUNDS			= "Interface\\AddOns\\Truth\\media\\sound\\"
--]]

----------------------------------------------------------------------------------------------------
--	!ClassColors color table from SavedVariables
----------------------------------------------------------------------------------------------------
--[[ local ClassColorsDB = {
		["DEATHKNIGHT"]	= {r = 0.77, g = 0.12, b = 0.23, colorStr = "ffC41E3A"},
		["WARRIOR"]		= {r = 0.78, g = 0.61, b = 0.43, colorStr = "ffC69B6D"},
		["PALADIN"]		= {r = 0.96, g = 0.55, b = 0.73, colorStr = "ffF48CBA"},
		["MAGE"]			= {r = 0.41, g = 0.80, b = 0.94, colorStr = "ff68CCEF"},
		["PRIEST"]		= {r = 1.00, g = 1.00, b = 1.00, colorStr = "ffFFFFFF"},
		["WARLOCK"]		= {r = 0.58, g = 0.51, b = 0.79, colorStr = "ff9382C9"},
		["SHAMAN"]		= {r = 0.00, g = 0.44, b = 0.87, colorStr = "ff0070DD"},
		["HUNTER"]		= {r = 0.67, g = 0.83, b = 0.45, colorStr = "ffAAD372"},
		["DRUID"]			= {r = 1.00, g = 0.49, b = 0.04, colorStr = "ffFF7C0A"},
		["MONK"]			= {r = 0.00, g = 1.00, b = 0.59, colorStr = "ff00FF96"},
		["ROGUE"]			= {r = 1.00, g = 0.96, b = 0.41, colorStr = "ffFFF468"},
	}
--]]

--------------------------------------------------
--	Blocks
--------------------------------------------------
--[[	Technical Bits

	FolderLocation = _G.debugstack():match("ns\\(.-)\\")	=> "Truth"

	Is64BitClient()	=> 1

--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ TexCoords

	G.TexCoords = {
		[1] = 0.08,
		[2] = 0.92,
		[3] = 0.08,
		[4] = 0.92,
	}
--]]

--[[ A["NAME"]		= ADDON_NAME
	A["TITLE"]	= GetAddOnMetadata(ADDON_NAME, "Title")
	A["VERSION"]	= GetAddOnMetadata(ADDON_NAME, "Version")
	A["NOTES"]	= GetAddOnMetadata(ADDON_NAME, "Notes")
	A["AUTHOR"]	= GetAddOnMetadata(ADDON_NAME, "Author")
--]]

--[[	A["PlayerName"]	= UnitName("player")										-- "Truthmachine"
	A["PlayerClass"]	= select(2, UnitClass("player"))								-- "ROGUE"
	A["PlayerFaction"]	= UnitFactionGroup("player")									-- "Horde"
	A["PlayerLevel"]	= UnitLevel("player")										--  90
	A["PlayerRace"]	= select(2, UnitRace("player"))								-- "Orc"
	A["PlayerRealm"]	= GetRealmName()											-- "Mal'Ganis"
	A["PlayerServer"]	= format("%s %s", A["PlayerRealm"], A["PlayerFaction"])			-- "Mal'Ganis Horde"
	A["PlayerColor"]	= (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("player"))]
--]]


