--[[ Name: LibSharedMedia-3.0
	Revision: $Revision: 86 $
	Author: Elkano (elkano@gmx.de)
	Inspired By: SurfaceLib by Haste/Otravi (troeks@gmail.com)
	Website: http://www.wowace.com/projects/libsharedmedia-3-0/
	Description: Shared handling of media data (fonts, sounds, textures,  ...) between addons.
	Dependencies: LibStub, CallbackHandler-1.0
	License: LGPL v2.1
--]]

-- LibStub
local MAJOR, MINOR = "LibSharedMedia-3.0", 5000404	-- 5.0.4 v4 / increase manually on changes
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if (not lib) then return end


-- Upvalue
local _G			= getfenv(0)
local pairs		= _G.pairs
local type		= _G.type
local band		= _G.bit.band
local table_insert	= _G.table.insert
local table_sort	= _G.table.sort


-- Locale
local locale = GetLocale()
local locale_is_western = nil

local LOCALE_MASK   = 0
lib.LOCALE_BIT_koKR = 1
lib.LOCALE_BIT_ruRU = 2
lib.LOCALE_BIT_zhCN = 4
lib.LOCALE_BIT_zhTW = 8
lib.LOCALE_BIT_western = 128


-- CallbackHandler
local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0")


-- ???
lib.callbacks			= lib.callbacks or CallbackHandler:New(lib)
lib.DefaultMedia		= lib.DefaultMedia or {}
lib.MediaList			= lib.MediaList or {}
lib.MediaTable			= lib.MediaTable or {}
lib.MediaType			= lib.MediaType or {}
lib.OverrideMedia		= lib.OverrideMedia or {}
--
local defaultMedia		= lib.DefaultMedia
local mediaList		= lib.MediaList
local mediaTable		= lib.MediaTable
local overrideMedia		= lib.OverrideMedia


-- Media Types Constants
lib.MediaType.BACKGROUND	= "background"			-- background textures
lib.MediaType.BORDER	= "border"			-- border textures
lib.MediaType.FONT		= "font"				-- font files
lib.MediaType.STATUSBAR	= "statusbar"			-- statusbar textures
lib.MediaType.SOUND		= "sound"				-- sound files



----------------------------------------------------------------------------------------------------
--	Populate empty libs with Bizzard Media at creation
----------------------------------------------------------------------------------------------------

-- BACKGROUND
if (not lib.MediaTable.background) then
	lib.MediaTable.background = {}
end

lib.MediaTable.background["None"]				= [=[]=]
lib.MediaTable.background["UI-Dialog-BG"]		= [=[Interface\DialogFrame\UI-DialogBox-Background]=]
lib.MediaTable.background["UI-Dialog-BG-Dark"]	= [=[Interface\DialogFrame\UI-DialogBox-Background-Dark]=]
lib.MediaTable.background["UI-Dialog-BG-Gold"]	= [=[Interface\DialogFrame\UI-DialogBox-Gold-Background]=]
lib.MediaTable.background["UI-LowHealth"]		= [=[Interface\FullScreenTextures\LowHealth]=]
lib.MediaTable.background["UI-Marble"]			= [=[Interface\FrameGeneral\UI-Background-Marble]=]
lib.MediaTable.background["UI-Out of Control"]	= [=[Interface\FullScreenTextures\OutOfControl]=]
lib.MediaTable.background["UI-Parchment"]		= [=[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal]=]
lib.MediaTable.background["UI-Parchment 2"]		= [=[Interface\AchievementFrame\UI-GuildAchievement-Parchment-Horizontal]=]
lib.MediaTable.background["UI-Rock"]			= [=[Interface\FrameGeneral\UI-Background-Rock]=]
lib.MediaTable.background["UI-Tabard BG"]		= [=[Interface\TabardFrame\TabardFrameBackground]=]
lib.MediaTable.background["UI-Tooltip"]			= [=[Interface\Tooltips\UI-Tooltip-Background]=]
lib.MediaTable.background["Solid"]				= [=[Interface\Buttons\WHITE8X8]=]
lib.DefaultMedia.background = "None"


-- BORDER
if (not lib.MediaTable.border) then
	lib.MediaTable.border = {}
end

