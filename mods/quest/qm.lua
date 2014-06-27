local A, C, G, L = select(2, ...):Unpack()

if (not C["Quest"]["Enable"] or not C["Quest"]["QM"]["Enable"]) then
	return
end

local print = function(...)
	A.print("QM", ...)
end

local match, sub, gsub = string.match, string.sub, string.gsub
local insert, wipe = table.insert, table.wipe

local IsShiftKeyDown = IsShiftKeyDown


-- Variables
local choiceQueue
local choiceFinished


-- Quest Manager Addon
local QM = CreateFrame('Frame')


-- Data Tables
QM.completed_quests = {}
QM.incomplete_quests = {}


-------------------------------------------------- Utils
function QM:canAutomate()
	if (IsShiftKeyDown()) then
		return false
	else
		return true
	end
end

function QM:scrubText(text)
	if (not text) then
		return
	end

	text = text:gsub('|c%x%x%x%x%x%x%x%x(.-)|r','%1')
	text = text:gsub('%[.*%]%s*','')
	text = text:gsub('(.+) %(.+%)', '%1')
	text = text:trim()

	return text
end

-------------------------------------------------- Handlers
function QM:QUEST_PROGRESS()
	if (not self:canAutomate()) then
		return
	end
	if (IsQuestCompletable()) then
		CompleteQuest()
	end
end

function QM:QUEST_LOG_UPDATE()
	if (not self:canAutomate()) then
		return
	end

	local _								--~  Rampant taints occur if this is removed
	local title
	local is_complete
	local no_objectives
	local start_entry = GetQuestLogSelection()
	local num_entries = GetNumQuestLogEntries()

	self.completed_quests  = {}
	self.incomplete_quests = {}

	if (num_entries > 0) then
		for i = 1, num_entries do
			SelectQuestLogEntry(i)

			title, _, _, _, _, _, is_complete = GetQuestLogTitle(i)

			no_objectives = GetNumQuestLeaderBoards(i) == 0

			if (title) then
				if ((is_complete) or (no_objectives)) then
					self.completed_quests[title] = true
				else
					self.incomplete_quests[title] = true
				end
			end
		end
	end

	SelectQuestLogEntry(start_entry)
end

function QM:GOSSIP_SHOW()
	if (not self:canAutomate()) then
		return
	end

	local button
	local text

	for i = 1, 32 do
		button = _G['GossipTitleButton' .. i]

		if (button:IsVisible()) then
			text  = self:scrubText(button:GetText())
			ABCDE = { button:GetText(), text }

			if (button.type == 'Available') then
				button:Click()

			elseif (button.type == 'Active') then
				if (self.completed_quests[text]) then
					button:Click()
				end
			end
		end
	end
end

function QM:QUEST_GREETING(...)
	if (not self:canAutomate()) then
		return
	end

	local button
	local text

	for i = 1, 32 do
		button = _G['QuestTitleButton' .. i]

		if (button:IsVisible()) then
			text = self:scrubText(button:GetText())

			if (self.completed_quests[text]) then
				button:Click()
			elseif (not self.incomplete_quests[text]) then
				button:Click()
			end
		end
	end
end

function QM:QUEST_DETAIL()
	if (not self:canAutomate()) then
		return
	end
	AcceptQuest()
end

function QM:QUEST_COMPLETE(event)										-- Credit: Monomyth Addon by Adrian Lange (p3lim)
	if (not self:canAutomate()) then
		return
	end

	local choices = GetNumQuestChoices()

	if (choices <= 1) then
		GetQuestReward(1)

	elseif (choices > 1) then
		local bestValue, bestIndex = 0

		for index = 1, (choices) do
			local link = GetQuestItemLink('choice', index)
			if (link) then
				local _,_,_,_,_,_,_,_,_,_, value = GetItemInfo(link)
				if (match(link, 'item:45724:')) then
					value = 1e5									-- Champion's Purse, contains 10 gold
				end
				if (value > bestValue) then
					bestValue, bestIndex = value, index
				end
			else
				choiceQueue = true
				return GetQuestItemInfo('choice', index)
			end
		end

		if (bestIndex) then
			choiceFinished = true
			_G['QuestInfoItem' .. bestIndex]:Click()
		end
	end
end

-------------------------------------------------- Events
QM:RegisterEvent('GOSSIP_SHOW')
QM:RegisterEvent('QUEST_COMPLETE')
QM:RegisterEvent('QUEST_DETAIL')
QM:RegisterEvent('QUEST_FINISHED')
QM:RegisterEvent('QUEST_GREETING')
QM:RegisterEvent('QUEST_LOG_UPDATE')
QM:RegisterEvent('QUEST_PROGRESS')
QM:SetScript('OnEvent', function(self, event, ...)
	if (self[event]) then
		self[event](self, ...)
	end
end)










