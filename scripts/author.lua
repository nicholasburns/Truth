local A, C, G, L = select(2, ...):Unpack()








--------------------------------------------------
-- Dropdown Backdrops (skin)
--------------------------------------------------
local Backdrops = {
	DropDownList1Backdrop,
	DropDownList1MenuBackdrop,
	DropDownList2Backdrop,
	DropDownList2MenuBackdrop,
}
for _, backdrop in ipairs(Backdrops) do
	backdrop:SetBackdrop(nil)
	backdrop:Template("TRANSPARENT")
--	backdrop:SetScale(1)					--	Testing this Code [ 2014.05.04 ]
end

--------------------------------------------------
--	_Dev
--------------------------------------------------
do
	if (IsAddOnLoaded("_Dev")) then
		_DevOptions.Stats.Enabled = false
	end
end

--------------------------------------------------
--	RightBars Positioning
--------------------------------------------------
do
	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self)
		MultiBarRightButton1:Point('RIGHT', UIParent, 0, 200)
		MultiBarLeftButton1:Point('RIGHT', MultiBarRightButton1, 'LEFT', -6, 0)
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
end

--------------------------------------------------
--	WatchFrame Nuke
--------------------------------------------------
do
	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self, event, addon)
--
		if (IsInInstance()) then
			WatchFrameCollapseExpandButton:Click()
		end
		if (not InCombatLockdown()) then						-- WatchFrame: collapse in world (hide by default)
			WatchFrameCollapseExpandButton:Click()
		end
--]]
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
end

--------------------------------------------------
--	Spell Overlay Strata
--------------------------------------------------
do
	SpellActivationOverlayFrame:SetFrameStrata("BACKGROUND")
end

--------------------------------------------------
--	Force other warning
--------------------------------------------------
do
	local f = CreateFrame('Frame')
	f:RegisterEvent("PARTY_INVITE_REQUEST")
	f:RegisterEvent("CONFIRM_SUMMON")
	f:SetScript('OnEvent', function(self, event)
		PlaySound("ReadyCheck", "Master")
	end)
end

--------------------------------------------------
--	Delete Replace Enchant popup
--------------------------------------------------
do
	local f = CreateFrame('Frame')
	f:RegisterEvent("REPLACE_ENCHANT")
	f:SetScript('OnEvent', function(self, event)
		ReplaceEnchant()
		StaticPopup_Hide("REPLACE_ENCHANT")
	end)
end

--------------------------------------------------
--	Hide character controls
--------------------------------------------------
-- CharacterModelFrameControlFrame:HookScript("OnShow", function(self) self:Hide() end)
-- DressUpModelControlFrame:HookScript("OnShow", function(self) self:Hide() end)
-- SideDressUpModelControlFrame:HookScript("OnShow", function(self) self:Hide() end)

--------------------------------------------------
--	Hide subzone text
--------------------------------------------------
-- SubZoneTextFrame:SetScript("OnShow", function() SubZoneTextFrame:Hide() end)


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[	TexBrowser

	do
		local IsAddOnLoaded, LoadAddOn = IsAddOnLoaded, LoadAddOn

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')
		f:SetScript('OnEvent', function(self, event, addon)
			if (not IsAddOnLoaded("TexBrowser")) then
				LoadAddOn("TexBrowser")
			end
			self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		end)

		SlashCmdList["TRUH_TEX_BROWSER"] = function()
			if (IsAddOnLoaded("TexBrowser")) then
				return
			else
				LoadAddOn("TexBrowser")
			end
		end
		_G["SLASH_TRUH_TEX_BROWSER1"] = "/tb"
	end
--]]

--[[ Buff Sizes

	do
		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')
		f:SetScript('OnEvent', function(self, event)
			BuffFrame:SetScale(1.25)
			ConsolidatedBuffs:SetScale(1.25)
			TemporaryEnchantFrame:SetScale(1.25)

			UIErrorsFrame:SetScale(0.75)

			self:UnregisterEvent(event)
		end)
	end
--]]

