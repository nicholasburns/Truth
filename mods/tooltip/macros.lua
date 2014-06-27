local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Macros"]["Enable"]) then
	return
end




do
	local gmatch = string.gmatch
	local max = math.max
	local strlen = string.len
	local GameTooltip = GameTooltip


	local function OnEnter(self)
		local name, _, body = GetMacroInfo(MacroFrame.macroBase + self:GetID())
		if (name and body) then
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:Point("TOPLEFT", MacroFrameInset, "TOPRIGHT", 10, -4)
			GameTooltip:AddLine(name)

			for line in gmatch(body, "[^\n]+") do
				if (strlen(line) > 0) then
					GameTooltip:AddLine(line, 1, 1, 1)
				end
			end

			GameTooltip:Show()
		end
	end


	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', function(self, event, addon)
		if (addon == "Blizzard_MacroUI") then
			for i = 1, max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS) do
				local button = _G[("MacroButton%d"):format(i)]
				button:SetScript("OnEnter", OnEnter)
				button:SetScript("OnLeave", GameTooltip_Hide)
			end

			local t1 = ("%s  |cff00FF00(%d)|r"):format(L["MACROFRAME_TAB1_TEXT"], MAX_ACCOUNT_MACROS)
			MacroFrameTab1:SetText(t1)									-- MacroFrameTab1:SetText(GENERAL_LABEL)						--@ GlobalStrings.lua || GENERAL_LABEL = "General"
			PanelTemplates_TabResize(MacroFrameTab1)

			local t2 = ("%s  %s(%d)|r"):format(L["MACROFRAME_TAB2_TEXT"], A.PLAYER_COLOR_CFF, MAX_CHARACTER_MACROS)
			MacroFrameTab2:SetText(t2)									-- MacroFrameTab2:SetText(UnitName("player"))
			PanelTemplates_TabResize(MacroFrameTab2)

			self:UnregisterEvent('ADDON_LOADED')
		end
	end)
end


-- print("TT.Macros", "Loaded")


--------------------------------------------------
--	MacroTooltip Header
--------------------------------------------------
--[[	MacroTooltip
	by Phanx <addons@phanx.net>
	Adds tooltips to the Blizzard Macro UI.

	This is free and unencumbered software released into the public domain.
	See the accompanying README and UNLICENSE files for more information.
	http://www.wowinterface.com/downloads/info22720-MacroTooltip.html
	http://www.curse.com/addons/wow/macrotooltip
--]]

--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ MacroTooltip.toc
	## Interface: 50400
	## Version: 5.4.2.1
	## Title: MacroTooltip
	## Notes: Adds tooltips with macro names and contents to the Blizzard Macro UI.
	## Author: Phanx
	## X-Email: addons@phanx.net
	## X-License: Public Domain
	## X-Website: http://www.wowinterface.com/downloads/info22720-MacroTooltip.html
	## X-Curse-Project-Name: macrotooltip
	## LoadOnDemand: 1
	## LoadWith: Blizzard_MacroUI
	Addon.lua
--]]
--------------------------------------------------