lib.MediaTable.border["UI-Achievement-Wood"]		= [=[Interface\AchievementFrame\UI-Achievement-WoodBorder]=]
lib.MediaTable.border["UI-Chat Bubble"]			= [=[Interface\Tooltips\ChatBubble-Backdrop]=]
lib.MediaTable.border["UI-Dialog"]				= [=[Interface\DialogFrame\UI-DialogBox-Border]=]
lib.MediaTable.border["UI-Dialog Gold"]			= [=[Interface\DialogFrame\UI-DialogBox-Gold-Border]=]
lib.MediaTable.border["UI-Party"]				= [=[Interface\CHARACTERFRAME\UI-Party-Border]=]
lib.MediaTable.border["UI-Tooltip"]			= [=[Interface\Tooltips\UI-Tooltip-Border]=]
lib.MediaTable.border["None"]					= [=[]=]
lib.DefaultMedia.border = "None"


-- FONT
if (not lib.MediaTable.font) then lib.MediaTable.font = {} end
local SML_MT_font = lib.MediaTable.font


--[[ Table-1:  Font Compatibility Table
	All font files are currently in all clients.
	The following table depicts which font supports which charset as of 5.0.4

     +----------------------------------------------------------------------------------------------+
	|		 NAME		|	    FILE		|  Latin	|   koKR	|   ruRU	|   zhCN	|   zhTW	|
     +------------------------+-------------------+----^----+----^----+----^----+----^----+----^----+
	|		 1234		|	    1234		|		|   [x]	|   [x]	|   [x]	|   [x]	|
     +------------.-----------+---------.---------+----.----+----.----+----.----+----.----+----.----+
	|					|				|		|		|		|		|		|
	|  2002				|  2002.ttf		|	x	|	x	|	x	|	-	|	-	|
	|  2002 Bold			|  2002B.ttf		|	x	|	x	|	x	|	-	|	-	|
	|  AR-CrystalBK-Demi	|  ARHei.ttf		|	x	|	-	|	x	|	x	|	x	|
	|  Arial Narrow		|  ARIALN.TTF		|	x	|	-	|	x	|	-	|	-	|
	|  AR-ZhongkaiGBK-M (C)	|  ARKai_C.ttf		|	x	|	-	|	x	|	x	|	x	|
	|  AR-ZhongkaiGBK-M		|  ARKai_T.ttf		|	x	|	-	|	x	|	x	|	x	|
	|  AR-Heiti2 Medium B5	|  bHEI00M.ttf		|	-	|	-	|	-	|	-	|	x	|
	|  AR-Heiti2 Bold B5	|  bHEI01B.ttf		|	-	|	-	|	-	|	-	|	x	|
	|  AR-Kaiti Medium B5	|  bKAI00M.ttf		|	-	|	-	|	-	|	-	|	x	|
	|  AR-Leisu Demi B5		|  bLEI00D.ttf		|	-	|	-	|	-	|	-	|	x	|
	|  Friz Quadrata TT		|  FRIZQT__.TTF	|	x	|	-	|	-	|	-	|	-	|
	|  FrizQuadrataCTT		|  FRIZQT___CYR.TTF	|	-	|	-	|	x	|	-	|	-	|
	|  YDIWingsM			|  K_Damage.TTF	|	-	|	x	|	x	|	-	|	-	|
	|  MoK				|  K_Pagetext.TTF	|	x	|	x	|	x	|	-	|	-	|
	|  Morpheus			|  MORPHEUS.TTF	|	x	|	-	|	-	|	-	|	-	|
	|  Morpheus			|  MORPHEUS_CYR.TTF	|	x	|	-	|	x	|	-	|	-	|
	|  Nimrod MT			|  NIM_____.ttf	|	x	|	-	|	x	|	-	|	-	|
	|  Skurri				|  SKURRI.TTF		|	x	|	-	|	-	|	-	|	-	|
	|  Skurri				|  KURRI_CYR.TTF	|	x	|	-	|	x	|	-	|	-	|
	|					|				|		|		|		|		|		|
     +----------------------------------------------------------------------------------------------+

--~	WARNING:	FRIZQT___CYR is available on western-clients, but has no support special European chars (e.g. é, ï, ö  ...)
--~			Due to this, we cannot use it as a replacement for FRIZQT__.TTF
--]]



