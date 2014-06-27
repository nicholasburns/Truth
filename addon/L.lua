local ADDON_NAME = ...
local L = {}
_G[ADDON_NAME][4] = L


local rep = string.rep
local upper = string.upper
local format = string.format


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Constant  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
L["INDENT"]								= (" "):rep(5)								-- "     %s"
L["INDENT_S"]								= L["INDENT"] .. "%s"
L["INDENT_FORMAT"]							= L["INDENT"] .. "%s"

L["TAB"]									= (" "):rep(10)
L["DIV"]									= ("%s%s"):format(L["INDENT"], ("-"):rep(50))
L["HR"]									= ("-"):rep(70)

L["DOT"]									= "·"									L["INTERPUNCT"] = "·" -- Used when dot operator is not accessible & is slightly thinner
L["DOTS"]									= "…"

L["LEFT_BRACKET"]							= "‹"									--[["«"]]
L["RIGHT_BRACKET"]							= "›"									--[["»"]]
L["BRACKET_FORMAT"]							= "‹ %s ›"								--[["« %s »"]]--[["‹ %s ›"]]


-- Colors
L["CFF_RED_FORMAT"]							= "|cffC41F3B %s |r"						-- #C41F3B = "Strong red"
L["CFF_GREEN_FORMAT"]						= "|cff07D400 %s |r"						-- #07D400 = "Strong lime green"
L["CFF_BLUE_FORMAT"]						= "|cff69CCF0 %s |r"						-- #69CCF0 = "Soft blue"
L["CFF_YELLOW_FORMAT"]						= "|cffD3CF00 %s |r"						-- #D3CF00 = "Strong yellow"


-- Popup
L["POPUP_BUTTON"]							= OKAY


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  System  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
-- Debug
L["DEBUG_MESSAGE_FORMAT"]					= L["INDENT"] .. "|cff82C5FF%s|r  |cffCCCCCC%s|r"
L["DEBUG_LIST_TEXTURES_HEADER"]				= L["INDENT_S"]:format("|cff66CC33ListTextures|r")
L["DEBUG_LIST_CHILDREN_HEADER"]				= L["INDENT_S"]:format("|cffCC3366ListChildren|r")


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Modules  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
-- Auto

L["AUTO_COMBATLOG_TOGGLED_ON"]				= COMBATLOGENABLED						-- COMBATLOGENABLED  = "Combat being logged to Logs\\WoWCombatLog.txt"
L["AUTO_COMBATLOG_TOGGLED_OFF"]				= COMBATLOGDISABLED						-- COMBATLOGDISABLED = "Combat logging disabled"


-- Chat
L["CHAT_B_IN"]								=  "B_FROM"
L["CHAT_B_OUT"]							=  "B_›"
L["CHAT_W_IN"]								=  "W_FROM"
L["CHAT_W_OUT"]							=  "W_›"
L["CHAT_G"]								=  "G"
L["CHAT_O"]								=  "O"
L["CHAT_P"]								=  "P"
L["CHAT_PL"]								=  "PL"
L["CHAT_PG"]								=  "PG"
L["CHAT_R"]								=  "R"
L["CHAT_RL"]								=  "RL"
L["CHAT_RM"]								=  "RM"									-- CHAT_MONSTER_PARTY_GET
L["CHAT_RW"]								=  "RW"
L["CHAT_I"]								=  "I"
L["CHAT_IL"]								=  "IL"
L["CHAT_S_GET"]							=  "S"
L["CHAT_Y_GET"]							=  "Y"
L["CHAT_FLAG_GM"]							= ("|cffFF0000 %s|r"):format(CHAT_FLAG_GM)		-- CHAT_FLAG_GM = "<GM>"
L["CHAT_FLAG_AFK"]							= ("|cffFFFF00[%s|r]"):format(AFK)
L["CHAT_FLAG_DND"]							= ("|cffFF7F3F[%s|r]"):format(DND)
L["CHAT_FLAG_DC"]							= ("|cff999999(%s)|r"):format(PLAYER_OFFLINE)	-- FRIENDS_LIST_NOTE_OFFLINE_TEMPLATE = "|cff999999(%s)|r" -- PLAYER_OFFLINE = "Offline"
L["CHAT_CHANNEL_GENERAL"]					=  GENERAL									-- GENERAL = "General"
L["CHAT_CHANNEL_TRADE"]						=  TRADE									-- TRADE = "Trade"
L["CHAT_CHANNEL_LOCAL_DEFENSE"]				=  "LocalDefense"
L["CHAT_CHANNEL_LOOKING_FOR_GROUP"]			=  LOOKING									-- LOOKING = "Looking"
L["CHAT_CHANNEL_WORLD_DEFENSE"]				=  "WorldDefense"							-- CHAT_MSG_WORLDDEFENSE_FORMAT = "[%s] %s"
L["CHAT_CHANNEL_CONVERSATION"]				=  "Conversation"
L["CHAT_FRIEND_ONLINE"]						=  ERR_FRIEND_ONLINE_SS						-- ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h has come online."	-- ERR_FRIEND_ONLINE_SS = "is now |cff298F00online|r"
L["CHAT_FRIEND_OFFLINE"]						=  ERR_FRIEND_OFFLINE_S						-- ERR_FRIEND_OFFLINE_S = "%s has gone offline."				-- ERR_FRIEND_OFFLINE_S = "is now |cffFF0000offline|r"

