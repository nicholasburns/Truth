local AddOn, Addon = ...

local select = select
local type = type
local unpack = unpack
local ipairs, pairs = ipairs, pairs


----------------------------------------------------------------------------------------------------
--	Module
----------------------------------------------------------------------------------------------------
--[[ local module = {}
	local moduleName = "sm"

	Truth[moduleName] = module					-- Addon[moduleName] = module
--]]

----------------------------------------------------------------------------------------------------
--	Constants
----------------------------------------------------------------------------------------------------

-- LibSharedMedia
local LSM = LibStub and LibStub("LibSharedMedia-3.0") or print('LibStub :', 'nil')
local LSM_LANG_MASK_ALL = 255

----------------------------------------------------------------------------------------------------
-- Private Variables
----------------------------------------------------------------------------------------------------
local backgrounds = {}
local borders = {}
local fonts = {}
local statusbars = {}
local sounds = {}

----------------------------------------------------------------------------------------------------
--	Media API
----------------------------------------------------------------------------------------------------
local function RegisterBackground(name, file)
	if (not name) or (not type(name) == 'string') then return end
	if (not file) or (not type(file) == 'string') then return end
	backgrounds[name] = file
	LSM:Register("background", name, file)
end

local function RegisterBorder(name, file)
	if (not name) or (not type(name) == 'string') then return end
	if (not file) or (not type(file) == 'string') then return end
	borders[name] = file
	LSM:Register("border", name, file)
end

local function RegisterFont(name, file)
	if (not name) or (not type(name) == 'string') then return end
	if (not file) or (not type(file) == 'string') then return end
	fonts[name] = file
	LSM:Register("font", name, file, LSM_LANG_MASK_ALL)
end

local function RegisterStatusbar (name, file)
	if (not name) or (not type(name) == 'string') then return end
	if (not file) or (not type(file) == 'string') then return end
	statusbars[name] = file
	LSM:Register("statusbar", name, file)
end

local function RegisterSound(name, file)
	if (not name) or (not type(name) == 'string') then return end
	if (not file) or (not type(file) == 'string') then return end
	sounds[name] = file
	LSM:Register("sound", name, file)
end


-- Iterators
local function IterateBackgrounds()			return pairs(backgrounds) end
local function IterateBorders()				return pairs(borders) end
local function IterateFonts()					return pairs(fonts) end
local function IterateStatusbars()				return pairs(statusbars) end
local function IterateSounds()				return pairs(sounds) end

----------------------------------------------------------------------------------------------------
--	Event Handlers
----------------------------------------------------------------------------------------------------
local function LSMRegistered(event, mediatype, name)
--~  Called by LSM anytime media is registered

	if (mediatype == "background") then		backgrounds[name] = LSM:Fetch(mediatype, name)
	elseif (mediatype == "border") then		borders[name] = LSM:Fetch(mediatype, name)
	elseif (mediatype == "font") then			fonts[name] = LSM:Fetch(mediatype, name)
	elseif (mediatype == "statusbar") then		statusbars[name] = LSM:Fetch(mediatype, name)
	elseif (mediatype == "sound") then			sounds[name] = LSM:Fetch(mediatype, name)
	end
end

--[[ Register Custom Media
	----------------------
	local function OnVariablesInitialized()
		for name, file in pairs(MSBTProfiles.savedMedia.fonts) do
			RegisterFont(name, file)
		end
		for name, file in pairs(MSBTProfiles.savedMedia.sounds) do
			RegisterSound(name, file)
		end
	end
--]]

----------------------------------------------------------------------------------------------------
--	Initialization / Register Media with LSM
----------------------------------------------------------------------------------------------------
for name, file in pairs(Addon.media.backdrop) do	RegisterBackground(name, file) end
for name, file in pairs(Addon.media.border) do	RegisterBorder(name, file) end
for name, file in pairs(Addon.media.font) do		RegisterFont(name, file) end
for name, file in pairs(Addon.media.statusbar) do	RegisterStatusbar(name, file) end
for name, file in pairs(Addon.media.sound) do	RegisterSound(name, file) end


-- Register available media with our addon
for _, name in pairs(LSM:List("background")) do	backgrounds[name] = LSM:Fetch("background", name) end
for _, name in pairs(LSM:List("border")) do		borders[name] = LSM:Fetch("border", name) end
for _, name in pairs(LSM:List("font")) do		fonts[name] = LSM:Fetch("font", name) end
for _, name in pairs(LSM:List("statusbar")) do	statusbars[name] = LSM:Fetch("statusbar", name) end
for _, name in pairs(LSM:List("sound")) do		sounds[name] = LSM:Fetch("sound", name) end


-- Always stay Synchronized with LSM by registering a Callback
LSM.RegisterCallback("TruthSM", "LibSharedMedia_Registered", LSMRegistered)


----------------------------------------------------------------------------------------------------

-- Module Interface

local module = {}
local moduleName = "sm"
Addon[moduleName] = module											-- Truth[moduleName] = module


--
module.backgrounds 			= backgrounds								-- Protected Variables
module.borders 			= borders
module.fonts 				= fonts
module.statusbars 			= statusbars
module.sounds 				= sounds
--
module.RegisterBackground	= RegisterBackground							-- Protected Functions
module.RegisterBorder		= RegisterBorder
module.RegisterFont			= RegisterFont
module.RegisterStatusbar		= RegisterStatusbar
module.RegisterSound		= RegisterSound
--
module.IterateBackgrounds	= IterateBackgrounds
module.IterateBorders		= IterateBorders
module.IterateFonts			= IterateFonts
module.IterateStatusbars		= IterateStatusbars
module.IterateSounds		= IterateSounds
--
-- module.OnVariablesInitialized	= OnVariablesInitialized
