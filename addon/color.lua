local A, C, G, L = select(2, ...):Unpack()
local CLASS_COLORS = A.CLASS_COLORS			-- A.lua

local format, upper = string.format, string.upper
local unpack, select = unpack, select
local UnitClass = UnitClass
-- local COMBATLOG_HIGHLIGHT_MULTIPLIER = 1.5




do
	local GameTooltip_UnitColor = GameTooltip_UnitColor
	local UnitIsDeadOrGhost = UnitIsDeadOrGhost
	local UnitIsConnected = UnitIsConnected
	local UnitIsPlayer = UnitIsPlayer
	local UnitPlayerControlled = UnitPlayerControlled
	local UnitIsPVP = UnitIsPVP
	local UnitInParty = UnitInParty
	local UnitIsVisible = UnitIsVisible
	local UnitIsTapped = UnitIsTapped
	local UnitIsTappedByPlayer = UnitIsTappedByPlayer
	local UnitIsTappedByAllThreatList = UnitIsTappedByAllThreatList

	A.GetUnitColor = function(unit)
		local r, g, b = GameTooltip_UnitColor(unit)
		local color = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)

		if (UnitIsDeadOrGhost(unit) or (not UnitIsConnected(unit))) then
			color = "|cff888888"

		elseif (UnitIsPlayer(unit) or UnitPlayerControlled(unit)) then
			if (not UnitIsPVP(unit) or (UnitInParty(unit) and not UnitIsVisible(unit))) then
				color = "|cff0099FF"
			end

		elseif (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
			if (not UnitIsTappedByAllThreatList(unit)) then
				color = "|cff77AAAA"
			end
		end

		return color
	end

	local len = string.len
	local sub = string.sub
	local tonumber = tonumber
	local GetQuestDifficultyColor = GetQuestDifficultyColor

	A.GetClassColor = function(unit)
		local name, class = UnitClass(unit)
		local color = CLASS_COLORS[class]

		color = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)

		return color, name
	end

	A.GetLevelColor = function(level)				-- Tooltip Utility
		local color
		if (level == "??") then
			color = "|cffFF3333"
		else
			color = GetQuestDifficultyColor(level)
			color = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
		end

		return color
	end

	A.ColorTooltip = function(tooltip, color)
		local r, g, b = 1, 1, 1
		local border = 1

		if (color and (len(color) == 10)) then
			r = tonumber(sub(color, 5, 6), 16) / 255
			g = tonumber(sub(color, 7, 8), 16) / 255
			b = tonumber(sub(color, 9), 16 ) / 255
		end

		tooltip:SetBackdropBorderColor(r * 0.9, g * 0.9, b * 0.9, border)
		tooltip:SetBackdropColor(r * 0.1, g * 0.1, b * 0.1)
	end
end