if (locale == "koKR") then
	SML_MT_font["굵은 글꼴"]					= [=[Fonts\2002B.TTF]=]
	SML_MT_font["기본 글꼴"]					= [=[Fonts\2002.TTF]=]
	SML_MT_font["데미지 글꼴"]					= [=[Fonts\K_Damage.TTF]=]
	SML_MT_font["퀘스트 글꼴"]					= [=[Fonts\K_Pagetext.TTF]=]
	lib.DefaultMedia["font"] = "기본 글꼴"
	LOCALE_MASK = lib.LOCALE_BIT_koKR
elseif (locale == "zhCN") then
	SML_MT_font["伤害数字"]					= [=[Fonts\ARKai_C.ttf]=]
	SML_MT_font["默认"]						= [=[Fonts\ARKai_T.ttf]=]
	SML_MT_font["聊天"]						= [=[Fonts\ARHei.ttf]=]
	lib.DefaultMedia["font"] = "默认"
	LOCALE_MASK = lib.LOCALE_BIT_zhCN
elseif (locale == "zhTW") then
	LOCALE_MASK = lib.LOCALE_BIT_zhTW
	SML_MT_font["提示訊息"]					= [=[Fonts\bHEI00M.ttf]=]
	SML_MT_font["聊天"]						= [=[Fonts\bHEI01B.ttf]=]
	SML_MT_font["傷害數字"]					= [=[Fonts\bKAI00M.ttf]=]
	SML_MT_font["預設"]						= [=[Fonts\bLEI00D.ttf]=]
	lib.DefaultMedia["font"] 	= "預設"
elseif (locale == "ruRU") then
	SML_MT_font["2002"]						= [=[Fonts\2002.TTF]=]
	SML_MT_font["2002 Bold"]					= [=[Fonts\2002B.TTF]=]
	SML_MT_font["AR-CrystalzcuheiGBK-D"]		= [=[Fonts\ARHei.TTF]=]
	SML_MT_font["AR-ZhongkaiGBK-M (combat)"]	= [=[Fonts\ARKai_C.TTF]=]
	SML_MT_font["AR-ZhongkaiGBK-M"]			= [=[Fonts\ARKai_T.TTF]=]
	SML_MT_font["Arial Narrow"]				= [=[Fonts\ARIALN.TTF]=]
	SML_MT_font["Friz Quadrata TT"]			= [=[Fonts\FRIZQT___CYR.TTF]=]
	SML_MT_font["MoK"]						= [=[Fonts\K_Pagetext.TTF]=]
	SML_MT_font["Morpheus"]					= [=[Fonts\MORPHEUS_CYR.TTF]=]
	SML_MT_font["Nimrod MT"]					= [=[Fonts\NIM_____.ttf]=]
	SML_MT_font["Skurri"]					= [=[Fonts\SKURRI_CYR.TTF]=]
	lib.DefaultMedia.font = "Friz Quadrata TT"
	LOCALE_MASK = lib.LOCALE_BIT_ruRU
else
	SML_MT_font["2002"]						= [=[Fonts\2002.TTF]=]
	SML_MT_font["2002 Bold"]					= [=[Fonts\2002B.TTF]=]
	SML_MT_font["AR-CrystalzcuheiGBK-D"]		= [=[Fonts\ARHei.TTF]=]
	SML_MT_font["AR-ZhongkaiGBKMM (C)"]		= [=[Fonts\ARKai_C.TTF]=]
	SML_MT_font["AR-ZhongkaiGBK-M"]			= [=[Fonts\ARKai_T.TTF]=]
	SML_MT_font["Arial Narrow"]				= [=[Fonts\ARIALN.TTF]=]
	SML_MT_font["Friz Quadrata TT"]			= [=[Fonts\FRIZQT__.TTF]=]
	SML_MT_font["MoK"]						= [=[Fonts\K_Pagetext.TTF]=]
	SML_MT_font["Morpheus"]					= [=[Fonts\MORPHEUS_CYR.TTF]=]
	SML_MT_font["Nimrod MT"]					= [=[Fonts\NIM_____.ttf]=]
	SML_MT_font["Skurri"]					= [=[Fonts\SKURRI_CYR.TTF]=]
	lib.DefaultMedia.font = "Friz Quadrata TT"
	LOCALE_MASK = lib.LOCALE_BIT_western
	locale_is_western = true
