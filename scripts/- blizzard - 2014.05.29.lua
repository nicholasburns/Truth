local A, C, G, L = select(2, ...):Unpack()
--------------------------------------------------


		if (not false) then
			return
		end


--------------------------------------------------
local AddonMap
local OnEvent

do
	local pairs = pairs
	local type = type


	AddonMap = {
		["Blizzard_AchievementUI"] = function()
			AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_INCOMPLETE)
		end,
		["Blizzard_BindingUI"] = function()
			A.MakeMovable(KeyBindingFrame)
		end,
		["Blizzard_GuildUI"] = function()
			GuildFrame:HookScript("OnShow", function() GuildFrameTab2:Click() end)
		end,
		["Blizzard_ReforgingUI"] = function()
			A.MakeMovable(ReforgingFrame)
		end,
		["Blizzard_TimeManager"] = function()
			TimeManagerClockButton:Point("CENTER", Minimap, 0, -85)
		end,
	}


	OnEvent = function(self, event, addon)
		for name, func in pairs(AddonMap) do
			if (name == addon) then
				func()
			end
		end
	end

	-- OnEvent = function(self, event, addon)
		-- if (not Eventmap[addon]) then
			-- return
		-- end
		-- Eventmap[addon]()
	-- end


	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", OnEvent)
end



--[[
OnEvent = function(self, event, addon)

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
--	Backup
--------------------------------------------------
--[[	do
		local EventMap = {}

		Addon.EventFrame = CreateFrame("Frame", AddOn .."EventFrame", UIParent)
		Addon.EventFrame:RegisterEvent("VARIABLES_LOADED")
		Addon.EventFrame:SetScript("OnEvent", function(self, event, ...)
			if (event == "VARIABLES_LOADED") then self:UnregisterEvent(event)
				addon:OnInitialize()
			end
		end)

		function addon:OnInitialize() end
	end
--]]

--------------------------------------------------
--	Blizzard
--------------------------------------------------
--[[ local blizzard = CreateFrame("Frame")

	blizzard:SetScript("OnEvent", function(self, event, ...)
		self[event](...)
	end)

	function blizzard:ADDON_LOADED(event, addon)
		if (addon == "Blizzard_TimeManager") then							-- TimeManager

		end

		f:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
--]]