--[==[
----------------------------------------------------------------------------------------------------
A.GRAY_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_POOR]
A.WHITE_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_COMMON] 		--[[ 1 - White  ]]
A.BLACK_COLOR	= {r=0.1, g=0.1, b=0.1}
A.RED_COLOR	= QuestDifficultyColors["impossible"]
A.GREEN_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_UNCOMMON] 	--[[ 2 - Green  ]]
A.BLUE_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_RARE]		--[[ 3 - Blue  ]]
A.ORANGE_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_LEGENDARY]	--[[ 5 - Orange ]]
A.YELLOW_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_LEGENDARY]	--[[ 7 - Light Yellow ]]
A.PURPLE_COLOR	= ITEM_QUALITY_COLORS[ITEM_QUALITY_EPIC] 		--[[ 4 - Purple ]]
----------------------------------------------------------------------------------------------------
A.FRIENDS_PRESENCE_COLOR_CODE			= "|cff7C848A"	-- Dark grayish blue					--@ FriendsFrame
A.FRIENDS_BNET_NAME_COLOR_CODE		= "|cff82C5FF"	-- Very light blue (BNET FONT COLOR)
A.FRIENDS_BROADCAST_TIME_COLOR_CODE	= "|cff4381A8"	-- Dark moderate blue
A.FRIENDS_WOW_NAME_COLOR_CODE			= "|cffFDE05C"	-- Soft yellow
A.FRIENDS_OTHER_NAME_COLOR_CODE		= "|cff7B8489"	-- Dark grayish blue
----------------------------------------------------------------------------------------------------
A.BNET_NAME_COLOR	= FRIENDS_BNET_NAME_COLOR		--[[ Lite Blue	{r=.5,g=.8,b=1}		(#80CCFF) (128, 204, 255) ]]
A.BNET_BG_COLOR	= FRIENDS_BNET_BACKGROUND_COLOR	--[[ Cyan		{r=0,g=.7,b=.9,a=.05}	(#00B3E6) (0, 179, 230)   ]]
A.WOW_NAME_COLOR	= FRIENDS_WOW_NAME_COLOR			--[[ Yellow	{r=1,g=.9,b=.4}		(#FFE000) (255, 224, 0)   ]]
A.WOW_BG_COLOR		= FRIENDS_WOW_BACKGROUND_COLOR	--[[ Tangerine	{r=1,g=.8,b=0,a=.05}	(#FFCC00) (255, 204, 0)   ]]
A.OFFLINE_COLOR	= FRIENDS_GRAY_COLOR			--[[ Dark Gray	{r=.5,g=.5,b=.5}		(#808080) (128, 128, 128) ]]
A.OFFLINE_BG_COLOR	= FRIENDS_OFFLINE_BACKGROUND_COLOR	--[[ Dark Gray	{r=.6,g=.6,b=.6, a=.05}	(#999999) (153, 153, 153) ]]
----------------------------------------------------------------------------------------------------
A.RED_CFF_FORMAT		= "|cffCC3333%s|r"		-- DK
A.LITE_RED_CFF_FORMAT	= "|cffC74C50%s|r"
A.PAIL_RED_CFF_FORMAT	= "|cffCC9999%s|r"
A.GREEN_CFF_FORMAT		= "|cff33CC33%s|r"		-- QuestDifficultyColors["standard"]
A.LITE_GREEN_CFF_FORMAT	= "|cff77BB77 %s|r"
A.PAIL_GREEN_CFF_FORMAT	= "|cff99CC99%s|r"
A.BLUE_CFF_FORMAT		= "|cff3399FF%s|r"		-- "|cff3333CC%s|r" -- Harsh Blue
A.LITE_BLUE_CFF_FORMAT	= "|cff82C5FF%s|r"		-- Bnet
A.PAIL_BLUE_CFF_FORMAT	= "|cffA9C7D5%s|r"
A.BLACK_CFF_FORMAT		= "|cff000000%s|r"		-- Dark
A.GRAY_CFF_FORMAT		= "|cff999999%s|r"
A.WHITE_CFF_FORMAT		= "|cffFFFFFF%s|r"		-- Light
A.LITE_GRAY_CFF_FORMAT	= "|cffCCCCCC%s|r"
--]==]


--[[ CLASS ]----------------------------------------------------------------------------------------

	RAID_CLASS_COLORS = {															--@ Constants.lua
		['WARRIOR']		= {r = 0.78, g = 0.61, b = 0.43, colorStr = 'ffC79C6E'},
		['DEATHKNIGHT']	= {r = 0.77, g = 0.12, b = 0.23, colorStr = 'ffC41F3B'},
		['PALADIN']		= {r = 0.96, g = 0.55, b = 0.73, colorStr = 'ffF58CBA'},
		['MONK']			= {r = 0.00, g = 1.00, b = 0.59, colorStr = 'ff00FF96'},
		['PRIEST']		= {r = 1.00, g = 1.00, b = 1.00, colorStr = 'ffFFFFFF'},
		['SHAMAN']		= {r = 0.00, g = 0.44, b = 0.87, colorStr = 'ff0070DE'},
		['DRUID']			= {r = 1.00, g = 0.49, b = 0.04, colorStr = 'ffFF7D0A'},
		['ROGUE']			= {r = 1.00, g = 0.96, b = 0.41, colorStr = 'ffFFF569'},
		['MAGE']			= {r = 0.41, g = 0.80, b = 0.94, colorStr = 'ff69CCF0'},
		['WARLOCK']		= {r = 0.58, g = 0.51, b = 0.79, colorStr = 'ff9482C9'},
		['HUNTER']		= {r = 0.67, g = 0.83, b = 0.45, colorStr = 'ffABD473'},
	}
	class = {
		['WARRIOR']		= {199/255, 156/255, 110/255, hex = '|cffC79C6E'},
		['DEATHKNIGHT']	= {196/255, 030/255, 060/255, hex = '|cffC41F3B'},
		['PALADIN']		= {245/255, 140/255, 186/255, hex = '|cffF58CBA'},
		['MONK']			= {000/255, 255/255, 150/255, hex = '|cff00FF96'},
		['PRIEST']		= {212/255, 212/255, 212/255, hex = '|cffFFFFFF'},
		['SHAMAN']		= {041/255, 079/255, 155/255, hex = '|cff0070DE'},
		['DRUID']			= {255/255, 125/255, 010/255, hex = '|cffFF7D0A'},
		['ROGUE']			= {255/255, 243/255, 082/255, hex = '|cffFFF569'},
		['MAGE']			= {104/255, 205/255, 255/255, hex = '|cff69CCF0'},
		['WARLOCK']		= {148/255, 130/255, 201/255, hex = '|cff9482C9'},
		['HUNTER']		= {171/255, 214/255, 116/255, hex = '|cffABD473'},
	}
	local X = 0.85
	C.RAID_CLASS_COLORS = setmetatable({												--@ GUIS-gUI/core/colors.lua
		["WARRIOR"] 		= {r = 0.78 * X, g = 0.61 * X, b = 0.43 * X, colorStr = 'ffC79C6E'},
		["DEATHKNIGHT"]	= {r = 0.77 * X, g = 0.12 * X, b = 0.23 * X, colorStr = 'ffC41F3B'},
		["PALADIN"] 		= {r = 0.96 * X, g = 0.55 * X, b = 0.73 * X, colorStr = 'ffF58CBA'},
		["MONK"] 			= {r = 0.00 * X, g = 0.78 * X, b = 0.48 * X, colorStr = 'ff00FF96'},
		["PRIEST"] 		= {r = 0.90 * X, g = 0.90 * X, b = 0.90 * X, colorStr = 'ffFFFFFF'},
		["SHAMAN"] 		= {r = 0.00 * X, g = 0.44 * X, b = 0.87 * X, colorStr = 'ff0070DE'},
		["DRUID"]			= {r = 1.00 * X, g = 0.49 * X, b = 0.04 * X, colorStr = 'ffFF7D0A'},
		["ROGUE"] 		= {r = 1.00 * X, g = 0.96 * X, b = 0.41 * X, colorStr = 'ffFFF569'},
		["MAGE"] 			= {r = 0.41 * X, g = 0.80 * X, b = 0.94 * X, colorStr = 'ff69CCF0'},
		["WARLOCK"] 		= {r = 0.58 * X, g = 0.51 * X, b = 0.79 * X, colorStr = 'ff9482C9'},
		["HUNTER"]		= {r = 0.67 * X, g = 0.83 * X, b = 0.45 * X, colorStr = 'ffABD473'},
		["UNKNOWN"] 		= {r = 0.60 * X, g = 0.60 * X, b = 0.60 * X},
	}, { __index = RAID_CLASS_COLORS })

--]]

--[[ FACTION ]----------------------------------------------------------------------------------------

	factionLogoTextures = {															--@ InspectPaperDollFrame.lua
		["Alliance"]	= "Interface\\Timer\\Alliance-Logo",
		["Horde"]		= "Interface\\Timer\\Horde-Logo",
		["Neutral"]	= "Interface\\Timer\\Panda-Logo",
	}
	PLAYER_FACTION_GROUP = {
		[0] = "Horde",
		[1] = "Alliance"
	}
	PLAYER_FACTION_COLORS = {
		[0] = {r = 0.90, g = 0.05, b = 0.07},
		[1] = {r = 0.29, g = 0.33, b = 0.91},
	}

	FACTION_STANDING_LABEL1 = "Hated"
	FACTION_STANDING_LABEL2 = "Hostile"
	FACTION_STANDING_LABEL3 = "Unfriendly"
	FACTION_STANDING_LABEL4 = "Neutral"
	FACTION_STANDING_LABEL5 = "Friendly"
	FACTION_STANDING_LABEL6 = "Honored"
	FACTION_STANDING_LABEL7 = "Revered"
	FACTION_STANDING_LABEL8 = "Exalted"

	FACTION_BAR_COLORS = {											--@ ReputationFrame.lua
		[1] = {r = 0.80, g = 0.30, b = 0.22},	-- [Red]		Hated
		[2] = {r = 0.80, g = 0.30, b = 0.22},	-- [Red]		Hostile players are red
		[3] = {r = 0.75, g = 0.27, b = 0.00},	-- [Red]		Unfriendly
		[4] = {r = 0.90, g = 0.70, b = 0.00},	-- [Yellow]	Players we can attack but which are not hostile are yellow
		[5] = {r = 0.00, g = 0.60, b = 0.10},	-- [Green]	Always color friendships green
		[6] = {r = 0.00, g = 0.60, b = 0.10},	-- [Green]	Players we can assist but are PvP flagged are green
		[7] = {r = 0.00, g = 0.60, b = 0.10},	-- [Green]
		[8] = {r = 0.00, g = 0.60, b = 0.10},	-- [Green]
	}
	ReactionColors = {												--@ TipTac
		[1] = {222/255, 095/255, 095/255},		-- hated		[R]
		[2] = {222/255, 095/255, 095/255},		-- hostile	[R]
		[3] = {222/255, 095/255, 095/255},		-- unfriendly	[R]
		[4] = {218/255, 197/255, 092/255},		-- neutral	[Y]
		[5] = {075/255, 175/255, 075/255},		-- friendly	[G]  (#)
		[6] = {075/255, 175/255, 075/255},		-- honored	[G]
		[7] = {075/255, 175/255, 075/255},		-- revered	[G]
		[8] = {075/255, 175/255, 075/255},		-- exalted	[G]
	}
	ReactionBackdropColors = {
		[1] = {0.20, 0.20, 0.20},
		[2] = {0.30, 0.00, 0.00},
		[3] = {0.30, 0.15, 0.00},
		[4] = {0.30, 0.30, 0.00},
		[5] = {0.00, 0.30, 0.10},
		[6] = {0.00, 0.00, 0.50},
		[7] = {0.05, 0.05, 0.05},
	}
--]]

--[[ DIFFICULTY ]----------------------------------------------------------------------------------------

	QuestDifficultyColors = {
		["impossible"] 	= {r = 1,    g = 0.1,  b = 0.1},  -- Red	(#FF1A1A) (255/255,  26/255,  26/255)
		["verydifficult"]	= {r = 1,    g = 0.5,  b = 0.25}, -- Orange	(#FF8040) (255/255, 128/255,  64/255)
		["difficult"] 		= {r = 1,    g = 1,    b = 0},    -- Yellow	(#FFFF00) (255/255, 255/255,   0/255)
		["standard"]		= {r = 0.25, g = 0.75, b = 0.25}, -- Green	(#40BF40) (64/255,  191/255,  64/255)
		["trivial"]		= {r = 0.5,  g = 0.5,  b = 0.5},  -- Dk Gray	(#808080) (128/255, 128/255, 128/255)
		["header"]		= {r = 0.7,  g = 0.7,  b = 0.7},  -- Gray	(#B3B3B3) (179/255, 179/255, 179/255)
	}
--]]

--[[ POWER ]----------------------------------------------------------------------------------------

	PowerColors = {
		["MANA"]			= {r = 0,   g = 0,   b = 1   },
		["RAGE"]			= {r = 1,   g = 0,   b = 0   },
		["FOCUS"]			= {r = 1,   g = 0.5, b = 0.25},
		["ENERGY"]		= {r = 1,   g = 1,   b = 0   },
		["CHI"]			= {r = 0.7, g = 1,   b = 0.9 },
		["RUNES"]			= {r = 0.5, g = 0.5, b = 0.5 },
		["RUNIC_POWER"]	= {r = 0,   g = 0.8, b = 1   },
		["SOUL_SHARDS"]	= {r = 0.5, g = 0.3, b = 0.55},
		["ECLIPSE"] = {
			negative 		= {r = 0.3, g = 0.5, b = 0.9 },
			positive		= {r = 0.8, g = 0.8, b = 0.6 },
		},
		["HOLY_POWER"]		= {r = .95, g = 0.9, b = 0   },
		["AMMOSLOT"]		= {r = 0.8, g = 0.6, b = 0   },
		["FUEL"]			= {r = 0,   g = .55, b = 0.5 },
		["STAGGER"] = {
			{r = 0.5, g = 1,    b = 0.5 },
			{r = 1,   g = 0.98, b = 0.7 },
			{r = 1,   g = 0.42, b = 0.42},
		},
	}

	RuneColors = {
		[1] = {176/255, 079/255, 079/255},		-- {0.69, 0.31, 0.31}
		[2] = {084/255, 155/255, 084/255},		-- {0.33, 0.59, 0.33}
		[3] = {079/255, 115/255, 166/255},		-- {0.31, 0.45, 0.63}
		[4] = {214/255, 191/255, 165/255},		-- {0.84, 0.75, 0.65}
	}
--]]

--[[ FONT ]----------------------------------------------------------------------------------------

	NORMAL_FONT_COLOR_CODE		= '|cffFFD200'
	HIGHLIGHT_FONT_COLOR_CODE	= '|cffFFFFFF'
	RED_FONT_COLOR_CODE			= '|cffFF2020'
	GREEN_FONT_COLOR_CODE		= '|cff20FF20'
	GRAY_FONT_COLOR_CODE		= '|cff808080'
	YELLOW_FONT_COLOR_CODE		= '|cffFFFF00'
	LIGHTYELLOW_FONT_COLOR_CODE	= '|cffFFFF9A'
	ORANGE_FONT_COLOR_CODE		= '|cffFF7F3F'
	ACHIEVEMENT_COLOR_CODE		= '|cffFFFF00'
	BATTLENET_FONT_COLOR_CODE	= '|cff82C5FF'

	NORMAL_FONT_COLOR			= {r = 1.0, g = 0.8, b = 0.0}
	HIGHLIGHT_FONT_COLOR		= {r = 1.0, g = 1.0, b = 1.0}
	RED_FONT_COLOR				= {r = 1.0, g = 0.1, b = 0.1}
	DIM_RED_FONT_COLOR			= {r = 0.8, g = 0.1, b = 0.1}
	GREEN_FONT_COLOR			= {r = 0.1, g = 1.0, b = 0.1}
	GRAY_FONT_COLOR			= {r = 0.5, g = 0.5, b = 0.5}
	YELLOW_FONT_COLOR			= {r = 1.0, g = 1.0, b = 0.0}
	LIGHTYELLOW_FONT_COLOR		= {r = 1.0, g = 1.0, b = 0.6}
	ORANGE_FONT_COLOR			= {r = 1.0, g = 0.5, b = 0.25}
	PASSIVE_SPELL_FONT_COLOR		= {r = 0.8, g = 0.6, b = 0.0}
	BATTLENET_FONT_COLOR 		= {r = 0.5, g = 0.8, b = 1.0}
--]]

--[[ ITEMS ]----------------------------------------------------------------------------------------

	ITEM_QUALITY0_DESC = "Poor"														--@ GlobalStrings.lua
	ITEM_QUALITY1_DESC = "Common"
	ITEM_QUALITY2_DESC = "Uncommon"
	ITEM_QUALITY3_DESC = "Rare"
	ITEM_QUALITY4_DESC = "Epic"
	ITEM_QUALITY5_DESC = "Legendary"
	ITEM_QUALITY6_DESC = "Artifact"
	ITEM_QUALITY7_DESC = "Heirloom"
	--------------------------------------------- Quality Numbers
	ITEM_QUALITY_POOR 		= 0				-- Gray
	ITEM_QUALITY_COMMON 	= 1				-- White
	ITEM_QUALITY_UNCOMMON 	= 2				-- Green
	ITEM_QUALITY_RARE 		= 3				-- Blue
	ITEM_QUALITY_EPIC 		= 4				-- Purple
	ITEM_QUALITY_LEGENDARY 	= 5				-- Orange
	--------------------------------------------- Border Coordinates
	LOOT_BORDER_QUALITY_COORDS = {
		[ITEM_QUALITY_UNCOMMON]	= {0.17968750, 0.23632813, 0.74218750, 0.96875000},
		[ITEM_QUALITY_RARE]		= {0.86718750, 0.92382813, 0.00390625, 0.23046875},
		[ITEM_QUALITY_EPIC]		= {0.92578125, 0.98242188, 0.00390625, 0.23046875},
		[ITEM_QUALITY_LEGENDARY]	= {0.80859375, 0.86523438, 0.00390625, 0.23046875},
	}
	--------------------------------------------- Item Quality
	NUM_ITEM_QUALITIES = 7

    ---------------------------------------------------------------------------
       *     QUALITY          COLOR               EXAMPLE
     ---------------------------------------------------------------------------
      [0]    Poor             Gray                Broken I.W.I.N. Button
      [1]    Common           White               Archmage Vargoth's Staff
      [2]    Uncommon         Green               X-52 Rocket Helmet
      [3]    Rare             Blue                Onyxia Scale Cloak
      [4]    Epic             Purple              Talisman of Ephemeral Power
      [5]    Legendary        Orange              Fragment of Val'anyr
      [6]    Artifact         Golden Yellow       The Twin Blades of Azzinoth
      [7]    Heirloom         Light Yellow        Bloodied Arcanite Reaper
     ---------------------------------------------------------------------------

	GetItemQualityColor
	-------------------
	ITEM_QUALITY_COLORS = {}

	for i = -1, (NUM_ITEM_QUALITIES) do
		ITEM_QUALITY_COLORS[i] = {}
		ITEM_QUALITY_COLORS[i].r,
		ITEM_QUALITY_COLORS[i].g,
		ITEM_QUALITY_COLORS[i].b,
		ITEM_QUALITY_COLORS[i].hex = GetItemQualityColor(i)
		ITEM_QUALITY_COLORS[i].hex = "|c" .. ITEM_QUALITY_COLORS[i].hex
	end

	local iname, _, iquality = GetItemInfo(iButton.link)
	local r, g, b, hex = GetItemQualityColor(iquality)
--]]



----------------------------------------------------------------------------------------------------
--[[ Blizzard Color Functions

	local RGBToColorCode, RGBTableToColorCode, ConvertRGBtoColorString

	RGBToColorCode = function(r, g, b)				--@ UIParent
		return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	end

	RGBTableToColorCode = function(table)
		return RGBToColorCode(table.r, table.g, table.b)
	end

	ConvertRGBtoColorString = function(color)		--@ UIParent
	--	Converts RGB Values to a Color String
		local r = color.r * 255
		local g = color.g * 255
		local b = color.b * 255
		return ("|cff%2x%2x%2x"):format(r, g, b)
	end
--]]

--[[ local classColors = {}					-- RothTooltip
	local reactionColors = {}
	local function GetHexColor(color)
		return ("%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
	end
	for class, color in pairs(RAID_CLASS_COLORS) do
		classColors[class] = GetHexColor(RAID_CLASS_COLORS[class])
	end
	for i = 1, (#FACTION_BAR_COLORS) do
		reactionColors[i] = GetHexColor(FACTION_BAR_COLORS[i])
	end
--]]

--[[	A.GetColor = function(unit, template)
		if (not unit) then
			return
		end

		local class = select(2, UnitClass(unit))
		local color = CLASS_COLORS[class]
		local T = template and upper(template)

		if (not CLASS_COLORS[class]) then
			if (T == "RGB") then
				return { r = 0.5, g = 0.5, b = 0.5 }
			elseif (T == "CFF") then
				return "|cffA1A1A1"
			else
				return 0.5, 0.5, 0.5
			end
		end

		if (T == "RGB") then
			return { r = color.r, g = color.g, b = color.b }
		elseif (T == "CFF") then
			return format("|c%s", color.colorStr)
		else
			return color.r, color.g, color.b
		end
	end
--]]

--[[ ColorHexa Notes

		BATTLENET_FONT_COLOR_CODE = "|cff82C5FF"

		FORMAT	EXAMPLE						QUERY
		--------	---------------------------------  ---------------------------------
		HEX		"ffC41F3B"					#82C5FF
		DECIMAL	( 130/255, 197/255, 255/255 )		RGB 130 197 255
		PERCENT	( .5, .8, 1 )					RGB 51% 77% 100%

--]]

--[[ Player Color

	A.GetPlayerColor = function()
		return PLAYER_CLASS_COLOR.r, PLAYER_CLASS_COLOR.g, PLAYER_CLASS_COLOR.b
	end

	A.GetPlayerColorRGB = function()
		return { r = PLAYER_CLASS_COLOR.r, g = PLAYER_CLASS_COLOR.g, b = PLAYER_CLASS_COLOR.b }
	end

	A.GetPlayerColorCFF = function()
		return ("|c%s"):format(PLAYER_CLASS_COLOR.colorStr)
	end

--]]

--[[ Unit Color

	A.GetClassColor = function(class)
		if (CLASS_COLORS[class]) then
			return CLASS_COLORS[class].r, CLASS_COLORS[class].g, CLASS_COLORS[class].b
		end

		return unpack(GRAY_COLOR)
	end
	A.GetClassColorCFF = function(class)
		return format("|c%s", CLASS_COLORS[class].colorStr)
	end
	A.GetUnitColor = function(unit)
		local class = select(2, UnitClass(unit))

		if (CLASS_COLORS[class]) then
			return CLASS_COLORS[class].r, CLASS_COLORS[class].g, CLASS_COLORS[class].b
		end

		return 0.63, 0.63, 0.63
	end
	A.GetUnitColorRGB = function(unit)
		local class = select(2, UnitClass(unit))

		if (CLASS_COLORS[class]) then
			return { r = CLASS_COLORS[class].r, g = CLASS_COLORS[class].g, b = CLASS_COLORS[class].b }
		end

		return { r = 0.63, g = 0.63, b = 0.63 }
	end
	A.GetUnitColorCFF = function(unit)
		local class = select(2, UnitClass(unit))

		return format("|c%s", CLASS_COLORS[class].colorStr)
	end
--]]

--[[ Hex Color 							-- credit: _Dev

	local hexcolor = {
		['space']		= "|cff8888EE",
		['number']	= "|cffEEEEEE",
		['boolean']	= "|cffEEEEEE",
		['frame']		= "|cff88FFFF",
		['table']		= "|cff88FF88",
		['function']	= "|cffFF66AA",
		['nil']		= "|cffFF0000",
	}
--]]

--[[ Colors

	local color = {
		['dead'] 			= {089/255, 089/255, 089/255, cff = "|cff808080"},	-- Dark Grey
		['ghost'] 		= {051/255, 051/255, 191/255, cff = "|cffC0C0C0"},	-- Grey
		['hated'] 		= {196/255, 031/255, 059/255, cff = "|cffC41F3B"},	-- Deep Red
		['tapped'] 		= {140/255, 145/255, 155/255, cff = "|cffC0C0C0"},	-- Grey
		['flagged'] 		= {255/255, 245/255, 105/255, cff = "|cffFFFF00"},	-- Deep Yellow (not the normal bright yellow)
		['dc']			= {214/255, 191/255, 165/255, cff = "|cffC0C0C0"},	-- Grey
		['disconnected']	= {0.5, 0.5, 0.5},		-- @ UnitFrame.lua
		['tapped']		= {0.6, 0.6, 0.6},
	}

	A.color = color
--]]



