local A, C, G, L = select(2, ...):Unpack()
local pairs = pairs


local AddonMap = {}
local M = AddonMap

--[[ M.Blizzard_AchievementUI = function()
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_INCOMPLETE)
	end
--]]
M.Blizzard_BindingUI = function()
	A.MakeMovable(KeyBindingFrame)
end
M.Blizzard_GuildUI = function()
	GuildFrame:HookScript("OnShow", function() GuildFrameTab2:Click() end)
end
M.Blizzard_ReforgingUI = function()
	A.MakeMovable(ReforgingFrame)
end
M.Blizzard_TimeManager = function()
	TimeManagerClockButton:Point("CENTER", Minimap, 0, -85)
end


local OnEvent = function(self, event, addon)
	for Blizzard_Addon, func in pairs(M) do
		if (addon == Blizzard_Addon) then
			func()
		end
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:SetScript('OnEvent', OnEvent)


--------------------------------------------------
--	Fix Me
--------------------------------------------------
--[[ Statistics Linker

	local gsub = string.gsub
	local GetText = GetText
	local IsModifiedClick = IsModifiedClick
	local ChatEdit_GetActiveWindow = ChatEdit_GetActiveWindow

	local OnClick = function(self)
		if (self.isHeader or self.summary) then
			return
		end

		if (IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow()) then
			ChatEdit_GetActiveWindow():Insert(
				self:GetText() .. ": " ..
				self.value:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-GoldIcon.-|t", "g"):gsub("|T.-SilverIcon.-|t", "s"):gsub("|T.-CopperIcon.-|t", "c"):gsub("|H.-|h", ""):gsub("|h", "")
			)
		end
	end

	hooksecurefunc("AchievementStatButton_OnClick", OnClick)
--]]

--------------------------------------------------
--	Credit
--------------------------------------------------
--[[ StatisticsLinker Toc Summary
	## Interface: 40200
	## Title: Statistics Linker
	## Version: 1.3
	## Notes: Enables shift-click copy into the chat edit box for achievement statistics.
	## Author: Sylvanaar (Sylvaan - Zul'Jin/US-Horde)
	## LoadWith: Blizzard_AchievementUI
--]]

--------------------------------------------------


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Alternate Syntax

	OnEvent = function(self, event, addon)
		if (not Eventmap[addon]) then
			return
		end

		Eventmap[addon]()
	end
--]]

--[[ Revert

	local OnEvent = function(self, event, addon)
		if (addon == "Blizzard_AchievementUI") then
			AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_INCOMPLETE)
		end
		if (addon == "Blizzard_BindingUI") then
			A.MakeMovable(KeyBindingFrame)
		end
		if (addon == "Blizzard_GuildUI") then
			GuildFrame:HookScript("OnShow", function() GuildFrameTab2:Click() end)
		end
		if (addon == "Blizzard_ReforgingUI") then
			A.MakeMovable(ReforgingFrame)
		end
		if (addon == "Blizzard_TimeManager") then
			TimeManagerClockButton:Point("CENTER", Minimap, 0, -85)
		end
	end

	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", OnEvent)
--]]

--------------------------------------------------
--	Kickstarters
--------------------------------------------------
--[[	Event Mapping

	local EventMap = {}
	Addon.EventFrame = CreateFrame('Frame')
	Addon.EventFrame:RegisterEvent("VARIABLES_LOADED")
	Addon.EventFrame:SetScript('OnEvent', function(self, event, ...)
		if (event == "VARIABLES_LOADED") then
			Addon:OnInitialize()
			self:UnregisterEvent(event)
		end
	end)

	function Addon:OnInitialize()
		-- Do stuff
	end
--]]

--[[ Addon Handler

	local Handler = CreateFrame('Frame')
	Handler:SetScript("OnEvent", function(self, event, ...) self[event](...) end)
	function Handler:ADDON_LOADED(event, addon)
		if (addon == "Blizzard_TimeManager") then
			-- TimeManager Loaded
		end
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
--]]