-- Guild
L["GUILD_LEVEL_FORMAT"]						= GUILD_LEVEL								-- GUILD_LEVEL = "Guild Level %d"

-- Items
L["ITEM_LEVEL_FORMAT"]						= ITEM_LEVEL								-- ITEM_LEVEL = "Item Level %d"
L["ITEM_LEVEL_ABBR"]						= ITEM_LEVEL_ABBR							-- ITEM_LEVEL_ABBR = "iLvl"

-- Macro
L["MACRO_TAB1_TEXT"]						= GENERAL									-- GENERAL = "General"
L["MACRO_TAB2_TEXT"]						= (UnitName("player")):upper()				-- (UnitName("player")):upper() = "TRUTHMACHINE"

-- Merchant
L["MERCHANT_MINUS"]							= "|cffFF0000  -  |r"
L["MERCHANT_PLUS"]							= "|cff00FF00  +  |r"
L["MERCHANT_REPAIRS_HEADER"]					= "|cffC41F3BRepairs:|r"
L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]			= ("%s%s"):format(L["MERCHANT_REPAIRS_HEADER"], L["MERCHANT_MINUS"]) .. "%s"
L["MERCHANT_REPAIRS_ERROR"]					= ("%s %s"):format(L["MERCHANT_REPAIRS_HEADER"], ERR_NOT_ENOUGH_MONEY)						-- ERR_NOT_ENOUGH_MONEY = "You don't have enough money."
L["MERCHANT_SALES_HEADER"]					= "|cffABD473Sales:|r"
L["MERCHANT_SALES_EARNINGS_FORMAT"]			= ("%s%s"):format(L["MERCHANT_SALES_HEADER"], L["MERCHANT_PLUS"]) .. "%s"

-- Tooltip
L["TOOLTIP_AURA_APPLIED_BY"]					=  "Applied by: "
L["TOOLTIP_AURA_SPELL_ID"]					=  "ID: "
L["TOOLTIP_UNIT_LEVEL_BOSS"]					= ("|cffFF0000 %s |r"):format("??")
L["TOOLTIP_CLASSIFICATION_ELITE"]				= ("|cffAF5050 %s |r"):format(ELITE)			-- Elite		->	Elite
L["TOOLTIP_CLASSIFICATION_WORLDBOSS"]			= ("|cffAF5050 %s |r"):format(BOSS)			-- Boss		->	Boss
L["TOOLTIP_CLASSIFICATION_RARE"]				= ("|cffAF5050 %s |r"):format(ITEM_QUALITY3_DESC)	-- Rare		->	Rare
L["TOOLTIP_CLASSIFICATION_RAREELITE"]			= ("|cffAF5050 %s-%s |r"):format(ITEM_QUALITY3_DESC, ELITE)	-- Rare-Elite	->	Rare-Elite
L["TOOLTIP_ITEM_ITEMID_FORMAT"]				=  "|cffFFFFFF Item ID: |r %d"
L["TOOLTIP_ITEM_SPELLID_FORMAT"]				=  "|cffFFFFFF Spell ID: |r %s"
L["TOOLTIP_ITEM_COUNT_FORMAT"]				=  "|cffFFFFFF Item count: |r %d"
L["TOOLTIP_TOT_TARGETING_YOU"]				= ("|cffFF0000 ‹ %s › |r"):format(YOU)			-- < YOU >

