local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Tab"]["Enable"]) then
	return
end


local Colorize, ColorizeTab, OnEvent


do
	Colorize = function(self)
		if (self:IsMouseOver()) then
			self:GetFontString():SetTextColor(0, 2/3, 1)
		elseif (self.alerting) then
			self:GetFontString():SetTextColor(1, 0, 0)
		elseif (self:GetID() == SELECTED_CHAT_FRAME:GetID()) then
			self:GetFontString():SetTextColor(1, 1, 1)
		else
			self:GetFontString():SetTextColor(1/2, 1/2, 1/2)
		end
	end


	ColorizeTab = function(self)
		Colorize(_G[self:GetName() .. "Tab"])
	end


	OnEvent = function(self)
		for i = 1, (G.NUM_CHAT_FRAMES) do
			local Tab = _G[("ChatFrame%dTab"):format(i)]

			Tab.leftTexture:SetTexture(nil)
			Tab.middleTexture:SetTexture(nil)
			Tab.rightTexture:SetTexture(nil)
			Tab.leftHighlightTexture:SetTexture(nil)		-- Highlight
			Tab.middleHighlightTexture:SetTexture(nil)
			Tab.rightHighlightTexture:SetTexture(nil)
			Tab.leftSelectedTexture:SetTexture(nil)		-- Selected
			Tab.middleSelectedTexture:SetTexture(nil)
			Tab.rightSelectedTexture:SetTexture(nil)
			Tab.glow:SetTexture(nil)					-- Glow
		  -- Tab.conversationIcon:SetTexture(nil)

			Tab:SetAlpha(0)

			Tab:HookScript("OnEnter", Colorize)
			Tab:HookScript("OnLeave", Colorize)

			Colorize(Tab)
		end

		CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA	= 0.8
		CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA	= 0.8
		CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA	= 1
		CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA	= 1

		hooksecurefunc("FCFTab_UpdateColors", Colorize)
		hooksecurefunc("FCF_StartAlertFlash", ColorizeTab)
		hooksecurefunc("FCF_FadeOutChatFrame", ColorizeTab)

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', OnEvent)
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Set Font

	local DEFAULT_TAB_FONT = C["Chat"]["Tab"]["Font"]
	local DEFAULT_SHADOW_OFFSET = DEFAULT_TAB_FONT[4] and 1 or 0

	local TabFontString = Tab:GetFontString()
	TabFontString:SetFont(DEFAULT_TAB_FONT[1], DEFAULT_TAB_FONT[2], DEFAULT_TAB_FONT[3])
	TabFontString:SetShadowOffset(DEFAULT_SHADOW_OFFSET, -DEFAULT_SHADOW_OFFSET)

--]]

--[[	Texture Nuke

	_G[format("ChatFrame%sTabLeft", i)]:Kill()
	_G[format("ChatFrame%sTabMiddle", i)]:Kill()
	_G[format("ChatFrame%sTabRight", i)]:Kill()

	_G[format("ChatFrame%sTabHighlightLeft", i)]:Kill()
	_G[format("ChatFrame%sTabHighlightMiddle", i)]:Kill()
	_G[format("ChatFrame%sTabHighlightRight", i)]:Kill()

	_G[format("ChatFrame%sTabSelectedLeft", i)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", i)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", i)]:Kill()
--]]


--------------------------------------------------
--	Credits
--------------------------------------------------
--	Gibberish by p3lim
--------------------------------------------------

