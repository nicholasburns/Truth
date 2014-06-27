local A, C, G, L = select(2, ...):Unpack()

local SetFont

----------------------------------------------------------------------------------------------------
-- :SetFont(fontObject, font, size, style, offsetX, offsetY, shadowAlpha)
-- 	@param fontObject <table(fontObject)> the actual font object to edit
-- 	@param font <string, nil> the new font to set
-- 	@param size <number, nil> the size of the font
-- 	@param style <string, nil> the style e.g "OUTLINE", "OUTLINE"
-- 	@param offsetX <number, nil> horizontal offset of the shadow
-- 	@param offsetY <number, nil> vertical offset of the shadow
-- 	@param shadowAlpha <number, nil> alpha of the shadow
-- 	@return <fontObject>
SetFont = function(fontObject, font, size, style, offsetX, offsetY, shadowAlpha, r, g, b)
	local oldFont, oldSize, oldStyle = fontObject:GetFont()
	local oldoffsetX, oldoffsetY = fontObject:GetShadowOffset()
	if (oldFont == font) and (oldSize == size) and (oldStyle == style) then
		return
	end
	size = size or oldSize
	fontObject:SetFont(font or oldFont, size, style or oldStyle)
	fontObject:SetShadowOffset(offsetX or oldoffsetX or 0, offsetY or oldoffsetY or 0)
	fontObject:SetShadowColor(0, 0, 0, shadowAlpha or 1)
	if (r and g and b) then
		fontObject:SetTextColor(r, g, b)
	end
	return fontObject
end


