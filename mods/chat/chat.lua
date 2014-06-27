local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Chat", ...)
end

local M = C["Chat"]

local format, match, upper = string.format, string.match, string.upper
local ipairs, pairs, select, unpack = ipairs, pairs, select, unpack

local ChatFrame1 = ChatFrame1
local ChatFrame2 = ChatFrame2
local ChatFrame3 = ChatFrame3
local ChatFrame4 = ChatFrame4

local Reset

local Prepare
local Layout
local Fonterize

local Setup
local SkinChatEditBox, SkinChatButtonFrame, SkinChatResizeButton
local Style


Reset = function()
	FCF_ResetChatWindows()

--	Debug
--	print("Reset", "FCF_ResetChatWindows", "succeeded")

	-- ChatFrame1
	FCF_SetWindowName(ChatFrame1, 'MAIN')
	FCF_SetLocked(ChatFrame1, nil)
	ChatFrame_AddChannel(ChatFrame1, L["CHAT_CHANNEL_GENERAL"])
	ChatFrame_AddChannel(ChatFrame1, L["CHAT_CHANNEL_TRADE"])
	ChatFrame_AddChannel(ChatFrame1, L["CHAT_CHANNEL_LOCAL_DEFENSE"])
	ChatFrame_AddChannel(ChatFrame1, L["CHAT_CHANNEL_LOOKING_FOR_GROUP"])
	for k, v in pairs({'GUILD_ACHIEVEMENT','LOOT','CURRENCY','MONEY','MONSTER_SAY','MONSTER_YELL','MONSTER_EMOTE','MONSTER_WHISPER','MONSTER_BOSS_EMOTE','MONSTER_BOSS_WHISPER'}) do
		ChatFrame_RemoveMessageGroup(ChatFrame1, v)
	end

	-- ChatFrame2
	FCF_SetWindowName(ChatFrame2, (COMBAT):upper())
	--	 FCF_SetWindowName(ChatFrame2, (COMBAT):upper())
	FCF_SetLocked(ChatFrame2, nil)

	-- ChatFrame3
	FCF_OpenNewWindow('CHAT')
	FCF_SetLocked(ChatFrame3, nil)
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	for k, v in pairs({'BN_WHISPER','BN_CONVERSATION','WHISPER','GUILD','OFFICER','INSTANCE_CHAT','INSTANCE_CHAT_LEADER','PARTY','PARTY_LEADER','RAID','RAID_LEADER','RAID_WARNING'}) do
		ChatFrame_AddMessageGroup(ChatFrame3, v)
	end

	-- ChatFrame4
	FCF_OpenNewWindow('SPAM')
	FCF_SetLocked(ChatFrame4, nil) -- 1
	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame_AddChannel(ChatFrame4, L["CHAT_CHANNEL_GENERAL"])
	ChatFrame_AddChannel(ChatFrame4, L["CHAT_CHANNEL_TRADE"])
	ChatFrame_AddChannel(ChatFrame4, L["CHAT_CHANNEL_LOCAL_DEFENSE"])
	ChatFrame_AddChannel(ChatFrame4, L["CHAT_CHANNEL_LOOKING_FOR_GROUP"])
	for k, v in pairs(ChatTypeGroup) do ChatFrame_AddMessageGroup(ChatFrame4, k) end
	ChatFrame_RemoveMessageGroup(ChatFrame4, TRADESKILLS)
	for k, v in pairs({
		--[[A]] 'ACHIEVEMENT','GUILD_ACHIEVEMENT',
		--[[S]] 'SAY','YELL','EMOTE',
		--[[W]] 'WHISPER',
		--[[G]] 'GUILD','OFFICER',
		--[[I]] 'INSTANCE_CHAT','INSTANCE_CHAT_LEADER',
		--[[P]] 'PARTY','PARTY_LEADER',
		--[[R]] 'RAID','RAID_LEADER','RAID_WARNING',
		--[[C]] 'CHANNEL1','CHANNEL2','CHANNEL3','CHANNEL4','CHANNEL5','CHANNEL6','CHANNEL7','CHANNEL8','CHANNEL9','CHANNEL10','CHANNEL11','CHANNEL12',
	}) do ToggleChatColorNamesByClassGroup(true, v) end

	ChangeChatColor('BN_WHISPER', 1, 1/2, 1)
	ChangeChatColor('BN_WHISPER_INFORM', 1, 1/2, 1)
	ChangeChatColor('INSTANCE_CHAT_LEADER', 1, 1/2, 0)
	ChangeChatColor('RAID', 0, 1, 4/5)
	ChangeChatColor('RAID_LEADER', 0, 1, 4/5)
	ChangeChatColor('RAID_WARNING', 1, 1/4, 1/4)
	ChangeChatColor('PARTY_LEADER', 2/3, 2/3, 1)
	ChangeChatColor('OFFICER', 3/4, 1/2, 1/2)
	ChangeChatColor('CHANNEL1', 8/9, 3/4, 1/2)							-- [1. General]:  brown
	ChangeChatColor('CHANNEL2', 2/3, 2/3, 2/3)							-- [2. Trade]:    gray														-- ChangeChatColor('CHANNEL2', 8/9, 8/9, 8/9)		-- [2. Trade]:    silver
	ChangeChatColor('CHANNEL3', 4/5, 2/5, 2/5)							-- [3. Defense]:  red
	ChangeChatColor('CHANNEL4', 1/2, 1/2, 1/2)							-- [4. LFG]:      gray
	ChangeChatColor('CHANNEL5', 1/3, 4/5, 1/3)							-- [5. Insom]:    green

	FCF_SetButtonSide(ChatFrame1, 'right', true)
	FCF_SetButtonSide(ChatFrame2, 'right', true)
	FCF_SetButtonSide(ChatFrame3, 'right', true)
	FCF_SetButtonSide(ChatFrame4, 'right', true)

	FCF_SelectDockFrame(ChatFrame1)									-- Selected frame