-- Units
L["UNIT_LEVEL_FORMAT"]						= UNIT_LEVEL_TEMPLATE						-- UNIT_LEVEL_TEMPLATE = "Level %d"
L["UNIT_LEVEL_LETHAL"]						= UNIT_LETHAL_LEVEL_TEMPLATE					-- UNIT_LETHAL_LEVEL_TEMPLATE = "Level ??"

-- Wowhead
L["WOWHEAD_LINK"]							= "Wowhead Link"							-- Quest / Achievement Links
L["WOWHEAD_QUEST_URL"]						= "http://www.wowhead.com/quest=%d"
L["WOWHEAD_ACHIEVEMENT_URL"]					= "http://www.wowhead.com/achievement=%d"


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  CFF  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do
-- Conversion Formats
L["RGB_TO_CFF_FORMAT"]						= "|cff%.2x%.2x%.2x"
L["RGBA_TO_CFF_FORMAT"]						= "|cff%.2x%.2x%.2x%.2x"

-- Raid Icons
L["RAIDICON_STAR"]							= ("|cffFFFF00 %s |r"):format(RAID_TARGET_1)		-- RAID_TARGET_1	= "Star"
L["RAIDICON_CIRCLE"]						= ("|cffFF8000 %s |r"):format(RAID_TARGET_2)		-- RAID_TARGET_2	= "Circle"
L["RAIDICON_DIAMOND"]						= ("|cff912CEE %s |r"):format(RAID_TARGET_3)		-- RAID_TARGET_3	= "Diamond"
L["RAIDICON_TRIANGLE"]						= ("|cff00FF00 %s |r"):format(RAID_TARGET_4)		-- RAID_TARGET_4	= "Triangle"
L["RAIDICON_MOON"]							= ("|cffC7C7C7 %s |r"):format(RAID_TARGET_5)		-- RAID_TARGET_5	= "Moon"
L["RAIDICON_SQUARE"]						= ("|cff00FFFF %s |r"):format(RAID_TARGET_6)		-- RAID_TARGET_6	= "Square"
L["RAIDICON_CROSS"]							= ("|cffFF0000 %s |r"):format(RAID_TARGET_7)		-- RAID_TARGET_7	= "Cross"
L["RAIDICON_SKULL"]							= ("|cffFFFFFF %s |r"):format(RAID_TARGET_8)		-- RAID_TARGET_8	= "Skull"
L["RAIDICON_NONE"]							= ("|cffCCCCCC %s |r"):format(RAID_TARGET_NONE)	-- RAID_TARGET_NONE	= "None"
L["RAIDICON_HEADER"]						= ("|cffCCCCCC %s |r"):format(RAID_TARGET_ICON)	-- RAID_TARGET_ICON	= "Target Marker Icon"
end


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Miscellaneous  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do
-- Headers
L["CRITICAL"]								= "|cffC41F3B Critical: |r"					-- Red
L["IMPORTANT"]								= "|cffD3CF00 Important: |r"					-- Yellow
L["CASUAL"]								= "|cff07D400 Casual: |r"					-- Green

-- Statuses
L["UNKNOWN"]								= UNKNOWN									-- UNKNOWN = "Unknown"

-- Symbols
L["OOR"]									= "●"									--[["•"]] --[["◦"]] --[["§"]]
L["BACKSLASH"]								= "\\"
L["SLASH"]								= "/"
L["UNDERSCORE"]							= "_"
end

----------------------------------------------------------------------------------------------------
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Unsorted  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
----------------------------------------------------------------------------------------------------










