--[[ _G.CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
	_G.CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA   = 0
	_G.CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA   = 0.5
	_G.CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA     = 0
	_G.CHAT_FONT_HEIGHTS = {
		[1] = 8,
		[2] = 9,
		[3] = 10,
		[4] = 11,
		[5] = 12,
		[6] = 13,
		[7] = 14,
		[8] = 15,
		[9] = 16,
	}
	--------------------------------------------------
	_G.CHAT_SAY_GET = '%s:\32'
	_G.CHAT_YELL_GET = '%s:\32'

	_G.CHAT_WHISPER_GET = '[from] %s:\32'
	_G.CHAT_WHISPER_INFORM_GET = '[to] %s:\32'

	_G.CHAT_BN_WHISPER_GET = '[from] %s:\32'
	_G.CHAT_BN_WHISPER_GET = '[to] %s:\32'

	_G.CHAT_FLAG_AFK = '[AFK] '
	_G.CHAT_FLAG_DND = '[DND] '
	_G.CHAT_FLAG_GM = '[GM] '

	_G.CHAT_GUILD_GET = '[|Hchannel:Guild|hG|h] %s:\32'
	_G.CHAT_OFFICER_GET = '[|Hchannel:o|hO|h] %s:\32'

	_G.CHAT_PARTY_GET = '[|Hchannel:party|hP|h] %s:\32'
	_G.CHAT_PARTY_LEADER_GET = '[|Hchannel:party|hPL|h] %s:\32'
	_G.CHAT_PARTY_GUIDE_GET = '[|Hchannel:party|hDG|h] %s:\32'
	_G.CHAT_MONSTER_PARTY_GET = '[|Hchannel:raid|hR|h] %s:\32'

	_G.CHAT_RAID_GET = '[|Hchannel:raid|hR|h] %s:\32'
	_G.CHAT_RAID_WARNING_GET = '[RW!] %s:\32'
	_G.CHAT_RAID_LEADER_GET = '[|Hchannel:raid|hL|h] %s:\32'

	_G.CHAT_BATTLEGROUND_GET = '[|Hchannel:Battleground|hBG|h] %s:\32'
	_G.CHAT_BATTLEGROUND_LEADER_GET = '[|Hchannel:Battleground|hBL|h] %s:\32'
	--------------------------------------------------
	local channelFormat
	do
		local a = ".*%[(.*)%].*"
		local b = "%%[%1%%]"

		channelFormat = {
			[1]  = {gsub(CHAT_BATTLEGROUND_GET, a, b), '[BG]'},
			[2]  = {gsub(CHAT_BATTLEGROUND_LEADER_GET, a, b), '[BGL]'},

			[3]  = {gsub(CHAT_GUILD_GET, a, b), '[G]'},
			[4]  = {gsub(CHAT_OFFICER_GET, a, b), '[O]'},

			[5]  = {gsub(CHAT_PARTY_GET, a, b), '[P]'},
			[6]  = {gsub(CHAT_PARTY_LEADER_GET, a, b), '[PL]'},
			[7]  = {gsub(CHAT_PARTY_GUIDE_GET, a, b), '[PL]'},

			[8]  = {gsub(CHAT_RAID_GET, a, b), '[R]'},
			[9]  = {gsub(CHAT_RAID_LEADER_GET, a, b), '[RL]'},
			[10] = {gsub(CHAT_RAID_WARNING_GET, a, b), '[RW]'},

			[11] = {gsub(CHAT_FLAG_AFK, a, b), '[AFK] '},
			[12] = {gsub(CHAT_FLAG_DND, a, b), '[DND] '},
			[13] = {gsub(CHAT_FLAG_GM, a, b), '[GM] '},
		}
	end

	local AddMessage = ChatFrame1.AddMessage

	local function FCF_AddMessage(self, text, ...)
		if (type(text) == 'string') then
			text = gsub(text, "(|HBNplayer.-|h)%[(.-)%]|h", '%1%2|h')
			text = gsub(text, "(|Hplayer.-|h)%[(.-)%]|h", '%1%2|h')
			text = gsub(text, "%[(%d0?)%. (.-)%]", '[%1]')

			for i, formatString in pairs(channelFormat) do									-- for i = 1, (#channelFormat)  do

				text = gsub(text, formatString[1], formatString[2])							-- text = gsub(text, channelFormat[i][1], channelFormat[i][2])
			end
		end

		return AddMessage(self, text, ...)
	end
--]]
--------------------------------------------------
local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Cokedriver"]) then return end

-- local _G = _G
local insert = table.insert
local concat = table.concat
local find = string.find
local format = string.format
local gsub = string.gsub
local select = select
local tostring = tostring
local type = type
local unpack = unpack

-- Constant
local MARGIN = G.MARGIN
local PAD = G.PAD
local NUM_CHAT_FRAMES = C["Chat"]["Windows"]

local DEFAULT_FRAME_WIDTH = C["Chat"]["Copy"]["Width"]		-- or 450
local DEFAULT_FRAME_HEIGHT = C["Chat"]["Copy"]["Height"]	-- or 250
local DEFAULT_FRAME_POINT = C["Chat"]["Copy"]["Point"]


-- Import
local ChatFrames = A["ChatFrames"] and A["ChatFrames"] or CreateFrame('Frame', AddOn .. "ChatFrames")
for i = 1, (NUM_CHAT_FRAMES) do
	local ChatFrame = _G[format("ChatFrame%d", i)]
	ChatFrames["ChatFrame" .. i] = ChatFrame													--> ChatFrames.ChatFrame1 = ChatFrame1
end

-- Addon
ChatFrames["CopyFrame"] = CreateFrame('Frame', "TCF", A.UIParent)


-- Localize
local F = ChatFrames["CopyFrame"]


-- Properties
local ChatLines = {}


--------------------------------------------------

function ChatFrames:CreateCopyFrame()
	F:Size(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT)
	F:Point(unpack(DEFAULT_FRAME_POINT))			-- F:Point('LEFT', G.MARGIN, 0)
	F:Template("TRANSPARENT")															-- F:SetFrameStrata('DIALOG')
	F:Hide()																			-- HideUIPanel(F)
	tinsert(UISpecialFrames, "TCF")
	A.MakeMovable(F)

	F["Title"] = F:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')							-- 'GameFontHighlight')
	F["Title"]:Point('TOPLEFT', MARGIN, -MARGIN)								-- F["Title"]:SetFontObject('GameFontNormal')

	F["Scroll"] = CreateFrame("ScrollFrame", "$parent_Scroll", F, 'UIPanelScrollFrameTemplate')
	-- local ScrollBarWidth = F["Scroll"]["ScrollBar"]:GetWidth()								-- F["Scroll"]["ScrollBar"]["Width"] = F["Scroll"]["ScrollBar"]:GetWidth()
	F["Scroll"]:Point('TOPLEFT', MARGIN, -30)
	F["Scroll"]:Point('BOTTOMRIGHT', -(F["Scroll"]["ScrollBar"]:GetWidth() + MARGIN + PAD), MARGIN)


	F["Scroll"]["ScrollBar"]:SkinScrollBar()


	F["Editbox"] = CreateFrame("EditBox", "$parent_EditBox", F)
	F["Scroll"]:SetScrollChild(F["Editbox"])
	F["Editbox"]:Width(F["Scroll"]:GetWidth())	-- F["Editbox"]:Width(DEFAULT_FRAME_WIDTH - (ScrollBarWidth + MARGIN))
	F["Editbox"]:Height(F["Scroll"]:GetHeight())	-- F["Editbox"]:Height(DEFAULT_FRAME_HEIGHT)
	F["Editbox"]:Template("CLASSCOLOR")
	F["Editbox"]:SetMultiLine(true)
	F["Editbox"]:SetMaxLetters(0)
	F["Editbox"]:EnableMouse(true)
	F["Editbox"]:SetAutoFocus(false)
	F["Editbox"]:SetFontObject(GameFontNormal)											-- F["Editbox"]:SetFontObject('GameFontNormalSmall')  -- F["Editbox"]:SetFontObject('GameFontHighlight')
	F["Editbox"]:SetScript("OnEscapePressed", F["Editbox"].ClearFocus)						-- HideParentPanel)


	F["Closer"] = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
	F["Closer"]:SkinCloseButton()
	F["Closer"]:Point("TOPRIGHT", -6, -5)

	F["Resizer"] = CreateFrame("Button", "$parent_ResizeButton", F)
	F["Resizer"]:SkinResizeButton()