--	Debug
--	print("Reset", "function", "completed")
end

Prepare = function(self)
	self:SetFading(false)
	self:SetMaxResize(0, 0)
	self:SetMinResize(0, 0)
	self:SetClampedToScreen(false)
	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetHitRectInsets(0, 0, 0, 0)
	A.MakeMovable(self)						-- self:MakeMovable()
end

Layout = function(ChatFrame)
	ChatFrame:SetSize(M["Width"], M["Height"])
	ChatFrame:ClearAllPoints()
	ChatFrame:SetPoint(unpack(M["Point"]))
	ChatFrame:SetUserPlaced(true)
	FCF_SavePositionAndDimensions(ChatFrame)

	local EditBox = _G[("ChatFrame%dEditBox"):format(ChatFrame:GetID())]
	EditBox:SetSize(M["Width"], 32)
	EditBox:ClearAllPoints()
	EditBox:SetPoint('BOTTOMLEFT', _G[("ChatFrame%dTab"):format(ChatFrame:GetID())], 'TOPLEFT', 0, G.PAD)
end

Fonterize = function()
	local file, size, flag, shad, color

	for i = 1, (G.NUM_CHAT_FRAMES) do
		local ChatFrame = _G[("ChatFrame%d"):format(i)]

		file, size, flag, shad, color = unpack(M["Font"])

		ChatFrame:SetFont(file, size, flag)
		ChatFrame:SetShadowOffset(1.25, -1.25)
		ChatFrame:SetShadowColor(unpack(color))


		local EditBox = _G[("ChatFrame%dEditBox"):format(i)]
		local EditBoxHeader = _G[("ChatFrame%dEditBoxHeader"):format(i)]

		file, size, flag, shad, color = unpack(M["EditBox"]["Font"])

		EditBox:SetFont(file, 14, "")
		EditBox:SetShadowOffset(1.25, -1.25)
		EditBox:SetShadowColor(unpack(color))

		EditBoxHeader:SetFont(file, 14, "")
		EditBoxHeader:SetShadowOffset(1.25, -1.25)
		EditBoxHeader:SetShadowColor(unpack(color))


		local Tab = _G[("ChatFrame%dTab"):format(i)]
		local TabFont = Tab:GetFontString()
		local TabText = _G[("ChatFrame%dTabText"):format(i)]

		file, size, flag, shad, color = unpack(M["Tab"]["Font"])

		TabFont:SetFont(file, size, flag)
		TabFont:SetShadowOffset(shad and 1.25 or 0, shad and -1.25 or 0)
		TabFont:SetShadowColor(unpack(color))

		TabText:SetFont(file, size, flag)
		TabText:SetShadowOffset(shad and 1.25 or 0, shad and -1.25 or 0)
		TabText:SetShadowColor(unpack(color))

	end
end


-- Skinning

SkinChatEditBox = function(ChatFrame)
	local id = ChatFrame:GetID()

	local EditBoxName = ("ChatFrame%dEditBox"):format(id)
	local EditBox = _G[EditBoxName]

	_G[("ChatFrame%sEditBoxLeft"):format(id)]:Kill()
	_G[("ChatFrame%sEditBoxMid"):format(id)]:Kill()
	_G[("ChatFrame%sEditBoxRight"):format(id)]:Kill()
	_G[("ChatFrame%sEditBoxFocusLeft"):format(id)]:Kill()
	_G[("ChatFrame%sEditBoxFocusMid"):format(id)]:Kill()
	_G[("ChatFrame%sEditBoxFocusRight"):format(id)]:Kill()

	EditBox:SetAltArrowKeyMode(true)
	EditBox:SetAutoFocus(nil)
	EditBox:SetTextInsets(6, 0, 0, 0)

	EditBox:Template("TRANSPARENT")
	EditBox:Shadow()

	EditBox:SetFontObject('GameFontHighlight')
	EditBox:SetFont(unpack(M["EditBox"]["Font"]))
end
SkinChatButtonFrame = function(ChatFrame)
	local id = ChatFrame:GetID()

	local ButtonFrameName = ("ChatFrame%dButtonFrame"):format(id)
	local ButtonFrame = _G[ButtonFrameName]

  -- _G[("ChatFrame%dButtonFrame"):format(id)]:Kill()
	_G[("ChatFrame%dButtonFrameUpButton"):format(id)]:Kill()
	_G[("ChatFrame%dButtonFrameDownButton"):format(id)]:Kill()
  -- _G[("ChatFrame%dButtonFrameBottomButton"):format(id)]:Kill()
	_G[("ChatFrame%dButtonFrameMinimizeButton"):format(id)]:Kill()
end
SkinChatResizeButton = function(ChatFrame)
	local ResizeButtonName = ("ChatFrame%dResizeButton"):format(ChatFrame:GetID())
	local ResizeButton = _G[ResizeButtonName]

	ResizeButton:SkinResizeButton()
end


	-- Style

Style = function(ChatFrame)
	Prepare(ChatFrame)
	Layout(ChatFrame)
	Fonterize()

	local ChatFrame = ChatFrame
	local ChatFrameName = ChatFrame:GetName()

	local id = ChatFrame:GetID()

	ChatFrame:Strip(true)
	ChatFrame:Template("TRANSPARENT")
	ChatFrame:Shadow()

	-- Other Elements
	SkinChatEditBox(ChatFrame)
	SkinChatButtonFrame(ChatFrame)
	SkinChatResizeButton(ChatFrame)

	ChatFrame.styled = true
end


	-- Events

Reset()