--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Development  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do -- Dump
L["NAME"]									= "Name"
L["FRAME"]								= "Frame"
L["PARENT"]								= "Parent"
L["TYPE"]									= "Type"
L["TOPLEVEL"]								= "TopLevel"
L["SIZE"]									= "Size"									--[[Dimensions]]	-- L["WIDTH"] = "Width" L["HEIGHT"] = "Height"
L["SCALE"]								= "Scale"
L["POINT"]								= "Point"									--[[Position]]		-- L["LEFT"] = "Left" L["RIGHT"] = "Right" L["TOP"] = "Top" L["BOTTOM"] = "Bottom"
L["STRATA"]								= "Strata"								--[[Stacking]]
L["LEVEL"]								= "Level"
L["ALPHA"]								= "Alpha"									--[[Visibility]]
L["SHOWN"]								= "Shown"
L["VISIBLE"]								= "Visible"								--[[Interactive]]	-- L["MOVABLE"] = "Movable" L["RESIZABLE"] = "Resizable" L["USER_PLACED"] = "UserPlaced"
end


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Keybinds  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do
L["KEY_ALT"]								= "A"									--[[Modifiers]]
L["KEY_CTRL"]								= "C"
L["KEY_SHIFT"]								= "S"
L["KEY_CAPSLOCK"]							= "CL"
L["KEY_BACKSPACE"]							= "BACK"									--[[Spaces]]
L["KEY_ENTER"]								= "ENTER"
L["KEY_SPACE"]								= "SPACE"
L["KEY_TAB"]								= "TAB"
L["KEY_APOSTROPHE"]							= "'"									--[[Characters]]
--	 L["KEY_COMMA"]								= LARGE_NUMBER_SEPERATOR					--=>				LARGE_NUMBER_SEPERATOR = ","
L["KEY_COMMA"]								= PLAYER_LIST_DELIMITER						--=>				PLAYER_LIST_DELIMITER = ", "
L["KEY_MINUS"]								= "\-"
L["KEY_PLUS"]								= "\+"
L["KEY_RIGHTBRACKET"]						= "\]"
L["KEY_SEMICOLON"]							= "\;"
L["KEY_SLASH"]								= "\/"
L["KEY_TILDE"]								= "\~"
L["KEY_PRINTSCREEN"]						= "PRINT"									--[[PrintScreen]]	--[[3]]
L["KEY_PAUSE"]								= "PAUSE"
L["KEY_INSERT"]							= "INS"									--[[Insert]]		--[[3]]
L["KEY_HOME"]								= "HOME"
L["KEY_PAGEUP"]							= "PAGEUP"
L["KEY_DELETE"]							= "DEL"									--[[Delete]]		--[[3]]
L["KEY_END"]								= "END"
L["KEY_PAGEDOWN"]							= "PAGEDOWN"
L["KEY_UP"]								= "^"									--[[Arrows]]		--[[4]]
L["KEY_DOWN"]								= "v"
L["KEY_LEFT"]								= "<"
L["KEY_RIGHT"]								= ">"
L["KEY_NUMLOCK"]							= "L"									--[[Numpad]]		--[[16]]
L["KEY_NUMPADDIVIDE"]						= "\/"
L["KEY_NUMPADMULTIPLY"]						= ""
L["KEY_NUMPADMINUS"]						= "\-"
L["KEY_NUMPADPLUS"]							= "\+"
L["KEY_NUMPADDECIMAL"]						= "N."
L["KEY_NUMPAD0"]							= "0"
L["KEY_NUMPAD1"]							= "1"
L["KEY_NUMPAD2"]							= "2"
L["KEY_NUMPAD3"]							= "3"
L["KEY_NUMPAD4"]							= "4"
L["KEY_NUMPAD5"]							= "5"
L["KEY_NUMPAD6"]							= "6"
L["KEY_NUMPAD7"]							= "7"
L["KEY_NUMPAD8"]							= "8"
L["KEY_NUMPAD9"]							= "9"
L["KEY_MOUSEBUTTON"]						= "M"									--[[Mouse]]		--[[6]]
L["KEY_BUTTON1"]							= "LM"									-- Left Mouse Button
L["KEY_BUTTON2"]							= "RM"									-- Right Mouse Button
L["KEY_BUTTON3"]							= "MM"									-- Middle Mouse Button
L["KEY_BUTTON4"]							= "M4"
L["KEY_BUTTON5"]							= "M5"
L["KEY_MOUSEWHEELUP"]						= "M^"									--[[Mousewheel]]	--[[2]]
L["KEY_MOUSEWHEELDOWN"]						= "Mv"									-- "Mouse Wheel Down"
end


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Blizzard UI  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do -- Blizzard Addons
L["BLIZZARD_ACHIEVEMENTUI"]					= "Blizzard_AchievementUI"
L["BLIZZARD_ARCHAEOLOGYUI"]					= "Blizzard_ArchaeologyUI"
L["BLIZZARD_ARENAUI"]						= "Blizzard_ArenaUI"
L["BLIZZARD_AUCTIONUI"]						= "Blizzard_AuctionUI"
L["BLIZZARD_BARBERSHOPUI"]					= "Blizzard_BarberShopUI"
L["BLIZZARD_BATTLEFIELDMINIMAP"]				= "Blizzard_BattlefieldMinimap"
L["BLIZZARD_BLACKMARKETUI"]					= "Blizzard_BlackMarketUI"
L["BLIZZARD_BINDINGUI"]						= "Blizzard_BindingUI"
L["BLIZZARD_CALENDAR"]						= "Blizzard_Calendar"
L["BLIZZARD_COMBATLOG"]						= "Blizzard_CombatLog"
L["BLIZZARD_COMBATTEXT"]						= "Blizzard_CombatText"
L["BLIZZARD_ENCOUNTERJOURNAL"]				= "Blizzard_EncounterJournal"
L["BLIZZARD_GLYPHUI"]						= "Blizzard_GlyphUI"
L["BLIZZARD_GMSURVEYUI"]						= "Blizzard_GMSurveyUI"
L["BLIZZARD_GMCHATUI"]						= "Blizzard_GMChatUI"
L["BLIZZARD_GUILDBANKUI"]					= "Blizzard_GuildBankUI"
L["BLIZZARD_GUILDUI"]						= "Blizzard_GuildUI"
L["BLIZZARD_INSPECTUI"]						= "Blizzard_InspectUI"
L["BLIZZARD_ITEMSOCKETINGUI"]					= "Blizzard_ItemSocketingUI"
L["BLIZZARD_ITEMALTERATIONUI"]				= "Blizzard_ItemAlterationUI"
L["BLIZZARD_ITEMUPGRADEUI"]					= "Blizzard_ItemUpgradeUI"
L["BLIZZARD_LOOKINGFORGUILDUI"]				= "Blizzard_LookingForGuildUI"
L["BLIZZARD_MACROUI"]						= "Blizzard_MacroUI"
L["BLIZZARD_PETJOURNAL"]						= "Blizzard_PetJournal"
L["BLIZZARD_PVPUI"]							= "Blizzard_PVPUI"
L["BLIZZARD_QUESTCHOICE"]					= "Blizzard_QuestChoice"
L["BLIZZARD_RAIDUI"]						= "Blizzard_RaidUI"
L["BLIZZARD_REFORGINGUI"]					= "Blizzard_ReforgingUI"
L["BLIZZARD_STOREUI"]						= "Blizzard_StoreUI"
L["BLIZZARD_TALENTUI"]						= "Blizzard_TalentUI"
L["BLIZZARD_TIMEMANAGER"]					= "Blizzard_TimeManager"
L["BLIZZARD_TOKENUI"]						= "Blizzard_TokenUI"
L["BLIZZARD_TRADESKILLUI"]					= "Blizzard_TradeSkillUI"
L["BLIZZARD_TRAINERUI"]						= "Blizzard_TrainerUI"
L["BLIZZARD_VEHICLEUI"]						= "Blizzard_VehicleUI"
L["BLIZZARD_VOIDSTORAGEUI"]					= "Blizzard_VoidStorageUI"
end


