local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"]) then
	return
end

local pairs = pairs
local type = type
local select = select
local tinsert = table.insert


G.SkinFuncs = {}
G.SkinFuncs[A.ADDON_NAME] = {}



-- SkinFuncs
do
	local OnEvent = function(self, event, addon)
		for addoname, func in pairs(G.SkinFuncs) do
			if (type(func) == "function") then
				if (addoname == addon) then
					func()
				end
			elseif (type(func) == "table") then
				if (addoname == addon) then
					for _, func in pairs(G.SkinFuncs[addoname]) do
						func()
					end
				end
			end
		end
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', OnEvent)
end


-- Darker Default UI
do
	local OnEvent = function(self, event, addon)
		if (addon == 'Blizzard_TimeManager') then
			for _, region in pairs({
				PlayerFrameTexture,
				TargetFrameTextureFrameTexture,
				PetFrameTexture,
				PartyMemberFrame1Texture,
				PartyMemberFrame2Texture,
				PartyMemberFrame3Texture,
				PartyMemberFrame4Texture,
				PartyMemberFrame1PetFrameTexture,
				PartyMemberFrame2PetFrameTexture,
				PartyMemberFrame3PetFrameTexture,
				PartyMemberFrame4PetFrameTexture,
				FocusFrameTextureFrameTexture,
				TargetFrameToTTextureFrameTexture,
				FocusFrameToTTextureFrameTexture,
				BonusActionBarFrameTexture0,
				BonusActionBarFrameTexture1,
				BonusActionBarFrameTexture2,
				BonusActionBarFrameTexture3,
				BonusActionBarFrameTexture4,
				MainMenuBarTexture0,
				MainMenuBarTexture1,
				MainMenuBarTexture2,
				MainMenuBarTexture3,
				MainMenuMaxLevelBar0,
				MainMenuMaxLevelBar1,
				MainMenuMaxLevelBar2,
				MainMenuMaxLevelBar3,
				MinimapBorder,
				CastingBarFrameBorder,
				FocusFrameSpellBarBorder,
				TargetFrameSpellBarBorder,
				MiniMapTrackingButtonBorder,
				MiniMapLFGFrameBorder,
				MiniMapBattlefieldBorder,
				MiniMapMailBorder,
				MinimapBorderTop,
				select(1, TimeManagerClockButton:GetRegions())
			}) do
				region:SetVertexColor(0.4, 0.4, 0.4)
			end

			for _, v in pairs({ select(2, TimeManagerClockButton:GetRegions()) }) do
				v:SetVertexColor(1, 1, 1)
			end

			MainMenuBarLeftEndCap:SetVertexColor(0.35, 0.35, 0.35)
			MainMenuBarRightEndCap:SetVertexColor(0.35, 0.35, 0.35)

			self:UnregisterEvent('ADDON_LOADED')
			self:SetScript('OnEvent', nil)
		end
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', OnEvent)
end


--------------------------------------------------

			if (not false) then
				return
			end

--------------------------------------------------


do
	local ItemTextFrame = ItemTextFrame
	local ItemTextFrameInset = ItemTextFrameInset
	local ItemTextFrameCloseButton = ItemTextFrameCloseButton
	local ItemTextScrollFrame = ItemTextScrollFrame
	local ItemTextScrollFrameScrollBar = ItemTextScrollFrameScrollBar
	local ItemTextPrevPageButton = ItemTextPrevPageButton
	local ItemTextNextPageButton = ItemTextNextPageButton
	local ItemTextPageText = ItemTextPageText


	local func = function()
		ItemTextFrame:Strip(true)
		ItemTextFrame:Template("TRANSPARENT")

		ItemTextFrameInset:Strip()
		ItemTextFrameCloseButton:SkinCloseButton()

		ItemTextScrollFrame:Strip()
		ItemTextScrollFrameScrollBar:SkinScrollBar()

		ItemTextPrevPageButton:SkinPageButton()
		ItemTextNextPageButton:SkinPageButton()

		ItemTextPageText:SetTextColor(1, 1, 1)
		ItemTextPageText.SetTextColor = noop
	end


	tinsert(G.SkinFuncs[A.ADDON_NAME], func)

end




--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self, event, addon)
		ItemTextFrame:Strip(true)
		ItemTextFrame:Template("TRANSPARENT")

		ItemTextFrameInset:Strip()
		ItemTextFrameCloseButton:SkinCloseButton()

		ItemTextScrollFrame:Strip()
		ItemTextScrollFrameScrollBar:SkinScrollBar()

		ItemTextPrevPageButton:SkinPageButton()
		ItemTextNextPageButton:SkinPageButton()

		ItemTextPageText:SetTextColor(1, 1, 1)
		ItemTextPageText.SetTextColor = A["Dummy"]

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
--]]