local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript("OnEvent", function(self, event, addon)
	if (addon == A.ADDON_NAME) then
		Reset()
	--	print("Chat Reset", "Done")
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		for i = 1, (G.NUM_CHAT_FRAMES) do
			local ChatFrame = _G[("ChatFrame%d"):format(i)]
			Style(ChatFrame)
		end

	--	print("Chat Style", "Done")
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end

	if (addon == "Blizzard_CombatLog") then
		ChatFrameMenuButton:Kill()

	--	print("Chat Menu Button", "Nuked")
		self:UnregisterEvent('ADDON_LOADED')
	end
end)









--------------------------------------------------

--[[ Setup = function(ChatFrame)
		Prepare(ChatFrame)
		Layout(ChatFrame)
		Fonterize()
	end
--]]

--------------------------------------------------

--[[ ChatFrames:RegisterEvent('PLAYER_ENTERING_WORLD')
	ChatFrames:SetScript('OnEvent', function(self, event, addon)
		Reset()

		for i = 1, (G.NUM_CHAT_FRAMES) do
			local ChatFrame = _G[("ChatFrame%d"):format(i)]
			Setup(ChatFrame)
			Style(ChatFrame)
		end

		ChatFrameMenuButton:Kill()

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)

	A["ChatFrames"] = ChatFrames
--]]

--------------------------------------------------

--[[ SetFonts = function(ChatFrame)
	ChatFrame:SetFont(unpack(M["Font"]))
	FCF_SetChatWindowFontSize(nil, ChatFrame, M["Font"][2])

	local Tab = _G[("ChatFrame%dTab"):format(ChatFrame:GetID())]	-- local TabText = ("ChatFrame%dTabText"):format(i)
	local TabFont = Tab:GetFontString()

	TabFont:SetFont(unpack(M["Tab"]["Font"]))
	TabFont:SetShadowOffset(M["Tab"]["Font"][4] and 1 or 0, M["Tab"]["Font"][4] and -1 or 0)
end
--]]

--------------------------------------------------
--[[
local UpdateLayout = function()
	for i = 1, (NUM_CHAT_FRAMES) do		-- for _, name in ipairs(CHAT_FRAMES) do
		Layout(_G[("ChatFrame%d"):format(i)])
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_ALIVE")
f:RegisterEvent("DISPLAY_SIZE_CHANGED")
f:RegisterEvent("UI_SCALE_CHANGED")
f:RegisterEvent("VARIABLES_LOADED")
--
f:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
f:RegisterEvent("UPDATE_STEALTH")

f:SetScript('OnEvent', UpdateLayout)
--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Beauty Borders

	local Borders = function()
		for id = 1, (G.NUM_CHAT_FRAMES) do
			local ChatFrame = _G[("ChatFrame%d"):format(id)]
			if (ChatFrame) then
				ChatFrame:CreateBeautyBorder(12)
				ChatFrame:SetBeautyBorderPadding(5, 5, 5, 5, 5, 8, 5, 8)
			end
		end
		local ChatFrame = _G["ChatFrame2"]
		if (ChatFrame) then
			ChatFrame:CreateBeautyBorder(12)
			ChatFrame:SetBeautyBorderPadding(5, 29, 5, 29, 5, 8, 5, 8)
		end
	end
--]]

--[[ Layout

	function ChatFrames:Layout()
			ChatFrame1:Point(unpack(M["Point"]))
			ChatFrame1:Size(M["Width"], M["Height"])
			ChatFrame1:SetMaxResize(0, 0)
			ChatFrame1:SetMinResize(0, 0)
			FCF_SavePositionAndDimensions(ChatFrame1)

			for i = 1, (NUM_CHAT_FRAMES) do
				local ChatFrame = _G[format("ChatFrame%d", i)]				-- local f = _G['ChatFrame' .. i]
				ChatFrame:MakeMovable()
				ChatFrame:SetClampedToScreen(false)
				ChatFrame:SetClampRectInsets(0, 0, 0, 0)
			end
	end
--]]

--[[	Setup

	function ChatFrames:Setup()
		for i = 1, (NUM_CHAT_FRAMES) do
			local ChatFrame = _G[format("ChatFrame%d", i)]
			self:Style(ChatFrame)
			ChatFrame:SetFading(false)
		end
	end
--]]

--[[ ChatFrame

	-- Texture Nuke
	for _, texture in pairs(CHAT_FRAME_TEXTURES) do
		_G[format("ChatFrame%d%s", id, texture)]:SetTexture(nil)
	end

	-- Layout
	ChatFrame:MakeMovable()
	ChatFrame:SetClampedToScreen(false)
	ChatFrame:SetClampRectInsets(0, 0, 0, 0)

	-- Border
	ChatFrame:Backdrop("BORDER")
--]]

--[[ Editbox

	EditBox.text = EditBox:CreateFontString(nil, 'ARTWORK', GameFontNormalSmall)
	EditBox.text:SetPoint('LEFT', -120, 1)

	hooksecurefunc("ChatEdit_UpdateHeader", function(Editbox)
		local type = Editbox:GetAttribute("chatType")
		if (not type) then return end
		local info = ChatTypeInfo[type]
		ChatFrame1EditBox:SetBackdropBorderColor(info.r, info.g, info.b)
	end)

	-- Kill Textures
	for k = 6, 11 do
		select(k, ChatFrame1EditBox:GetRegions()):SetTexture(nil)
	end
	local r1, r2, r3 = select(6, EditBox:GetRegions()) r1:Kill() r2:Kill() r3:Kill()
--]]

--[[ Tabs

	local TabName = format("ChatFrame%dTab", id)
	local Tab = _G[TabName]

	-- Tab:HookScript("OnClick", function() EditBox:Hide() end)		-- Tab clicks hide the EditBox
--]]

