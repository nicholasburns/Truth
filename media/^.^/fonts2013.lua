local T, C, L, G, F, _ = unpack(select(2, ...))
if (not F.fonts) then return end


local LSM = LibStub and LibStub:GetLibrary('LibSharedMedia-3.0', true)


local function InitializeFonts()
	for k, v in pairs({
		Normal			= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=],
		Name				= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=],
		Number			= [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=],
		Header			= [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=],
		Chat				= [=[Interface\AddOns\Truth\media\fonts\Continuum.ttf]=],
		Combat			= [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=],
		Blank			= [=[Interface\AddOns\Truth\media\fonts\!nvisible.ttf]=],
		--
		Calibri			= [=[Interface\AddOns\Truth\media\fonts\Calibri.ttf]=],
		Continuum			= [=[Interface\AddOns\Truth\media\fonts\Continuum.ttf]=],
		Enigmatic			= [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=],
		Hooge			= [=[Interface\AddOns\Truth\media\fonts\Hooge.ttf]=],
		LibSans			= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=],
		Marke			= [=[Interface\AddOns\Truth\media\fonts\Marke.ttf]=],
		Visitor2			= [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=],
		Zekton			= [=[Interface\AddOns\Truth\media\fonts\Zekton.ttf]=],
	}) do
		LSM:Register(LSM.MediaType.FONT, k, v, 128)
	end
end

local function printfonts()
	for k, v in pairs(LSM.MediaTable.FONT) do
		print(k .. ' = ' .. LSM:Fetch('font', k))
	end
end

local e = CreateFrame('Frame')
e:RegisterEvent('PLAYER_ENTERING_WORLD')
e:SetScript('OnEvent', function(self, event, addon)
	self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	InitializeFonts()
end)

--============================================================================--
--[[		SetFont(FontInstance, font, size, [flags])
@arg		fontfile	String - path to font file
			FRIZQT__.TTF	- PlayerNames & UI-Text (mainly)
			ARIALN.TTF  	- ChatFrames, ActionButton-Number Strings, etc
			SKURRI.ttf  	- CombatText, PLayerFrame & PetFrame, Incoming Damage/Parry/etc Indicators
			MORPHEUS.ttf	- QuestTitle Headers, Mail, & Readable in-game objects
		fontsize	Number - size in points
		flags	String - any comma-delimited combination of 'OUTLINE', 'THICKOUTLINE' & 'MONOCHROME'
@ret		isValid 	  1nil - 1 if valid fontfile; otherwise nil
--]]
local function SetFont(Object, Font, Size, Flag, ...)
	local isValid = Object:SetFont(Font, Size, Flag)
	if (not isValid) then _G.print('<fonts> Invalid fontfile for: '.. Object:GetName()) end
end
--============================================================================--