--[[------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Truth APIS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--]]------------------------------------------------------------------------------------------------
do -- Time
L["TIME_ONE_MINUTE"]						= ONE_MINUTE								-- ONE_MINUTE			= 60
L["TIME_ONE_HOUR"]							= ONE_HOUR								-- ONE_HOUR			= 60 * ONE_MINUTE
L["TIME_ONE_DAY"]							= ONE_DAY									-- ONE_DAY			= 24 * ONE_HOUR
L["TIME_ONE_MONTH"]							= ONE_MONTH								-- ONE_MONTH			= 30 * ONE_DAY
L["TIME_ONE_YEAR"]							= ONE_YEAR								-- ONE_YEAR			= 12 * ONE_MONTH

L["TIME_SECS_FORMAT"]						= LASTONLINE_SECS							-- LASTONLINE_SECS		= "< a minute"
L["TIME_MINUTES_FORMAT"]						= LASTONLINE_MINUTES						-- LASTONLINE_MINUTES	= "%d |4minute:minutes"
L["TIME_HOURS_FORMAT"]						= LASTONLINE_HOURS							-- LASTONLINE_HOURS		= "%d |4hour:hours"
L["TIME_DAYS_FORMAT"]						= LASTONLINE_DAYS							-- LASTONLINE_DAYS		= "%d |4day:days"
L["TIME_MONTHS_FORMAT"]						= LASTONLINE_MONTHS							-- LASTONLINE_MONTHS	= "%d |4month:months"
L["TIME_YEARS_FORMAT"]						= LASTONLINE_YEARS							-- LASTONLINE_YEARS		= "%d |4year:years"