--[[ Button Frame

	_G[format("ChatFrame%dButtonFrameBottomButton", id)]:Kill()
	_G[ButtonFrameName .. 'UpButton']:Kill()
	_G[ButtonFrameName .. 'DownButton']:Kill()
	_G[ButtonFrameName .. 'MinimizeButton']:Kill()
--]]

--[[ Resize Button

	local ResizeButtonName = format("ChatFrame%dResizeButton", id)
	local ResizeButton = _G[ResizeButtonName]

	ResizeButton:SkinResizeButton()
	ResizeButton:Point('BOTTOMRIGHT', ChatFrame.backdrop, -1, 1)
--]]

--[[ Save each ChatFrame in our Addon's private table

	-- Save ChatFrames
	for i = 1, (NUM_CHAT_FRAMES) do
		local ChatFrame = _G[format("ChatFrame%d", i)]
		ChatFrames["ChatFrame" .. i] = ChatFrame													--> ChatFrames.ChatFrame1 = ChatFrame1
	end
--]]


--------------------------------------------------
--	Dump
--------------------------------------------------
--[[ EditBox Color

	function ChatFrames:UpdateEditBoxColor()
		local EditBox = ChatEdit_ChooseBoxForSend()
		local ChatType = EditBox:GetAttribute("chatType")
		local Backdrop = EditBox.backdrop

		if (Backdrop) then
			if (ChatType == "CHANNEL") then
				local id = GetChannelName(EditBox:GetAttribute("channelTarget"))
				if (id == 0) then
					Backdrop:SetBackdropBorderColor(unpack(A.default.border.color))				-- (unpack(C["Media"]["Colors"]["Border"]))
				else
					Backdrop:SetBackdropBorderColor(ChatTypeInfo[ChatType .. id].r, ChatTypeInfo[ChatType .. id].g, ChatTypeInfo[ChatType .. id].b)
				end
			else
				Backdrop:SetBackdropBorderColor(ChatTypeInfo[ChatType].r, ChatTypeInfo[ChatType].g, ChatTypeInfo[ChatType].b)
			end
		end
	end

	hooksecurefunc("ChatEdit_UpdateHeader", ChatFrames.UpdateEditBoxColor)
--]]

--[[ Style Temporary Frames

	function ChatFrames:StyleTempFrame()
		local ChatFrame = FCF_GetCurrentChatFrame()
		if (ChatFrame.styled) then return end
		ChatFrames:Style(ChatFrame)
	end

	hooksecurefunc("FCF_OpenTemporaryWindow", ChatFrames.StyleTempFrame)
--]]

--[[ function ChatFrames:FadeIn(self)
		UIFrameFadeIn(self, 0.4, self:GetAlpha(), 1)
	end

	function ChatFrames:FadeOut(self)
		UIFrameFadeOut(self, 0.8, self:GetAlpha(), 0)
	end
--]]

--[[ ResetChatSettings()
	SetupChatWindows()
	ChatStyle(ChatFrame1)
	ChatStyle(ChatFrame2)
	ChatStyle(ChatFrame3)
	ChatStyle(ChatFrame4)
--]]

--[[ ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
--]]

--------------------------------------------------
--	Realm Remover (credit: Realm Hider by cjo20)
--------------------------------------------------
--[[ local find = string.find
	local gsub = string.gsub
	local GetRealmName = GetRealmName
	local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter

	local function RemoveCurrentRealmName(self, event, msg, author, ...)
		Remove spaces when a server contain spaces
		local realmName = gsub(GetRealmName(), " ", "")
		if (msg:find("-" .. realmName)) then
			return false, gsub(msg, "%-" .. realmName, ""), author, ...
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", RemoveCurrentRealmName)
--]]

--------------------------------------------------
--	Channels
--------------------------------------------------
--[[ local GENERAL		= L["GENERAL"]
	local TRADE		= L["TRADE"]
	local LOCAL_DEFENSE	= L["LOCAL_DEFENSE"]
	local LOOKING		= L["LOOKING"]
--]]

--------------------------------------------------
--	Debug
--------------------------------------------------
--[[ local name = _G["ChatFrame1"]:GetName()
	local n = "ChatFrame1"
	local f = ChatFrame1
	local e = ChatFrame1EditBox

	local debug = function()
		local regions = ({ChatFrame1EditBox:GetRegions()})
		for k, v in pairs(regions) do
			_G[name .. texture]:SetTexture(nil)
		end
	end
--]]