function T.InstallFonts()
	if (IsAddOnLoaded('tekticles')) then return end

 	local Normal 	= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=]		-- 'Fonts\FRIZQT__.ttf'
	local Name  	= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=]		-- 'Fonts\FRIZQT__.ttf'
	local Number 	= [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=]	-- 'Fonts\ARIALN.ttf'
	local Header 	= [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=]	-- 'Fonts\MORPHEUS.ttf'
	local Chat  	= [=[Interface\AddOns\Truth\media\fonts\Contiuum.ttf]=]
	local Combat 	= [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=]	-- 'Fonts\SKURRI.ttf'
	local Blank  	= [=[Interface\AddOns\Truth\media\fonts\!nvisible.ttf]=]

	local OUTLINE 					= 'OUTLINE'
	local THICKOUTLINE 				= 'THICKOUTLINE'
	local MONOCHROME 				= 'MONOCHROME'
	local MONOCHROME_OUTLINE 		= 'MONOCHROME, OUTLINE'
	local MONOCHROME_THICKOUTLINE		= 'MONOCHROME, THICKOUTLINE'

  -- Achievement
	SetFont(AchievementFont_Small, Normal, 10)
  -- Chat
	SetFont(ChatBubbleFont, Normal, 13)
  -- Combat
	SetFont(CombatTextFont, Combat, 90, OUTLINE)
  -- Destiny
	SetFont(DestinyFontLarge, Header, 18)
	SetFont(DestinyFontHuge, Header, 32)
	SetFont(CoreAbilityFont, Header, 32)
  -- Friends
	SetFont(FriendsFont_Normal, Normal, 12)
	SetFont(FriendsFont_Small, Normal, 10)
	SetFont(FriendsFont_Large, Normal, 14)
	SetFont(FriendsFont_UserText, Number, 11)
  -- Game
	SetFont(GameFontNormalMed3, Normal, 14)
	SetFont(GameFont_Gigantic, Normal, 32)
  -- Invoice
	SetFont(InvoiceFont_Med, Normal, 12)
	SetFont(InvoiceFont_Small, Normal, 10)
  -- Mail
	SetFont(MailFont_Large, Header, 15)
  -- Number
	SetFont(NumberFont_Shadow_Small, Number, 12)
	SetFont(NumberFont_OutlineThick_Mono_Small, Number, 12, MONOCHROME_THICKOUTLINE)
	SetFont(NumberFont_Shadow_Med, Number, 14)
	SetFont(NumberFont_Normal_Med, Number, 14)
	SetFont(NumberFont_Outline_Med, Number, 14, OUTLINE)
	SetFont(NumberFont_Outline_Large, Number, 16, OUTLINE)
	SetFont(NumberFont_Outline_Huge, Combat, 30, OUTLINE)
  -- PVP
	SetFont(PVPInfoTextString, Normal, 22, MONOCHROME_THICKOUTLINE)
	SetFont(PVPArenaTextString, Normal, 22, MONOCHROME_THICKOUTLINE)
  -- Quest
	SetFont(QuestFont, Normal, 13)
	SetFont(QuestFont_Large, Header, 15)
	SetFont(QuestFont_Shadow_Small, Header, 14)
	SetFont(QuestFont_Shadow_Huge, Header, 18)
	SetFont(QuestFont_Super_Huge, Header, 24)
  -- Reputation
	SetFont(ReputationDetailFont, Normal, 10)
  -- Spell
	SetFont(SpellFont_Small, Normal, 10)
  -- System
	SetFont(SystemFont_Tiny, Normal, 9)
	SetFont(SystemFont_Small, Normal, 10)
	SetFont(SystemFont_Outline_Small, Normal, 10, OUTLINE)
	SetFont(SystemFont_Outline, Normal, 13, OUTLINE)
	SetFont(SystemFont_Shadow_Small, Normal, 10)
	SetFont(SystemFont_InverseShadow_Small, Normal, 10)
	SetFont(SystemFont_Med1, Normal, 12)
	SetFont(SystemFont_Shadow_Med1, Normal, 12)
	SetFont(SystemFont_Shadow_Med1_Outline, Normal, 10, OUTLINE)
	SetFont(SystemFont_Med2, Normal, 13)
	SetFont(SystemFont_Shadow_Med2, Normal, 13)
	SetFont(SystemFont_Med3, Normal, 14)
	SetFont(SystemFont_Shadow_Med3, Normal, 14)
	SetFont(SystemFont_Large, Normal, 16)
	SetFont(SystemFont_Shadow_Large, Normal, 16)
	SetFont(SystemFont_Shadow_Large_Outline, Normal, 16, OUTLINE)
	SetFont(SystemFont_Huge1, Normal, 20)
	SetFont(SystemFont_Shadow_Huge1, Normal, 20) 						-- RaidWarning & BossEmote
	SetFont(SystemFont_OutlineThick_Huge2, Normal, 22, THICKOUTLINE)
	SetFont(SystemFont_Shadow_Outline_Huge2, Normal, 22, OUTLINE)
	SetFont(SystemFont_Shadow_Huge3, Normal, 25)
	SetFont(SystemFont_OutlineThick_Huge4, Normal, 26, THICKOUTLINE)
	SetFont(SystemFont_OutlineThick_WTF, Normal, 32, THICKOUTLINE)
  -- Tooltip
	SetFont(Tooltip_Small, Normal, 10)
	SetFont(Tooltip_Med, Normal, 12)
	SetFont(GameTooltipHeader, Normal, 14)
  -- Zone
	SetFont(ZoneTextString, Normal, 32, MONOCHROME_THICKOUTLINE)
	SetFont(SubZoneTextString, Normal, 26, MONOCHROME_THICKOUTLINE)
  -- Derived fonts
	SetFont(BossEmoteNormalHuge, Normal, 27, 'THICKOUTLINE')
	SetFont(ErrorFont, Normal, 16)
	SetFont(QuestFontNormalSmall, Normal, 13, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont, Normal, 31, 'THICKOUTLINE', nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(HelpFrameKnowledgebaseNavBarHomeButtonText, Normal, 13, nil, nil, nil, nil, 0, 0, 0, 1, -1)

	_G.STANDARD_TEXT_FONT 	= Normal
	_G.UNIT_NAME_FONT 		= Combat
	_G.NAMEPLATE_FONT 		= Name
	_G.DAMAGE_TEXT_FONT 	= Combat
	_G.CHAT_FONT_HEIGHTS	= { 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34 }

	for i = 1, 5 do _G['ChatFrame'.. i]:SetFont(Chat, 10) end

	-- print('<fonts> Loaded Successfully')
end

_G['SLASH_INSTALLFONTS1'] = '/ifonts'
_G.SlashCmdList['INSTALLFONTS'] = function() InstallFonts() end

_G['SLASH_PRINTFONTS1'] = '/pfonts'
_G.SlashCmdList['PRINTFONTS'] = function() printfonts() end


-- Damage Font
local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:SetScript('OnEvent', function(self, event, addon)
	if (addon == 'Blizzard_CombatLog') then self:UnregisterEvent('ADDON_LOADED')
		T.InstallFonts()
		_G.DAMAGE_TEXT_FONT = [=[Interface\AddOns\Truth\media\fonts\unused\SKURRI.ttf]=]
		-- _G.print('<fonts>\n DAMAGE_TEXT_FONT = ' .. _G.DAMAGE_TEXT_FONT)
	end
end)


--============================================================================--

--[[
	WoW only supports .ttf fonts & not all .ttf fonts seem work properly

			[]{}()¿ﬂ–¡È˙ÌÛ^%$£"!_+=@~<*&#>/|\;:

	Use these characters to check your font's compatibility
--]]

--============================================================================--

--[[
	FRIZQT__.ttf - PlayerNames & UI-Text (mainly)
	ARIALN.ttf   - ChatFrames, ActionButton-Number Strings, etc
	SKURRI.ttf   - CombatText, PLayerFrame & PetFrame Incoming Damage/Parry/etc Indicators
	MORPHEUS.ttf - QuestTitle Headers, Mail, & Readable in-game objects
--]]

--============================================================================--
--[[
local Fontlist = {
	GameFontNormal,
	GameFontHighlight,
	GameFontDisable,
	GameFontNormalSmall,
	GameFontHighlightExtraSmall,
	GameFontHighlightMedium,
	GameFontNormalLarge,
	GameFontNormalHuge,
	GameFont_Gigantic,
	BossEmoteNormalHuge,
	NumberFontNormal,
	NumberFontNormalSmall,
	NumberFontNormalLarge,
	NumberFontNormalHuge,
	ChatFontNormal,
	ChatFontSmall,
	DialogButtonNormalText,
	ZoneTextFont,
	SubZoneTextFont,
	PVPInfoTextFont,
	QuestFont_Super_Huge,
	QuestFont_Shadow_Small,
	ErrorFont,
	TextStatusBarText,
	CombatLogFont,
	GameTooltipText,
	GameTooltipTextSmall,
	GameTooltipHeaderText,
	WorldMapTextFont,
	CombatTextFont,
	MovieSubtitleFont,
	AchievementPointsFont,
	AchievementPointsFontSmall,
	AchievementDescriptionFont,
	AchievementCriteriaFont,
	AchievementDateFont,
	ReputationDetailFont,
	QuestTitleFont,
	QuestFont,
	QuestFontNormalSmall,
	QuestFontHighlight,
	ItemTextFontNormal,
	MailTextFontNormal,
	SubSpellFont,
	InvoiceTextFontNormal,
	InvoiceTextFontSmall,
}
--]]
--============================================================================--

--	Register @ LibSharedMedia-3.0

--============================================================================--

--[[	local LSM = LibStub and LibStub:GetLibrary('LibSharedMedia-3.0', true)
	local LOCALE_MASK = 128
	if (not LSM) then return end

	LSM:Register(LSM.MediaType.FONT, 'Calibri',		F.calibri, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Continuum', 	F.continuum, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Enigmatic', 	F.enigmatic, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Frucade', 		F.frucade, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Homespun', 	F.homespun, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Hooge', 		F.hooge, 		LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'LibSans', 		F.libsans, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'MarkeEigenbau', F.marke, 		LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Visitor1', 	F.visitor1, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Visitor2', 	F.visitor2, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Zekton', 		F.zekton, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Normal', 	F.libsans, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Number', 	F.visitor2, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Combat', 	F.visitor1, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Header', 	F.zekton, 	LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Name', 	F.hooge, 		LOCALE_MASK)
	LSM:Register(LSM.MediaType.FONT, 'Blank', 	F.invisible, 	LOCALE_MASK)
--]]


-- local Normal = [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=]	-- 'Fonts\FRIZQT__.ttf'
-- local Number = [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=]	-- 'Fonts\ARIALN.ttf'
-- local Combat = [=[Interface\AddOns\Truth\media\fonts\Visitor1.ttf]=]	-- 'Fonts\SKURRI.ttf'
-- local Header = [=[Interface\AddOns\Truth\media\fonts\Zekton.ttf]=]		-- 'Fonts\MORPHEUS.ttf'
-- local Name   = [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=]	-- 'Fonts\FRIZQT__.ttf'
-- local Blank  = [=[Interface\AddOns\Truth\media\fonts\Invisible.ttf]=]

-- F.calibri 	= [=[Interface\AddOns\Truth\media\fonts\Calibri.ttf]=]		-- Normal
-- F.continuum = [=[Interface\AddOns\Truth\media\fonts\Continuum.ttf]=]	-- Monospace
-- F.enigmatic = [=[Interface\AddOns\Truth\media\fonts\Enigmatic.ttf]=]	-- Monospace
-- F.frucade	= [=[Interface\AddOns\Truth\media\fonts\Frucade.ttf]=]		-- Pixel
-- F.homespun 	= [=[Interface\AddOns\Truth\media\fonts\Homespun.ttf]=]	-- Pixel
-- F.hooge 	= [=[Interface\AddOns\Truth\media\fonts\Hooge.ttf]=]		-- Pixel
-- F.libsans 	= [=[Interface\AddOns\Truth\media\fonts\LibSans.ttf]=]		-- Normal
-- F.marke	= [=[Interface\AddOns\Truth\media\fonts\MarkeEigenbau.ttf]=]-- Pixel
-- F.visitor1 	= [=[Interface\AddOns\Truth\media\fonts\Visitor1.ttf]=]	-- Pixel
-- F.visitor2 	= [=[Interface\AddOns\Truth\media\fonts\Visitor2.ttf]=]	-- Pixel
-- F.zekton 	= [=[Interface\AddOns\Truth\media\fonts\Zekton.ttf]=]		-- Normal

--============================================================================--

-- Backup

--============================================================================--

--[[
	-- Editbox
	local _, editBoxFontSize, _, _, _, _, _, _, _, _ = GetChatWindowInfo(1)

	-- Chatmenu
	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS = {12, 13, 14, 15}

	-- Monochrome
	if (self.db.general.font:lower():find('pixel')) then
		MONOCHROME = 'MONOCHROME'
	end
--]]

--============================================================================--

--	Revert

--============================================================================--

--[[
	-- Achievement
	SetFont(AchievementFont_Small, Normal, 10)
	-- Chat
	SetFont(ChatBubbleFont, Normal, 13)
	-- Destiny
	SetFont(DestinyFontLarge, Header, 18)
	SetFont(DestinyFontHuge, Header, 32)
	SetFont(CoreAbilityFont, Header, 32)
	-- Friends
	SetFont(FriendsFont_Normal, Normal, 12)
	SetFont(FriendsFont_Small, Normal, 10)
	SetFont(FriendsFont_Large, Normal, 14)
	SetFont(FriendsFont_UserText, Number, 11)
	-- Game
	SetFont(GameFont_Gigantic, Normal, 32)
	-- Invoice
	SetFont(InvoiceFont_Med, Normal, 12)
	SetFont(InvoiceFont_Small, Normal, 10)
	-- Mail
	SetFont(MailFont_Large, Header, 15)
	-- Number
	SetFont(NumberFont_Shadow_Small, Number, 12)
	SetFont(NumberFont_OutlineThick_Mono_Small, Number, 12, MONOCHROME_THICKOUTLINE)
	SetFont(NumberFont_Shadow_Med, Number, 14)
	SetFont(NumberFont_Normal_Med, Number, 14)
	SetFont(NumberFont_Outline_Med, Number, 14, OUTLINE)
	SetFont(NumberFont_Outline_Large, Number, 16, OUTLINE)
	SetFont(NumberFont_Outline_Huge, Combat, 30, OUTLINE)
	-- Quest
	SetFont(QuestFont, Normal, 13)
	SetFont(QuestFont_Large, Header, 15)
	SetFont(QuestFont_Shadow_Small, Header, 14)
	SetFont(QuestFont_Shadow_Huge, Header, 18)
	SetFont(QuestFont_Super_Huge, Header, 24)
	-- Reputation
	SetFont(ReputationDetailFont, Normal, 10)
	-- Spell
	SetFont(SpellFont_Small, Normal, 10)
	-- System
	SetFont(SystemFont_Tiny, Normal, 9)
	SetFont(SystemFont_Small, Normal, 10)
	SetFont(SystemFont_Outline_Small, Normal, 10, OUTLINE)
	SetFont(SystemFont_Outline, Normal, 13, OUTLINE)
	SetFont(SystemFont_Shadow_Small, Normal, 10)
	SetFont(SystemFont_InverseShadow_Small, Normal, 10)
	SetFont(SystemFont_Med1, Normal, 12)
	SetFont(SystemFont_Shadow_Med1, Normal, 12)
	SetFont(SystemFont_Shadow_Med1_Outline, Normal, 10, OUTLINE)
	SetFont(SystemFont_Med2, Normal, 13)
	SetFont(SystemFont_Shadow_Med2, Normal, 13)
	SetFont(SystemFont_Med3, Normal, 14)
	SetFont(SystemFont_Shadow_Med3, Normal, 14)
	SetFont(SystemFont_Large, Normal, 16)
	SetFont(SystemFont_Shadow_Large, Normal, 16)
	SetFont(SystemFont_Shadow_Large_Outline, Normal, 16, OUTLINE)
	SetFont(SystemFont_Huge1, Normal, 20)
	SetFont(SystemFont_Shadow_Huge1, Normal, 20) 					-- RaidWarning & BossEmote
	SetFont(SystemFont_OutlineThick_Huge2, Normal, 22, THICKOUTLINE)
	SetFont(SystemFont_Shadow_Outline_Huge2, Normal, 22, OUTLINE)
	SetFont(SystemFont_Shadow_Huge3, Normal, 25)
	SetFont(SystemFont_OutlineThick_Huge4, Normal, 26, THICKOUTLINE)
	SetFont(SystemFont_OutlineThick_WTF, Normal, 32, THICKOUTLINE)
	-- Tooltip
	SetFont(Tooltip_Small, Normal, 10)
	SetFont(Tooltip_Med, Normal, 12)
	SetFont(GameTooltipHeader, Normal, 14)
	--============================================================================--
	-- FontStyles.xml
	--============================================================================--
	-- Game
	SetFont(GameFontNormalMed3, Normal, 14)
	-- PVP
	SetFont(PVPInfoTextString, Normal, 22, MONOCHROME_THICKOUTLINE)
	SetFont(PVPArenaTextString, Normal, 22, MONOCHROME_THICKOUTLINE)
	-- SCT
	SetFont(CombatTextFont, Blank, 90, OUTLINE) -- 25 -- Size just here to increase the font quality
	-- Zone
	SetFont(ZoneTextString, Normal, 32, MONOCHROME_THICKOUTLINE)
	SetFont(SubZoneTextString, Normal, 26, MONOCHROME_THICKOUTLINE)
--]]

--============================================================================--

--	Revert (Extended Version)

--============================================================================--

--[[
	-- Achievement
	SetFont(AchievementFont_Small, Normal,	10)
	-- Chat
	SetFont(ChatBubbleFont, Normal,	13)
	-- Destiny
	SetFont(DestinyFontLarge, Header,	18,	 	 nil, {.1,.1,.1})
	SetFont(DestinyFontHuge, Header,	32,	 	 nil, {.1,.1,.1})
	SetFont(CoreAbilityFont, Header,	32,	 	 nil, {.1,.1,.1})
	-- Friends
	SetFont(FriendsFont_Normal, Normal, 12,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(FriendsFont_Small, Normal,	10,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(FriendsFont_Large, Normal,	14,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(FriendsFont_UserText, Number,	11,		 nil,	  nil,     1,    0,    0,    0)
	-- Game
	SetFont(GameFont_Gigantic, Normal,	32,		 nil, {1,.8, 0},     1,    0,    0,    0)
	-- Invoice
	SetFont(InvoiceFont_Med, Normal,	12)
	SetFont(InvoiceFont_Small, Normal,	10)
	-- Mail
	SetFont(MailFont_Large, Header,	15)
	-- Number
	SetFont(NumberFont_Shadow_Small, Number,	12,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(NumberFont_OutlineThick_Mono_Small, Number,	12,    "MONOCHROME, THICK")
	SetFont(NumberFont_Shadow_Med, Number,	14,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(NumberFont_Normal_Med, Number,	14)
	SetFont(NumberFont_Outline_Med, Number,	14,	"OUTLINE")
	SetFont(NumberFont_Outline_Large, Number,	16,	"OUTLINE")
	SetFont(NumberFont_Outline_Huge, Combat,	30,	"OUTLINE")
	-- Quest
	SetFont(QuestFont, Normal, 	13)
	SetFont(QuestFont_Large, Header,	15)
	SetFont(QuestFont_Shadow_Small, Header,	14,	 	 nil,	  nil,     1,  0.5, 0.35, 0.05)
	SetFont(QuestFont_Shadow_Huge, Header,	18,		 nil,	  nil,     1,  0.5, 0.35, 0.05)
	SetFont(QuestFont_Super_Huge, Header,	24,	 	 nil, { 1,.8, 0})
	-- Reputation
	SetFont(ReputationDetailFont, Normal,	10,		 nil, {1, 1, 1},     1,    0,    0,    0)
	-- Spell
	SetFont(SpellFont_Small, Normal,	10)
	-- System
	SetFont(SystemFont_Tiny, Normal,	 9)
	SetFont(SystemFont_Small, Normal,	10)
	SetFont(SystemFont_Outline_Small, Normal,	10,	"OUTLINE")
	SetFont(SystemFont_Outline, Normal,	13,	"OUTLINE")
	SetFont(SystemFont_Shadow_Small, Normal,	10,	 	 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_InverseShadow_Small, Normal,	10,	 	 nil,	  nil,     1,  0.4,  0.4,  0.4, 0.75)
	SetFont(SystemFont_Med1, Normal,	12)
	SetFont(SystemFont_Shadow_Med1, Normal,	12,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Shadow_Med1_Outline, Normal,	10,	"OUTLINE",	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Med2, Normal,	13)
	SetFont(SystemFont_Shadow_Med2, Normal,	13,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Med3, Normal,	14)
	SetFont(SystemFont_Shadow_Med3, Normal,	14,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Large, Normal,	16)
	SetFont(SystemFont_Shadow_Large, Normal,	16,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Shadow_Large_Outline, Normal,	16,	"OUTLINE",	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_Huge1, Normal,	20)
	SetFont(SystemFont_Shadow_Huge1, Normal,	20,		 nil,	  nil,     1,    0,    0,    0) -- RaidWarning & BossEmote
	SetFont(SystemFont_OutlineThick_Huge2, Normal,	22,	  "THICK")
	SetFont(SystemFont_Shadow_Outline_Huge2, Normal,	22,	"OUTLINE",	  nil,     2,    0,    0,    0)
	SetFont(SystemFont_Shadow_Huge3, Normal,	25,		 nil,	  nil,     1,    0,    0,    0)
	SetFont(SystemFont_OutlineThick_Huge4, Normal,	26,	  "THICK")
	SetFont(SystemFont_OutlineThick_WTF, Normal,	32,	  "THICK")
	-- Tooltip
	SetFont(Tooltip_Small, Normal,	10)
	SetFont(Tooltip_Med, Normal,	12)
	SetFont(GameTooltipHeader, Normal,	14)
	--============================================================================--

	--	FontStyles.xml

	--============================================================================--
	-- Game
	SetFont(GameFontNormalMed3, Normal,	14)
	-- PVP
	SetFont(PVPInfoTextString, Normal, 	22, 	"THICK, MONOCHROME")
	SetFont(PVPArenaTextString, Normal, 	22, 	"THICK, MONOCHROME")
	-- SCT
	SetFont(CombatTextFont, Blank,	90, 	"OUTLINE",	  nil,     1,    0,    0,    0) -- 25 -- Size just here to increase the font quality
	-- Zone
	SetFont(ZoneTextString, Normal,	32, 	"THICK, MONOCHROME")
	SetFont(SubZoneTextString, Normal,   26, 	"THICK, MONOCHROME")
--]]

--============================================================================--

--	Cached Fonts (fonts.xml)

--============================================================================--

--[[
-- Fonts.xml
	local SystemFont_Tiny = SystemFont_Tiny
	local SystemFont_Small = SystemFont_Small
	local SystemFont_Outline_Small = SystemFont_Outline_Small
	local SystemFont_Outline = SystemFont_Outline
	local SystemFont_Shadow_Small = SystemFont_Shadow_Small
	local SystemFont_InverseShadow_Small = SystemFont_InverseShadow_Small
	local SystemFont_Med1 = SystemFont_Med1
	local SystemFont_Shadow_Med1 = SystemFont_Shadow_Med1
	local SystemFont_Shadow_Med1_Outline = SystemFont_Shadow_Med1_Outline
	local SystemFont_Med2 = SystemFont_Med2
	local SystemFont_Shadow_Med2 = SystemFont_Shadow_Med2
	local SystemFont_Med3 = SystemFont_Med3
	local SystemFont_Shadow_Med3 = SystemFont_Shadow_Med3
	local SystemFont_Large = SystemFont_Large
	local SystemFont_Shadow_Large = SystemFont_Shadow_Large
	local SystemFont_Shadow_Large_Outline = SystemFont_Shadow_Large_Outline
	local SystemFont_Huge1 = SystemFont_Huge1
	local SystemFont_Shadow_Huge1 = SystemFont_Shadow_Huge1
	local SystemFont_OutlineThick_Huge2 = SystemFont_OutlineThick_Huge2
	local SystemFont_Shadow_Outline_Huge2 = SystemFont_Shadow_Outline_Huge2
	local SystemFont_Shadow_Huge3 = SystemFont_Shadow_Huge3
	local SystemFont_OutlineThick_Huge4 = SystemFont_OutlineThick_Huge4
	local SystemFont_OutlineThick_WTF = SystemFont_OutlineThick_WTF
	local NumberFont_Shadow_Small = NumberFont_Shadow_Small
	local NumberFont_OutlineThick_Mono_SmallNumberFont_OutlineThick_Mono_Small
	local NumberFont_Shadow_Med = NumberFont_Shadow_Med
	local NumberFont_Normal_Med = NumberFont_Normal_Med
	local NumberFont_Outline_Med = NumberFont_Outline_Med
	local NumberFont_Outline_Large = NumberFont_Outline_Large
	local NumberFont_Outline_Huge = NumberFont_Outline_Huge
	local QuestFont_Large = QuestFont_Large
	local QuestFont_Shadow_Huge = QuestFont_Shadow_Huge
	local QuestFont_Super_Huge = QuestFont_Super_Huge
	local DestinyFontLarge = DestinyFontLarge
	local CoreAbilityFont = CoreAbilityFont
	local DestinyFontHuge = DestinyFontHuge
	local QuestFont_Shadow_Small = QuestFont_Shadow_Small
	local GameTooltipHeader = GameTooltipHeader
	local MailFont_Large = MailFont_Large
	local SpellFont_Small = SpellFont_Small
	local InvoiceFont_Med = InvoiceFont_Med
	local InvoiceFont_Small = InvoiceFont_Small
	local Tooltip_Med = Tooltip_Med
	local Tooltip_Small = Tooltip_Small
	local AchievementFont_Small = AchievementFont_Small
	local ReputationDetailFont = ReputationDetailFont
	local FriendsFont_Normal = FriendsFont_Normal
	local FriendsFont_Small = FriendsFont_Small
	local FriendsFont_Large = FriendsFont_Large
	local FriendsFont_UserText = FriendsFont_UserText
	local GameFont_Gigantic = GameFont_Gigantic
	local ChatBubbleFont = ChatBubbleFont
--]]