L["TIME_FORMAT_SECS"]						= LASTONLINE_SECS							-- LASTONLINE_SECS		= "< a minute"
L["TIME_FORMAT_MINUTES"]						= LASTONLINE_MINUTES						-- LASTONLINE_MINUTES	= "%d |4minute:minutes"
L["TIME_FORMAT_HOURS"]						= LASTONLINE_HOURS							-- LASTONLINE_HOURS		= "%d |4hour:hours"
L["TIME_FORMAT_DAYS"]						= LASTONLINE_DAYS							-- LASTONLINE_DAYS		= "%d |4day:days"
L["TIME_FORMAT_MONTHS"]						= LASTONLINE_MONTHS							-- LASTONLINE_MONTHS	= "%d |4month:months"
L["TIME_FORMAT_YEARS"]						= LASTONLINE_YEARS							-- LASTONLINE_YEARS		= "%d |4year:years"
end


----------------------------------------------------------------------------------------------------
--	Backup
----------------------------------------------------------------------------------------------------
--[[ Chat

	local charOnlineMsg						=  ERR_FRIEND_ONLINE_SS:format(playerName, playerName)
	local charOfflineMsg					=  ERR_FRIEND_OFFLINE_S:format(playerName)
	local playerNotFoundMsg					=  ERR_CHAT_PLAYER_NOT_FOUND_S:format(playerName)

	L["CHAT_PLAYER_NOT_FOUND"]				=  ERR_CHAT_PLAYER_NOT_FOUND_S				-- ERR_CHAT_PLAYER_NOT_FOUND_S = "No player named '%s' is currently playing."


	L["CHAT"] = {							-- AsphyxiaUI Locale Example
		["BN_WHISPER_GET"]					= "From",
		["WHISPER_GET"]					= "From",
		["GUILD_GET"]						= "G",
		["OFFICER_GET"]					= "O",
		["INSTANCE_CHAT"]					= "I",
		["INSTANCE_CHAT_LEADER"]				= "IL",
		["PARTY_GET"]						= "P",
		["PARTY_GUIDE_GET"]					= "P",
		["PARTY_LEADER_GET"]				= "P",
		["RAID_GET"]						= "R",
		["RAID_LEADER_GET"]					= "R",
		["RAID_WARNING_GET"]				= "W",
		["CHANNEL_GENERAL"]					=  GENERAL,
		["CHANNEL_TRADE"]					=  TRADE,
		["CHANNEL_DEFENSE"]					= "LocalDefense",
		["CHANNEL_RECRUTMENT"]				= "GuildRecruitment",
		["CHANNEL_LFG"]					=  LOOKING,
		["FLAG_AFK"]						= "|cffFF0000 [AFK] |r ",
		["FLAG_DND"]						= "|cffE7E716 [DND] |r ",
	}
--]]

--[[ Raid Icons CFF

	L["RAIDICON_SKULL_CFF"]					= "|cffFFFFFF Skull |r"
	L["RAIDICON_CROSS_CFF"]					= "|cffFF0000 Cross |r"
	L["RAIDICON_SQUARE_CFF"]					= "|cff00FFFF Square |r"
	L["RAIDICON_MOON_CFF"]					= "|cffC7C7C7 Moon |r"
	L["RAIDICON_TRIANGLE_CFF"]				= "|cff00FF00 Triangle |r"
	L["RAIDICON_DIAMOND_CFF"]				= "|cff912CEE Diamond |r"
	L["RAIDICON_CIRCLE_CFF"]					= "|cffFF8000 Circle |r"
	L["RAIDICON_STAR_CFF"]					= "|cffFFFF00 Star |r"
	L["RAIDICON_CLEAR_CFF"]					= "|cffCCCCCC Clear |r"
--]]