----------------------------------------------------------------------------------------------------
--	NeonChat (WORKING VERSION)
----------------------------------------------------------------------------------------------------
--[[	local ChatTypeInfo = ChatTypeInfo
	local ChatFrame1EditBox = ChatFrame1EditBox
	local GetChannelName = GetChannelName

	local NeonChat = function()

		local Chat = CreateFrame("Button", "$parent_NeonChat", ChatFrame1EditBox)			-- nil, ChatFrame1EditBox)
		Chat:SetBackdrop(GameTooltip:GetBackdrop())
		Chat:SetBackdropColor(0, 0, 0, 0)
		Chat:SetBackdropBorderColor(0, 0, 0, 0)
		Chat:EnableMouse(false)

		local Editbox = CreateFrame("Button", "$parent_NeonEditbox", ChatFrame1EditBox)		-- nil, ChatFrame1EditBox)
		Editbox:SetBackdrop(GameTooltip:GetBackdrop())
		Editbox:SetBackdropColor(0, 0, 0, 0)
		Editbox:SetBackdropBorderColor(0, 0, 0, 0)

		hooksecurefunc("ChatEdit_UpdateHeader", function(editbox)
			local r, g, b

			if (ACTIVE_CHAT_EDIT_BOX) then
				local type = editbox:GetAttribute("chatType")
				local frame = match(ACTIVE_CHAT_EDIT_BOX:GetName(), "ChatFrame%d", 1) or match(ACTIVE_CHAT_EDIT_BOX:GetName(), "GMChatFrame", 1)

				if (( type == "CHANNEL" )) then
					local id = GetChannelName(editbox:GetAttribute("channelTarget"))

					if (id == 0) then
						Chat:SetBackdropBorderColor(0.5, 0.5, 0.5)
						Chat:SetBackdropColor(0.5, 0.5, 0.5)
						Editbox:SetBackdropColor(0.5/3, 0.5/3, 0.5/3)
					else
						r, g, b = ChatTypeInfo[type .. id].r, ChatTypeInfo[type .. id].g, ChatTypeInfo[type .. id].b

						Chat:SetBackdropBorderColor(r, g, b)															-- Chat:SetBackdropBorderColor(ChatTypeInfo[type .. id].r, ChatTypeInfo[type .. id].g, ChatTypeInfo[type .. id].b)
						Chat:SetBackdropColor(r/3, g/3, b/3)															-- Chat:SetBackdropColor(ChatTypeInfo[type .. id].r/3, ChatTypeInfo[type .. id].g/3, ChatTypeInfo[type .. id].b/3)
						Editbox:SetBackdropColor(r/3, g/3, b/3)															-- Editbox:SetBackdropColor(ChatTypeInfo[type .. id].r/3, ChatTypeInfo[type .. id].g/3, ChatTypeInfo[type .. id].b/3)
					end

				else
					r, g, b = ChatTypeInfo[type].r, ChatTypeInfo[type].g, ChatTypeInfo[type].b

					if (r == nil or g == nil or b == nil) then																-- if (ChatTypeInfo[type].r == nil or ChatTypeInfo[type].g == nil or ChatTypeInfo[type].b == nil) then
						return
					else
						Chat:SetBackdropBorderColor(r, g, b)															-- Chat:SetBackdropBorderColor(ChatTypeInfo[type].r, ChatTypeInfo[type].g, ChatTypeInfo[type].b)
						Chat:SetBackdropColor(r/3, g/3, b/3)															-- Chat:SetBackdropColor(ChatTypeInfo[type].r/3, ChatTypeInfo[type].g/3, ChatTypeInfo[type].b/3)
						Editbox:SetBackdropColor(r/3, g/3, b/3)															-- Editbox:SetBackdropColor(ChatTypeInfo[type].r/3, ChatTypeInfo[type].g/3, ChatTypeInfo[type].b/3)
					end
				end

				Chat:SetParent(ACTIVE_CHAT_EDIT_BOX)
				Chat:ClearAllPoints()
				Chat:SetPoint("TOPLEFT", frame .. "TopLeftTexture", 0, 0)
				Chat:SetPoint("BOTTOMRIGHT", frame .. "BottomRightTexture", 0, 1)

				Editbox:SetParent(ACTIVE_CHAT_EDIT_BOX)
				Editbox:ClearAllPoints()
				Editbox:SetPoint("TOPLEFT", ACTIVE_CHAT_EDIT_BOX:GetName() .. "FocusLeft", 4, -3)
				Editbox:SetPoint("BOTTOMRIGHT", ACTIVE_CHAT_EDIT_BOX:GetName() .. "FocusRight", -4, 3)
				Editbox:SetFrameLevel(_G[frame .. "EditBox"]:GetFrameLevel() - 1)

				Chat:SetFrameStrata(_G[frame]:GetFrameStrata())
				Chat:SetFrameLevel(_G[frame]:GetFrameLevel() - 1)

			else
				Chat:SetBackdropBorderColor(0, 0, 0, 0)
				Chat:SetBackdropColor(0, 0, 0, 0)
				Editbox:SetBackdropColor(0, 0, 0, 0)
			end

			for ChatFrameID = 1, ( CURRENT_CHAT_FRAME_ID ) do
				for i = 6, ( 8 ) do
					select(i, _G["ChatFrame" .. ChatFrameID .. "EditBox"]:GetRegions()):Hide()
				end
			end
		end)
	end

	NeonChat()
--]]

----------------------------------------------------------------------------------------------------
--	Final Touches
----------------------------------------------------------------------------------------------------
--[[ Moved to --> channels.lua

	CHAT_YOU_CHANGED_NOTICE		= ' > [%d]'  -- 'Changed Channel: |Hchannel:%d|h[%s]|h'
	CHAT_YOU_CHANGED_NOTICE_BN	= ' > [%d]'  -- 'Changed Channel: |Hchannel:CHANNEL:%d|h[%s]|h'
	CHAT_YOU_JOINED_NOTICE		= ' + [%d]'  -- 'Joined Channel: |Hchannel:%d|h[%s]|h'
	CHAT_YOU_JOINED_NOTICE_BN	= ' + [%d]'  -- 'Joined Channel: |Hchannel:CHANNEL:%d|h[%s]|h'
	CHAT_YOU_LEFT_NOTICE		= ' - [%d]'  -- 'Left Channel: |Hchannel:%d|h[%s]|h'
	CHAT_YOU_LEFT_NOTICE_BN		= ' - [%d]'  -- 'Left Channel: |Hchannel:CHANNEL:%d|h[%s]|h'
	CHAT_SUSPENDED_NOTICE		= ' - [%d]'  -- 'Left Channel: |Hchannel:%d|h[%s]|h '
	CHAT_SUSPENDED_NOTICE_BN		= ' - [%d]'  -- 'Left Channel: |Hchannel:CHANNEL:%d|h[%s]|h'
--]]

----------------------------------------------------------------------------------------------------
--	Backup
----------------------------------------------------------------------------------------------------
--[[ ButtonFrame

	FriendsMicroButton:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	FriendsMicroButton:SetScript('OnClick', function(self, button)
		if (button == 'RightButton') then
			PlaySound('igChatEmoteButton')
			ChatFrame_OpenMenu()
		else
			ToggleFriendsFrame(1)	-- 1= friends, 2 = who, 3 = guild, 4 = raid, 'default' = last open tab
		end
	end)
--]]

