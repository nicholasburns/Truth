local A, C, G, L = select(2, ...):Unpack()

if (not C["Quest"]["Enable"] or not C["Quest"]["Wowhead"]["Enable"]) then
	return
end

local _G = _G
local select = _G.select
-- local IsControlKeyDown = IsControlKeyDown
-- local GetQuestLogTitle = GetQuestLogTitle
-- local StaticPopup_Show = StaticPopup_Show
-- local GetQuestIndexForWatch = GetQuestIndexForWatch
-- local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
-- local StaticPopupDialogs = StaticPopupDialogs



_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
	text			= L["WOWHEAD_LINK"],
	button1		= OKAY,
	timeout		= 0,
	whileDead 	= true,
	hasEditBox	= true,
	editBoxWidth	= 350,
	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
}



local Button -- = {}																-- Add Links to the Dropdown (Right-Click)

_G.hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
	if (self.type == "QUEST") then
		Button = {
			text = L["WOWHEAD_LINK"],
			arg1 = self.index,
			func = function(self, watchId)
				local logId = _G.GetQuestIndexForWatch(watchId)
				local questId = select(9, _G.GetQuestLogTitle(logId))
				local inputBox = _G.StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(L["WOWHEAD_QUEST_URL"]:format(questId))
				inputBox.editBox:HighlightText()
			end,
			notCheckable = true,
		}

		_G.UIDropDownMenu_AddButton(Button)

	elseif (self.type == "ACHIEVEMENT") then
		Button = {
			text = L["WOWHEAD_LINK"],
			arg1 = self.index,
			func = function(self, id)
				local inputBox = _G.StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(L["WOWHEAD_ACHIEVEMENT_URL"]:format(id))
				inputBox.editBox:HighlightText()
			end,
			notCheckable = true,
		}

		_G.UIDropDownMenu_AddButton(Button)
	end
end)

_G.UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")



-- Events
do
	local OnEvent = function(self, event, addon)
		if (addon == "Blizzard_AchievementUI") then
			_G.hooksecurefunc("AchievementButton_OnClick", function(self)
				if (self.id and _G.IsControlKeyDown()) then
					local inputBox = _G.StaticPopup_Show("WATCHFRAME_URL")
					inputBox.editBox:SetText(L["WOWHEAD_ACHIEVEMENT_URL"]:format(self.id))
					inputBox.editBox:HighlightText()
				end
			end)
		end

		self:UnregisterEvent('ADDON_LOADED')
		self.ADDON_LOADED = nil
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', OnEvent)
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Locale

	L["WOWHEAD_LINK"]						= "Wowhead Link"
	L["WOWHEAD_QUEST_URL"]					= "http://www.wowhead.com/quest=%d"
	L["WOWHEAD_ACHIEVEMENT_URL"]				= "http://www.wowhead.com/achievement=%d"
--]]