local EventFrame = CreateFrame('Frame')													-- local f = CreateFrame('Frame')
EventFrame:RegisterEvent('ADDON_LOADED')												-- f:RegisterEvent('ADDON_LOADED')
EventFrame:SetScript('OnEvent', function(self, event, ...)									-- f:SetScript('OnEvent', function()
	self[event](self, ...)
end)


function EventFrame:ADDON_LOADED(addon)
	if (not addon == "Truth") then
		return
	end

	local header	= A.media.font.ptsn_bold
	local text	= A.media.font.ptsn
	local textBold	= A.media.font.ptsn_bold
	local damage	= A.media.font.ptsn_bold
	local pixel	= A.media.font.pixel


	UNIT_NAME_FONT = header
	DAMAGE_TEXT_FONT = pixel -- damage -- this is the damage that is NOT a part of the fct texts
	STANDARD_TEXT_FONT = text

	-- chat frames
	SetFont(ChatFontNormal, text)

	-- tooltips (todo: fix the moneyfonts)
	SetFont(GameTooltipHeader, text, 14, nil, nil, 0.75, -0.75)
	SetFont(Tooltip_Med, text, 14, nil, nil, 0.75, -0.75)
	SetFont(Tooltip_Small, text, 12, nil, nil, 0.75, -0.75)
	SetFont(SystemFont_OutlineThick_WTF, header, 32, "OUTLINE", 2.5, -2.5, 0.5) -- 32px e.g. "Dalaran"

	-- zones
	SetFont(ZoneTextFont, header, 32, "OUTLINE", 2.5, -2.5, 0.5) -- 32px e.g. "Dalaran"
	SetFont(SubZoneTextFont, header, 24, "OUTLINE", 2.5, -2.5, 0.75) --28px e.g. "Krasus' Landing"
	SetFont(PVPInfoTextFont, header, 18, "OUTLINE", 1.5, -1.5, 0.5) -- 18px .... wtf is this?
	SetFont(PVPArenaTextString, header, 18, "OUTLINE", 1.5, -1.5, 0.5) --22px e.g. "Sanctuary"

	-- worldmap
	SetFont(WorldMapFrameAreaLabel, header, 32, "OUTLINE", 2.5, -2.5, 0.5) -- 32px e.g. "Dalaran"
	SetFont(WorldMapFrameAreaDescription, header, 22, "OUTLINE", 2.5, -2.5, 0.5)
	SetFont(WorldMapFrameAreaPetLevels, header, 18, "OUTLINE", 2.5, -2.5, 0.5)

	-- raid warnings
	SetFont(RaidWarningFrameSlot1, header, nil, "OUTLINE", 2.5, -2.5)
	SetFont(RaidWarningFrameSlot2, header, nil, "OUTLINE", 2.5, -2.5)
	SetFont(RaidBossEmoteFrameSlot1, header, nil, "OUTLINE", 2.5, -2.5)
	SetFont(RaidBossEmoteFrameSlot2, header, nil, "OUTLINE", 2.5, -2.5)

	-- error frame (quest updates also) - I used the bold font, yet a less distinct shadow than the raid warnings, as I want these updates to be visible, but not "in your face"
	SetFont(ErrorFont, header, 18, "OUTLINE", 0.75, -0.75, .5)

	-- damage
	SetFont(CombatTextFont, damage, 25, "OUTLINE", 1.5, -1.5, .5) -- the blizzard font is 25, and keeping it this way gave me the smoothest result. except crits, which always suck

	-- get rid of the weird and unreadable quest/mail font
	SetFont(MailFont_Large, header, nil, nil, 0, 0, 0)
	SetFont(MailTextFontNormal, text)
	SetFont(QuestFont, text)
	SetFont(QuestFontHighlight, textBold)
	SetFont(QuestFontNormalSmall, text)
	SetFont(QuestFontLeft, text)
	SetFont(QuestFont_Large, header, nil, nil, 0, 0, 0)
	SetFont(QuestFont_Shadow_Huge, header, nil, nil, nil, 0, 0, 0)
	SetFont(QuestFont_Shadow_Small, header, nil, nil, nil, 0, 0, 0)
	SetFont(QuestFont_Super_Huge, header, nil, nil, nil, 0, 0, 0)

	-- numbers
	SetFont(NumberFontNormal, header, 12)
	SetFont(NumberFontNormalLarge, header, 14)
	SetFont(NumberFontNormalSmallGray, header, 12) -- default hotkey font
  -- SetFont(NumberFont_OutlineThick_Mono_Small, header, 12, "OUTLINE")
  -- SetFont(NumberFont_Outline_Huge, header, 28, "OUTLINE")
  -- SetFont(NumberFont_Outline_Large, header, 14, "OUTLINE")
  -- SetFont(NumberFont_Outline_Med, header, 12, "OUTLINE")
	SetFont(NumberFont_OutlineThick_Mono_Small, header, 12, nil, 1, -1, 0.75)
	SetFont(NumberFont_Outline_Huge, header, 28, "OUTLINE", 0.75, -0.75)
	SetFont(NumberFont_Outline_Large, header, 14, nil, 1, -1, 0.75)
	SetFont(NumberFont_Outline_Med, header, 12, nil, 1, -1, 0.75)

	-- system
	SetFont(FriendsFont_Normal, text)
	SetFont(FriendsFont_Large, textBold)
	SetFont(FriendsFont_Small, text)
	SetFont(FriendsFont_UserText, text)
	SetFont(GameFontNormal, text)
	SetFont(GameFontDisable, text)
	SetFont(GameFontHighlight, text)
	SetFont(NumberFont_Shadow_Med, header)
	SetFont(NumberFont_Shadow_Small, header)
	SetFont(SystemFont_Large, textBold)
	SetFont(SystemFont_Med1, text)
	SetFont(SystemFont_Med3, text)
	SetFont(SystemFont_OutlineThick_Huge2, header, nil, "OUTLINE")
	SetFont(SystemFont_Outline_Small, textBold, nil, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1, header, nil, "OUTLINE")
	SetFont(SystemFont_Shadow_Large, text)
	SetFont(SystemFont_Shadow_Med1, text)
	SetFont(SystemFont_Shadow_Med3, text)
	SetFont(SystemFont_Shadow_Outline_Huge2, textBold, nil, "OUTLINE")
	SetFont(SystemFont_Shadow_Small, text)
	SetFont(SystemFont_Small, text)
	SetFont(SystemFont_Tiny, text, 12)

	SetFont = nil
	self:SetScript('OnEvent', nil)
	self:UnregisterAllEvents()
	self = nil
end




--------------------------------------------------
--	Credits
--------------------------------------------------
--[[	Copyright (c) 2013, Lars "Goldpaw" Norberg
	Web: http://www.friendlydruid.com
	Contact: goldpaw@friendlydruid.com
	All rights reserved
--]]
--------------------------------------------------