--[[ Channel Strings

	local L_GENERAL 				= 'General'
	local L_TRADE 					= 'Trade'
	local L_LOCAL_DEFENSE			= 'LocalDefense'
	local L_LFG 					= 'LookingForGroup'
	local L_WORLD_DEFENSE			= 'WorldDefense'
	local L_CONVERSATION			= 'Conversation'
--]]

--[[ Globals

	CHAT_TAB_SHOW_DELAY       			= .2		-- [ 0.2 ] --
	CHAT_TAB_HIDE_DELAY 				=  0		-- [  1  ] --	Seconds before fading out TABS
	CHAT_FRAME_FADE_TIME 				=.15		-- [ .15 ] --
	CHAT_FRAME_FADE_OUT_TIME 			=  0		-- [  2  ] --	Seconds before fading out CHATFRAMES
	CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA  	= .2    	-- [ 0.2 ] --
	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA =  1      -- [  1  ] --
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA 	=  0		-- [ 0.4 ] --	Alpha of the SELECTED TAB (default = 1 and 0.4)
	CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA =  1      -- [  1  ] --
	CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA 	=  0		-- [  1  ] --	Alpha of currently alerting TABS (default = 1 and 1)
	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA 	=  1      -- [ 0.6 ] --	Alpha of non-selected, non-alerting TABS
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA 	=  0		-- [ 0.2 ] --
	DEFAULT_CHATFRAME_ALPHA 				=.25		-- [ .25 ] --	Alpha of CHATFRAME when the mouse is over them
	DEFAULT_CHATFRAME_COLOR = {r = 0, g = 0, b = 0}	-- [  -  ] --  { r = 0, g = 0, b = 0 }

	CHAT_FRAME_MIN_WIDTH       			= 400	-- [ 296 ] --
	CHAT_FRAME_NORMAL_MIN_HEIGHT      		= 200	-- [ 120 ] --
--]]

--[=[ Channel Names
   -- credit: wmods.lua

	_G.CHAT_SAY_GET 					= '[S] %s: '
	_G.CHAT_YELL_GET 					= '[Y] %s: '
	_G.CHAT_WHISPER_GET 				= '[F] %s: '
	_G.CHAT_WHISPER_INFORM_GET			= '[T] %s: '
	_G.CHAT_FLAG_AFK					= '[AFK] '
	_G.CHAT_FLAG_DND					= '[DND] '

	local ChannelTags = {
		--[[01]] '[GEN]',				-- General
		--[[02]] '[T]', 				-- Trade
		--[[03]] '[WD]', 				-- WorldDefense
		--[[04]] '[LD]', 				-- LocalDefense
		--[[05]] '[LFG]',				-- LookingForGroup
		--[[06]] '[GR]', 				-- GuildRecruitment
		--[[07]] '[I]', 				-- Instance
		--[[08]] '[IL]', 				-- Instance Leader
		--[[09]] '[G]', 				-- Guild
		--[[10]] '[P]', 				-- Party
		--[[11]] '[PL]', 				-- Party Leader
		--[[12]] '[PL]', 				-- Party Leader (Guide)
		--[[13]] '[O]', 				-- Officer
		--[[14]] '[R]', 				-- Raid
		--[[15]] '[RL]', 				-- Raid Leader
		--[[16]] '[RW]', 				-- Raid Warning
		--[[17]] '[%1]', 				-- Custom Channels
	}

	local ChannelPatterns = {
		--[[01]] '%[%d0?%. General.-%]',
		--[[02]] '%[%d0?%. Trade.-%]',
		--[[03]] '%[%d0?%. WorldDefense%]',
		--[[04]] '%[%d0?%. LocalDefense.-%]',
		--[[05]] '%[%d0?%. LookingForGroup%]',
		--[[06]] '%[%d0?%. GuildRecruitment.-%]',
		--[[07]]  gsub(CHAT_INSTANCE_CHAT_GET,		'.*%[(.*)%].*', '%%[%1%%]'),
		--[[08]]  gsub(CHAT_INSTANCE_CHAT_LEADER_GET,'.*%[(.*)%].*', '%%[%1%%]'),
		--[[09]]  gsub(CHAT_GUILD_GET, 			'.*%[(.*)%].*', '%%[%1%%]'),
		--[[10]]  gsub(CHAT_PARTY_GET, 			'.*%[(.*)%].*', '%%[%1%%]'),
		--[[11]]  gsub(CHAT_PARTY_LEADER_GET, 		'.*%[(.*)%].*', '%%[%1%%]'),
		--[[12]]  gsub(CHAT_PARTY_GUIDE_GET, 		'.*%[(.*)%].*', '%%[%1%%]'),
		--[[13]]  gsub(CHAT_OFFICER_GET, 			'.*%[(.*)%].*', '%%[%1%%]'),
		--[[14]]  gsub(CHAT_RAID_GET, 			'.*%[(.*)%].*', '%%[%1%%]'),
		--[[15]]  gsub(CHAT_RAID_LEADER_GET, 		'.*%[(.*)%].*', '%%[%1%%]'),
		--[[16]]  gsub(CHAT_RAID_WARNING_GET, 		'.*%[(.*)%].*', '%%[%1%%]'),
		--[[17]] '%[(%d0?)%. (.-)%]', 									-- Custom Channels
	}

	local newAddMsg = {}

	local AddMessage = function(frame, text, ...)
		for i = 1, 17 do
			text = gsub(text, ChannelPatterns[i], ChannelTags[i])
		end

		if (CHAT_TIMESTAMP_FORMAT and not text:find('^|r')) then				-- If Blizz timestamps is enabled, stamp anything it misses
			text = BetterDate(CHAT_TIMESTAMP_FORMAT, time()) .. text
		end

		text = gsub(text, '%[(%d0?)%. .-%]', '[%1]') 						-- custom channels

		return newAddMsg[frame:GetName()](frame, text, ...)
	end

	for i = 1, (Mnumwindows) do
		local cleanframe = _G[format('%s%d', 'ChatFrame', i)]

		if (cleanframe:GetName() ~= COMBATLOG) then 							-- if (i ~= 2) then		-- skip combatlog and frames with no messages registered
			newAddMsg[format('%s%d', 'ChatFrame', i)] = cleanframe.AddMessage

			cleanframe.AddMessage = AddMessage
		end
	end
--]=]

