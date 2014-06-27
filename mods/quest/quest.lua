local A, C, G, L = select(2, ...):Unpack()

if (not C["Quest"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Quest", ...)
end





QuestInfoDescriptionText.SetAlphaGradient = noop						-- Instant quest text (bugfix)


--------------------------------------------------
local Errors = {													-- credit: Monomyth by p3lim
--	Error Filter
	[ERR_QUEST_ALREADY_DONE]			= true,
	[ERR_QUEST_FAILED_LOW_LEVEL]		= true,
	[ERR_QUEST_NEED_PREREQS]			= true,
}

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(self, event, message)
	return Errors[message]
end)


--------------------------------------------------
local function questlevel()											-- credit: Tukui by Tukz
--	Quest Levels

	local buttons = QuestLogScrollFrame.buttons
	local numEntries = GetNumQuestLogEntries()
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)

	for i = 1, (#buttons) do
		local qIndex = i + scrollOffset
		local qLogTitle = buttons[i]

		if (qIndex <= numEntries) then
			local title, level, _, _, isHeader = GetQuestLogTitle(qIndex)															-- local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex)
			if (not isHeader) then
				qLogTitle:SetText("[" .. level .. "] " .. title)
				QuestLogTitleButton_Resize(qLogTitle)
			end
		end
	end
end

hooksecurefunc("QuestLog_Update", questlevel)
QuestLogScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ function QM.OnEvent(self, event, ...)
		if (self[event]) then
			self[event](self, ...)
		end
	end
	QM:SetScript('OnEvent', QM.OnEvent)
--]]

--[[ _G.idQuestAutomation = QM
--]]