--[[ Faction

	L["FACTION_STANDING_LABEL1"]				= FACTION_STANDING_LABEL1					-- FACTION_STANDING_LABEL1 = "Hated"
	L["FACTION_STANDING_LABEL2"]				= FACTION_STANDING_LABEL2					-- FACTION_STANDING_LABEL2 = "Hostile"
	L["FACTION_STANDING_LABEL3"]				= FACTION_STANDING_LABEL3					-- FACTION_STANDING_LABEL3 = "Unfriendly"
	L["FACTION_STANDING_LABEL4"]				= FACTION_STANDING_LABEL4					-- FACTION_STANDING_LABEL4 = "Neutral"
	L["FACTION_STANDING_LABEL5"]				= FACTION_STANDING_LABEL5					-- FACTION_STANDING_LABEL5 = "Friendly"
	L["FACTION_STANDING_LABEL6"]				= FACTION_STANDING_LABEL6					-- FACTION_STANDING_LABEL6 = "Honored"
	L["FACTION_STANDING_LABEL7"]				= FACTION_STANDING_LABEL7					-- FACTION_STANDING_LABEL7 = "Revered"
	L["FACTION_STANDING_LABEL8"]				= FACTION_STANDING_LABEL8					-- FACTION_STANDING_LABEL8 = "Exalted"
--]]

--[[ Default Hotkey Strings

	L["KEY_BUTTON1"]						= "Left Mouse Button"						-- ( 33 ) Mouse Buttons
	L["KEY_BUTTON2"]						= "Right Mouse Button"
	L["KEY_BUTTON3"]						= "Middle Mouse"
	L["KEY_BUTTON4"]						= "Mouse Button 4"
	L["KEY_BUTTON5"]						= "Mouse Button 5"
	L["KEY_BUTTON6"]						= "Mouse Button 6"
	L["KEY_BUTTON7"]						= "Mouse Button 7"
	L["KEY_BUTTON8"]						= "Mouse Button 8"
	L["KEY_BUTTON9"]						= "Mouse Button 9"
	L["KEY_BUTTON10"]						= "Mouse Button 10"
	L["KEY_BUTTON11"]						= "Mouse Button 11"
	L["KEY_BUTTON12"]						= "Mouse Button 12"
	L["KEY_BUTTON13"]						= "Mouse Button 13"
	L["KEY_BUTTON14"]						= "Mouse Button 14"
	L["KEY_BUTTON15"]						= "Mouse Button 15"
	L["KEY_BUTTON16"]						= "Mouse Button 16"
	L["KEY_BUTTON17"]						= "Mouse Button 17"
	L["KEY_BUTTON18"]						= "Mouse Button 18"
	L["KEY_BUTTON19"]						= "Mouse Button 19"
	L["KEY_BUTTON20"]						= "Mouse Button 20"
	L["KEY_BUTTON21"]						= "Mouse Button 21"
	L["KEY_BUTTON22"]						= "Mouse Button 22"
	L["KEY_BUTTON23"]						= "Mouse Button 23"
	L["KEY_BUTTON24"]						= "Mouse Button 24"
	L["KEY_BUTTON25"]						= "Mouse Button 25"
	L["KEY_BUTTON26"]						= "Mouse Button 26"
	L["KEY_BUTTON27"]						= "Mouse Button 27"
	L["KEY_BUTTON28"]						= "Mouse Button 28"
	L["KEY_BUTTON29"]						= "Mouse Button 29"
	L["KEY_BUTTON30"]						= "Mouse Button 30"
	L["KEY_BUTTON31"]						= "Mouse Button 31"
	L["KEY_MOUSEWHEELDOWN"]					= "Mouse Wheel Down"						-- ( 2 ) Mousewheel
	L["KEY_MOUSEWHEELUP"]					= "Mouse Wheel Up"
	L["KEY_PRINTSCREEN"]					= "Print Screen"							-- ( 3 ) Print Screen Row
	L["KEY_SCROLLLOCK"]						= "Scroll Lock"
	L["KEY_PAUSE"]							= "Pause"
	L["KEY_INSERT"]						= "Insert"								-- ( 6 ) Above Arrows
	L["KEY_DELETE"]						= "Delete"
	L["KEY_HOME"]							= "Home"
	L["KEY_END"]							= "End"
	L["KEY_PAGEUP"]						= "Page Up"
	L["KEY_PAGEDOWN"]						= "Page Down"
	L["KEY_UP"]							= "Up Arrow"								-- ( 4 ) Arrows
	L["KEY_DOWN"]							= "Down Arrow"
	L["KEY_LEFT"]							= "Left Arrow"
	L["KEY_RIGHT"]							= "Right Arrow"
	L["KEY_NUMLOCK"]						= "Num Lock"								-- ( 16 ) Numpad
	L["KEY_NUMPADDIVIDE"]					= "Num Pad /"
	L["KEY_NUMPADMULTIPLY"]					= "Num Pad *"
	L["KEY_NUMPADMINUS"]					= "Num Pad -"
	L["KEY_NUMPADPLUS"]						= "Num Pad +"
	L["KEY_NUMPADDECIMAL"]					= "Num Pad ."
	L["KEY_NUMPAD0"]						= "Num Pad 0"
	L["KEY_NUMPAD1"]						= "Num Pad 1"
	L["KEY_NUMPAD2"]						= "Num Pad 2"
	L["KEY_NUMPAD3"]						= "Num Pad 3"
	L["KEY_NUMPAD4"]						= "Num Pad 4"
	L["KEY_NUMPAD5"]						= "Num Pad 5"
	L["KEY_NUMPAD6"]						= "Num Pad 6"
	L["KEY_NUMPAD7"]						= "Num Pad 7"
	L["KEY_NUMPAD8"]						= "Num Pad 8"
	L["KEY_NUMPAD9"]						= "Num Pad 9"
--]]