--[[ Sticky

	ChatTypeInfo.SAY.sticky 					= 1
	ChatTypeInfo.PARTY.sticky 				= 1
	ChatTypeInfo.PARTY_LEADER.sticky 			= 1
	ChatTypeInfo.GUILD.sticky 				= 1
	ChatTypeInfo.OFFICER.sticky 				= 1
	ChatTypeInfo.RAID.sticky 				= 1
	ChatTypeInfo.RAID_WARNING.sticky 			= 1
	ChatTypeInfo.INSTANCE_CHAT.sticky 			= 1
	ChatTypeInfo.INSTANCE_CHAT_LEADER.sticky 	= 1
	ChatTypeInfo.WHISPER.sticky 				= 1
	ChatTypeInfo.BN_WHISPER.sticky 			= 1
	ChatTypeInfo.CHANNEL.sticky 				= 1
--]]

--[[ _G[EditBoxName .. "Left"]:Kill()								-- /dump ChatFrame1EditBoxLeft
	_G[EditBoxName .. "Mid"]:Kill()
	_G[EditBoxName .. "Right"]:Kill()
	_G[EditBoxName .. "FocusLeft"]:Kill()							-- Circle around the text
	_G[EditBoxName .. "FocusMid"]:Kill()
	_G[EditBoxName .. "FocusRight"]:Kill()
--]]

--[[ EditBox Backdrop

	editbox.backdrop = CreateFrame('Frame', '$parentBackdrop', editbox)
	editbox.backdrop:SetFrameLevel(editbox:GetFrameLevel() - 1)
	editbox.backdrop:SetPoint('TOPLEFT', 2, -10)
	editbox.backdrop:SetPoint('BOTTOMRIGHT', -2, 2)
	editbox.backdrop:SetBackdrop({
		bgFile 	= default.backdrop.texture,
		edgeFile 	= default.border.texture,
		edgeSize 	= 1,
		insets 	= {left = 1, right = 1, top = 1, bottom = 1}})
	editbox.backdrop:SetBackdropColor(unpack(default.backdrop.color))
	editbox.backdrop:SetBackdropBorderColor(unpack(default.border.color))
--]]

--[[	EditBox TextInsets

	GetTextInsets & SetTextInsets
	----------------------------------------------------------------------
	GetTextInsets
	Returns the insets from the edit box's edges which determine its interactive text area
	> left, right, top, bottom = EditBox:GetTextInsets()

	SetTextInsets
	Sets the insets from the edit box's edges which determine its interactive text area
	> EditBox:SetTextInsets(left, right, top, bottom)
--]]

--[[ GeneralDockManager Positioning (Fixes tab alignment issues)

	GeneralDockManagerOverflowButton:ClearAllPoints()
	GeneralDockManagerOverflowButton:SetPoint('BOTTOMRIGHT', ChatFrame1Tab, -2, 2)	-- LeftChatTab, -2, 2)

	hooksecurefunc(GeneralDockManagerScrollFrame, "SetPoint", function(self, point, anchor, attachTo, x, y)
		if (anchor == GeneralDockManagerOverflowButton and x == 0 and y == 0) then
			self:SetPoint(point, anchor, attachTo, -2, -6)
		end
	end)
--]]