end


local function GetChatLines(...)
	local count = 1
	for i = select('#', ...), 1, -1 do
		local region = select(i, ...)
		if (region:GetObjectType() == 'FontString') then
			ChatLines[count] = tostring(region:GetText())
			count = count + 1
		end
	end
	return count - 1
end


local function CopyChat(ChatFrame)				-- local ChatFrame = _G[CF:GetName()]
	local numlines = GetChatLines(ChatFrame:GetRegions()) or 0
	local text = concat(ChatLines, "\n", 1, numlines)

	F["Title"]:SetText(ChatFrame:GetName())
	F["Editbox"]:SetText(text)
end


function ChatFrames:CreateCopyButton(ChatFrame)
	local ChatFrame = ChatFrame

	local Button = CreateFrame('Button', "$parent_CopyButton", ChatFrame)
	Button:Size(20)
	Button:Point('TOPRIGHT', -5, -5)
	Button:SetNormalTexture(C["Chat"]["Copy"]["ButtonNormal"])								-- [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Disabled]=]
	Button:GetNormalTexture():Size(20)
	Button:SetHighlightTexture(C["Chat"]["Copy"]["ButtonHighlight"])							-- [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Up]=]
	Button:GetHighlightTexture():SetAllPoints(Button:GetNormalTexture())
	Button:SetScript("OnEnter", function() Button:FadeIn() end)
	Button:SetScript("OnLeave", function() Button:FadeOut() end)
	Button:SetScript("OnMouseUp", function()
		ToggleFrame(F)
		CopyChat(ChatFrame)
	end)