--[[ Framestack

	local F = {}

	F["FRAME"]		= format(DEFAULT_FORMAT, "Frame")
	--
	F["NAME"]			= format(DEFAULT_FORMAT, "Name")
	F["TYPE"]			= format(DEFAULT_FORMAT, "Type")
	F["PARENT"]		= format(DEFAULT_FORMAT, "Parent")
	--
	F["PROTECTED"]		= format(DEFAULT_FORMAT, "Protected")
	--
	F["SHOWN"]		= format(DEFAULT_FORMAT, "Shown")
	F["VISIBLE"]		= format(DEFAULT_FORMAT, "Visible")
	F["TOPLEVEL"]		= format(DEFAULT_FORMAT, "TopLevel")
	F["LEVEL"]		= format(DEFAULT_FORMAT, "Level")
	F["STRATA"]		= format(DEFAULT_FORMAT, "Strata")
	--
	F["POINT"]		= format(DEFAULT_FORMAT, "Point")
	--
	F["TOP"]			= format(DEFAULT_FORMAT, "Top")
	F["RIGHT"]		= format(DEFAULT_FORMAT, "Right")
	F["BOTTOM"]		= format(DEFAULT_FORMAT, "Bottom")
	F["LEFT"]			= format(DEFAULT_FORMAT, "Left")
	--
	F["WIDTH"]		= format(DEFAULT_FORMAT, "Width")
	F["HEIGHT"]		= format(DEFAULT_FORMAT, "Height")
	--
	F["SCALE"]		= format(DEFAULT_FORMAT, "Scale")
	F["EFFECTIVESCALE"]	= format(DEFAULT_FORMAT, "EffectiveScale")
	--
	F["ALPHA"]		= format(DEFAULT_FORMAT, "Alpha")
	F["EFFECTIVEALPHA"]	= format(DEFAULT_FORMAT, "EffectiveAlpha")
	--
	F["USERPLACED"]	= format(DEFAULT_FORMAT, "UserPlaced")
	F["MOVABLE"]		= format(DEFAULT_FORMAT, "Movable")
	F["RESIZABLE"]		= format(DEFAULT_FORMAT, "Resizable")
	--
	F["KEYBOARD"]		= format(DEFAULT_FORMAT, "KeyboardEnabled")
	F["MOUSE"]		= format(DEFAULT_FORMAT, "MouseEnabled")
	F["MOUSEWHEEL"]	= format(DEFAULT_FORMAT, "MouseWheelEnabled")
	--
	F["DIVIDER"]		= format(DEFAULT_FORMAT, DEFAULT_DIVIDER)
--]]

--[[ Anchor Points

	L["ANCHOR_POINT"] = {
		["POINT"]		= "Point",
		["FRAME"]		= "Frame",
		["REL_POINT"]	= "Point2",
		["X"]		= "X",
		["Y"]		= "Y",
	}
--]]

--[[ Text Ruler

$   |    .    .    .    .    .    .    .    |    .    .    .    .    .    .    .    .    .    .    .

--]]