end



-- STATUSBAR
if (not lib.MediaTable.statusbar) then
	lib.MediaTable.statusbar = {}
end

lib.MediaTable.statusbar["UI-TargetFrame"]		= [=[Interface\TargetingFrame\UI-StatusBar]=]
lib.MediaTable.statusbar["UI-CharSkillsBar"]		= [=[Interface\PaperDollInfoFrame\UI-Character-Skills-Bar]=]
lib.MediaTable.statusbar["UI-RaidFrame-Bar"]		= [=[Interface\RaidFrame\Raid-Bar-Hp-Fill]=]
lib.DefaultMedia.statusbar = "Blizzard"



-- SOUND
if (not lib.MediaTable.sound) then
	lib.MediaTable.sound = {}
end

lib.MediaTable.sound["None"]					= [=[Interface\Quiet.ogg]=]	-- Relies on the fact that PlaySound[File] doesn't error on non-existing input.
lib.DefaultMedia.sound = "None"



----------------------------------------------------------------------------------------------------
--	Functions and Utilities
----------------------------------------------------------------------------------------------------

local function rebuildMediaList(mediatype)
	local mtable = mediaTable[mediatype]
	if (not mtable) then return end

	if (not mediaList[mediatype]) then
		mediaList[mediatype] = {}
	end

	local mlist = mediaList[mediatype]

	local i = 0

  -- List can only get larger, so simply overwrite it
	for k in pairs(mtable) do
		i = i + 1
		mlist[i] = k
	end

	table_sort(mlist)
end


function lib:Register(mediatype, key, data, langmask)
	if (type(mediatype) ~= "string") then
		error(MAJOR .. ":Register(mediatype, key, data, langmask) - mediatype must be string, got " .. type(mediatype))
	end

	if (type(key) ~= "string") then
		error(MAJOR .. ":Register(mediatype, key, data, langmask) - key must be string, got " .. type(key))
	end

	mediatype = mediatype:lower()

	if (mediatype == lib.MediaType.FONT  and ((langmask and band(langmask, LOCALE_MASK) == 0) or not (langmask or locale_is_western))) then return false end
	if (not mediaTable[mediatype]) then mediaTable[mediatype] = {} end

	local mtable = mediaTable[mediatype]

	if (mtable[key]) then return false end

	mtable[key] = data

	rebuildMediaList(mediatype)

	self.callbacks:Fire("LibSharedMedia_Registered", mediatype, key)

	return true
end


function lib:Fetch(mediatype, key, noDefault)
	local mtt = mediaTable[mediatype]
	local overridekey = overrideMedia[mediatype]

	local result = mtt and ((overridekey and mtt[overridekey] or mtt[key]) or (not noDefault and defaultMedia[mediatype] and mtt[defaultMedia[mediatype]])) or nil

	return result ~= "" and result or nil
end


function lib:IsValid(mediatype, key)
	return mediaTable[mediatype] and (not key or mediaTable[mediatype][key]) and true or false
end


function lib:HashTable(mediatype)
	return mediaTable[mediatype]
end


function lib:List(mediatype)
	if (not mediaTable[mediatype]) then
		return nil
	end

	if (not mediaList[mediatype]) then
		rebuildMediaList(mediatype)
	end

	return mediaList[mediatype]
end


function lib:GetGlobal(mediatype)
	return overrideMedia[mediatype]
end


function lib:SetGlobal(mediatype, key)
	if (not mediaTable[mediatype]) then
		return false
	end

	overrideMedia[mediatype] = (key and mediaTable[mediatype][key]) and key or nil
	self.callbacks:Fire("LibSharedMedia_SetGlobal", mediatype, overrideMedia[mediatype])

	return true
end


function lib:GetDefault(mediatype)
	return defaultMedia[mediatype]
end


function lib:SetDefault(mediatype, key)
	if (mediaTable[mediatype] and mediaTable[mediatype][key] and not defaultMedia[mediatype]) then
		defaultMedia[mediatype] = key

		return true
	else
		return false
	end
end