end

--------------------------------------------------
ChatFrames:RegisterEvent('PLAYER_ENTERING_WORLD')
ChatFrames:SetScript('OnEvent', function(self, event, addon)
	self:CreateCopyFrame()

	-- Copy Buttons
	for i = 1, (NUM_CHAT_FRAMES) do
		local ChatFrame = _G[format("ChatFrame%d", i)]
		self:CreateCopyButton(ChatFrame)
	end

	self:UnregisterEvent('PLAYER_ENTERING_WORLD')
end)


--[[










--]]



--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local function CreateCopyButton(self)
		local ChatFrame = self and self

		local Button = CreateFrame("Button", "$parent_CopyButton", ChatFrame)
		Button:Size(20, 20)
		Button:Point('TOPRIGHT', -5, -5)

		Button:SetNormalTexture([=[Interface\BUTTONS\UI-GuildButton-PublicNote-Disabled]=])
		Button:GetNormalTexture():Size(20, 20)
		Button:SetHighlightTexture([=[Interface\BUTTONS\UI-GuildButton-PublicNote-Up]=])
		Button:GetHighlightTexture():SetAllPoints(Button:GetNormalTexture())

		Button:SetScript("OnEnter", function() Button:FadeIn() end)
		Button:SetScript("OnLeave", function() Button:FadeOut() end)
		Button:SetScript("OnMouseUp", function(self)
			CopyChat(self.ChatFrame)
		end)

		self.Button = Button
		self.Button.ChatFrame = ChatFrame
	end
--]]

--[[ local function CreateCopyButtons()
		for i = 1, (NUM_CHAT_FRAMES) do
			local ChatFrame = _G[format("ChatFrame%d", i)]
			if (ChatFrame and not ChatFrame.Button) then
				CreateCopyButton(ChatFrame)
			end
		end
	end
--]]

--[[ hooksecurefunc("FCF_OpenTemporaryWindow", CreateCopyButton)

--]]