--[[ Upvalues

	local ChatFrame1 					= _G.ChatFrame1
	local ChatFrame2 					= _G.ChatFrame2
	local ChatFrame3 					= _G.ChatFrame3
	local ChatFrame4 					= _G.ChatFrame4
	local ChatFrame1Tab 				= _G.ChatFrame1Tab
	local ChatFrame2Tab 				= _G.ChatFrame2Tab
	local ChatFrame3Tab 				= _G.ChatFrame3Tab
	local ChatFrame4Tab 				= _G.ChatFrame4Tab
	local ChatFrame1EditBox 				= _G.ChatFrame1EditBox
	local ChatFrame2EditBox 				= _G.ChatFrame2EditBox
	local ChatFrame3EditBox 				= _G.ChatFrame3EditBox
	local ChatFrame4EditBox 				= _G.ChatFrame4EditBox
	local ChatFrameMenuButton 			= _G.ChatFrameMenuButton
	local FriendsMicroButton 			= _G.FriendsMicroButton
	local UIParent 					= _G.UIParent
	local ChatTypeGroup 				= _G.ChatTypeGroup
	--
	local ChangeChatColor 				= _G.ChangeChatColor
	local ChatFrame_AddChannel 			= _G.ChatFrame_AddChannel
	local ChatFrame_AddMessageEventFilter 	= _G.ChatFrame_AddMessageEventFilter
	local ChatFrame_AddMessageGroup 		= _G.ChatFrame_AddMessageGroup
	local ChatFrame_OpenMenu				= _G.ChatFrame_OpenMenu
	local ChatFrame_RemoveAllMessageGroups 	= _G.ChatFrame_RemoveAllMessageGroups
	local ChatFrame_RemoveMessageGroup 	= _G.ChatFrame_RemoveMessageGroup
	local CreateFrame 					= _G.CreateFrame
	local FCF_OpenNewWindow 				= _G.FCF_OpenNewWindow
	local FCF_SavePositionAndDimensions 	= _G.FCF_SavePositionAndDimensions
	local FCF_SelectDockFrame 			= _G.FCF_SelectDockFrame
	local FCF_SetButtonSide 				= _G.FCF_SetButtonSide
	local FCF_SetChatWindowFontSize 		= _G.FCF_SetChatWindowFontSize
	local FCF_SetLocked 				= _G.FCF_SetLocked
	local FCF_SetWindowName 				= _G.FCF_SetWindowName
	local FCF_UnDockFrame 				= _G.FCF_UnDockFrame
	local GetCVar 						= _G.GetCVar
	local GetRealmName 					= _G.GetRealmName
	local PlaySound					= _G.PlaySound
	local SetChatWindowSavedDimensions 	= _G.SetChatWindowSavedDimensions
	local SetChatWindowSize				= _G.SetChatWindowSize
	local StaticPopup_Hide 				= _G.StaticPopup_Hide
	local StaticPopup_Show 				= _G.StaticPopup_Show
	local ToggleChatColorNamesByClassGroup 	= _G.ToggleChatColorNamesByClassGroup
	local ToggleFriendsFrame				= _G.ToggleFriendsFrame
	local UnitPopup_OnClick 				= _G.UnitPopup_OnClick
	--
	local DEFAULT_CHATFRAME_ALPHA			= _G.DEFAULT_CHATFRAME_ALPHA
	local DEFAULT_CHATFRAME_COLOR			= _G.DEFAULT_CHATFRAME_COLOR
	local CHAT_FRAME_MIN_WIDTH			= _G.CHAT_FRAME_MIN_WIDTH
	local CHAT_FRAME_NORMAL_MIN_HEIGHT		= _G.CHAT_FRAME_NORMAL_MIN_HEIGHT
	local CHAT_FRAMES					= _G.CHAT_FRAMES
	local DEFAULT_CHAT_FRAME 			= _G.DEFAULT_CHAT_FRAME
	local SELECTED_CHAT_FRAME			= _G.SELECTED_CHAT_FRAME
	local UIDROPDOWNMENU_INIT_MENU 		= _G.UIDROPDOWNMENU_INIT_MENU
	-- Tabs
	local CHAT_TAB_SHOW_DELAY					= _G.CHAT_TAB_SHOW_DELAY
	local CHAT_TAB_HIDE_DELAY					= _G.CHAT_TAB_HIDE_DELAY
	local CHAT_FRAME_FADE_TIME 					= _G.CHAT_FRAME_FADE_TIME
	local CHAT_FRAME_FADE_OUT_TIME 				= _G.CHAT_FRAME_FADE_OUT_TIME
	local CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA			= _G.CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA
	local CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA	= _G.CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA
	local CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA		= _G.CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA
	local CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA	= _G.CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA
	local CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA		= _G.CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA
	local CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA		= _G.CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA
	local CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA		= _G.CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA

	local CHAT_YOU_CHANGED_NOTICE			= _G.CHAT_YOU_CHANGED_NOTICE
	local CHAT_YOU_CHANGED_NOTICE_BN		= _G.CHAT_YOU_CHANGED_NOTICE_BN
	local CHAT_YOU_JOINED_NOTICE			= _G.CHAT_YOU_JOINED_NOTICE
	local CHAT_YOU_JOINED_NOTICE_BN		= _G.CHAT_YOU_JOINED_NOTICE_BN
	local CHAT_YOU_LEFT_NOTICE			= _G.CHAT_YOU_LEFT_NOTICE
	local CHAT_YOU_LEFT_NOTICE_BN			= _G.CHAT_YOU_LEFT_NOTICE_BN
	local CHAT_SUSPENDED_NOTICE			= _G.CHAT_SUSPENDED_NOTICE
	local CHAT_SUSPENDED_NOTICE_BN		= _G.CHAT_SUSPENDED_NOTICE_BN
--]]

--[[ Channel Names

local CHAT_CHANNEL_ALIASES 		= Mchannel_aliases
local CHAT_CHANNEL_GLOBAL_ALIASES	= Mchannel_global_aliases

-- Properties
local says		= strsub(CHAT_SAY_GET, 4)
local whisperfrom	= strsub(CHAT_WHISPER_GET, 4)
local whisperto	= strsub(CHAT_WHISPER_INFORM_GET, 1, -5)

local OldAddMessages = {}
local function NewAddMessage(frame, msg, ...)

	local m = tostring(msg) or ""

	if (strmatch(m, "%d+%. .-|h")) then								-- channels
		for k, v in pairs(CHAT_CHANNEL_GLOBAL_ALIASES) do
			m = gsub(m, "|h%[" .. k .. "%]|h", "|h" .. v .. "|h", 1)
		end
	else
		for k, v in pairs(CHAT_CHANNEL_ALIASES) do
			m = gsub(m, "|h%[" .. k .. "]|h", "|h" .. v .. "|h", 1)
		end
	end

	m = gsub(m, "]|h " .. says, "]|h: ", 1)								-- say

	m = m:gsub("(|Hplayer.-|h)%[(.-)%](|h)", "%1%2%3", 1)					-- playernames, strip brackets

	--- CHAT_FLAG_AFK = '<Away>'
	m = gsub(m, CHAT_FLAG_AFK, "[AFK] ", 1)								-- away

	-- CHAT_FLAG_DND = '<Busy>'
	m = gsub(m, CHAT_FLAG_DND, "[DND] ", 1)								-- busy

	m = gsub(m, "|h " .. whisperfrom, "|h: ", 1)							-- whisper

	return OldAddMessages[frame](frame, m, ...)
end

OldAddMessages[f] = f.AddMessage
f.AddMessage = NewAddMessage

--]]
