local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"]) then return end
local X = Addon["PixelSize"]
--
local ipairs, pairs, select, unpack = ipairs, pairs, select, unpack
local ChatFrame1, ChatFrame2, ChatFrame3, ChatFrame4 = ChatFrame1, ChatFrame2, ChatFrame3, ChatFrame4
local CreateFrame = CreateFrame

--------------------------------------------------
--	Reset
--------------------------------------------------
local ResetChatSettings
do
	local ChatTypeGroup = ChatTypeGroup
	local ChangeChatColor = ChangeChatColor
	local ChatFrame_AddChannel = ChatFrame_AddChannel
	local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
	local ChatFrame_RemoveAllMessageGroups = ChatFrame_RemoveAllMessageGroups
	local ChatFrame_RemoveMessageGroup = ChatFrame_RemoveMessageGroup
	local FCF_OpenNewWindow = FCF_OpenNewWindow
	local FCF_ResetChatWindows = FCF_ResetChatWindows
	local FCF_SetButtonSide = FCF_SetButtonSide
	local FCF_SelectDockFrame = FCF_SelectDockFrame
	local FCF_SetLocked = FCF_SetLocked
	local FCF_SetWindowName = FCF_SetWindowName
	local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup

	ResetChatSettings = function()
		FCF_ResetChatWindows()

		-- ChatFrame1
		FCF_SetWindowName(ChatFrame1, 'MAIN')											-- rename windows general and combat log
		FCF_SetLocked(ChatFrame1, nil)													-- FCF_SetLocked(ChatFrame1, 1)

		ChatFrame_AddChannel(ChatFrame1, GENERAL)
		ChatFrame_AddChannel(ChatFrame1, TRADE)
		ChatFrame_AddChannel(ChatFrame1, 'LocalDefense')
		ChatFrame_AddChannel(ChatFrame1, LOOKING)

		for k, v in pairs({'GUILD_ACHIEVEMENT','LOOT','CURRENCY','MONEY','MONSTER_SAY','MONSTER_YELL','MONSTER_EMOTE','MONSTER_WHISPER','MONSTER_BOSS_EMOTE','MONSTER_BOSS_WHISPER'}) do
			ChatFrame_RemoveMessageGroup(ChatFrame1, v)
		end

		-- ChatFrame2
		FCF_SetWindowName(ChatFrame2, 'COMBAT')
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
		FCF_SetLocked(ChatFrame4, 1)

		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddChannel(ChatFrame4, GENERAL)
		ChatFrame_AddChannel(ChatFrame4, TRADE)
		ChatFrame_AddChannel(ChatFrame4, 'LocalDefense')
		ChatFrame_AddChannel(ChatFrame4, LOOKING)

		for k, v in pairs(ChatTypeGroup) do
			ChatFrame_AddMessageGroup(ChatFrame4, k)
		end

		ChatFrame_RemoveMessageGroup(ChatFrame4, 'TRADESKILLS') --TOO SPAMMY WTF!

		-- Playernames (classcolor)
		for k, v in pairs({
			--[[A]] 'ACHIEVEMENT','GUILD_ACHIEVEMENT',
			--[[S]] 'SAY','YELL','EMOTE',
			--[[W]] 'WHISPER',
			--[[G]] 'GUILD','OFFICER',
			--[[I]] 'INSTANCE_CHAT','INSTANCE_CHAT_LEADER',
			--[[P]] 'PARTY','PARTY_LEADER',
			--[[R]] 'RAID','RAID_LEADER','RAID_WARNING',
			--[[C]] 'CHANNEL1','CHANNEL2','CHANNEL3','CHANNEL4',
					'CHANNEL5','CHANNEL6','CHANNEL7','CHANNEL8',
					'CHANNEL9','CHANNEL10','CHANNEL11','CHANNEL12',
		}) do
			ToggleChatColorNamesByClassGroup(true, v)
		end

		-- Channel colors
		ChangeChatColor('BN_WHISPER', 1, 1/2, 1)
		ChangeChatColor('BN_WHISPER_INFORM', 1, 1/2, 1)
		ChangeChatColor('INSTANCE_CHAT_LEADER', 1, 1/2, 0)
		ChangeChatColor('RAID', 0, 1, 4/5)
		ChangeChatColor('RAID_LEADER', 0, 1, 4/5)
		ChangeChatColor('RAID_WARNING', 1, 1/4, 1/4)
		ChangeChatColor('PARTY_LEADER', 2/3, 2/3, 1)
		ChangeChatColor('OFFICER', 3/4, 1/2, 1/2)
		ChangeChatColor('CHANNEL1', 8/9, 3/4, 1/2)		-- [1. General]:  brown
		ChangeChatColor('CHANNEL2', 8/9, 8/9, 8/9)		-- [2. Trade]:    silver
		ChangeChatColor('CHANNEL3', 4/5, 2/5, 2/5)		-- [3. Defense]:  red
		ChangeChatColor('CHANNEL4', 1/2, 1/2, 1/2)		-- [4. LFG]:      grey
		ChangeChatColor('CHANNEL5', 1/3, 4/5, 1/3)		-- [5. Insom]:    green

		-- Button side
		FCF_SetButtonSide(ChatFrame1, 'right', true)
		FCF_SetButtonSide(ChatFrame2, 'right', true)
		FCF_SetButtonSide(ChatFrame3, 'right', true)
		FCF_SetButtonSide(ChatFrame4, 'right', true)

		-- Selected frame
		FCF_SelectDockFrame(ChatFrame1)
	end
end

--------------------------------------------------
--	Setup
--------------------------------------------------
local SetupChatWindows
do
	local SetChatWindowSize = SetChatWindowSize
	local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
	local SetChatWindowSavedDimensions = SetChatWindowSavedDimensions
	local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions

	SetupChatWindows = function()

		ChatFrame1:Point(unpack(C["Chat"]["Point"]))
		ChatFrame1:SetSize(C["Chat"]["Width"], C["Chat"]["Height"])

		FCF_SavePositionAndDimensions(ChatFrame1)


		for i = 1, (G.NUM_CHAT_FRAMES) do							-- for i = 1, ( FCF_GetNumActiveChatFrames() ) do
			local f = _G['ChatFrame' .. i]

			-- Fading
			f:SetFading(false)

			-- Dragging
			f:SetMovable(true)
			f:EnableMouse(true)
			f:SetUserPlaced(true)
			f:SetClampedToScreen(false)
			f:SetClampRectInsets(0, 0, 0, 0)

			-- Stacking
			-- f:SetFrameStrata("BACKGROUND")
			-- f:SetFrameLevel(50)

			-- Size
			f:SetMaxResize(0, 0)
			f:SetMinResize(0, 0)
			-- f:SetSize(C["Chat"]["Width"], C["Chat"]["Height"])

			-- Save Size
			-- SetChatWindowSavedDimensions(f:GetID(), C["Chat"]["Width"], C["Chat"]["Height"])

			-- Point
			-- if (i == 1) then f:Point(unpack(C["Chat"]["Point"])) end

			-- Save Layout
			-- FCF_SavePositionAndDimensions(f)

			-- Font
			f:SetFont(unpack(C["Chat"]["Font"]))

			-- Save Font Size
			FCF_SetChatWindowFontSize(nil, f, C["Chat"]["Font"][2])		-- print("FCF_SetChatWindowFontSize()", C["Chat"]["Font"][2])
			SetChatWindowSize(f:GetID(), C["Chat"]["Font"][2])		-- print("SetChatWindowSize()", C["Chat"]["Font"][2])

		end
	end
end

--------------------------------------------------
--	Chat Coloring
--------------------------------------------------
local SetChatColorToChannelColor
do
	local match = string.match
	local hooksecurefunc = hooksecurefunc
	local ChatTypeInfo = ChatTypeInfo
	local ChatFrame1EditBox = ChatFrame1EditBox
	local GetChannelName = GetChannelName


	SetChatColorToChannelColor = function(name)												-- local ChatFrame = _G[name]

		hooksecurefunc("ChatEdit_UpdateHeader", function(EditBox)
			local color, r, g, b

			if (ACTIVE_CHAT_EDIT_BOX) then

				local type  = EditBox:GetAttribute("chatType")
				local frame = match(ACTIVE_CHAT_EDIT_BOX:GetName(), "ChatFrame%d", 1)			-- or match(ACTIVE_CHAT_EDIT_BOX:GetName(), "GMChatFrame", 1)

				local chat = _G["ChatFrame1"].border
				local editbox = _G["ChatFrame1EditBox"].border

				if (type == "CHANNEL") then
					local channelNumber = GetChannelName(EditBox:GetAttribute("channelTarget"))

					if (channelNumber == 0) then
						r, g, b = 0.5, 0.5, 0.5

						chat:SetBackdropBorderColor(r, g, b, 1)							-- (0.5, 0.5, 0.5)
						chat:SetBackdropColor(r, g, b)								-- (0.5, 0.5, 0.5)

						editbox:SetBackdropColor(r/3, g/3, b/3)							-- (0.5/3, 0.5/3, 0.5/3)

					else
						color = ChatTypeInfo[type .. channelNumber]
						r, g, b = color.r, color.g, color.b							-- r, g, b = ChatTypeInfo[type .. id].r, ChatTypeInfo[type .. id].g,  ChatTypeInfo[type .. id].b

						chat:SetBackdropBorderColor(r, g, b)							-- (ChatTypeInfo[type .. id].r, ChatTypeInfo[type .. id].g, ChatTypeInfo[type .. id].b)
						chat:SetBackdropColor(r/3, g/3, b/3)							-- (ChatTypeInfo[type .. id].r/3, ChatTypeInfo[type .. id].g/3, ChatTypeInfo[type .. id].b/3)

						editbox:SetBackdropColor(r/3, g/3, b/3)							-- (ChatTypeInfo[type .. id].r/3, ChatTypeInfo[type .. id].g/3, ChatTypeInfo[type .. id].b/3)

					end

				else

					color = ChatTypeInfo[type]
					r, g, b = color.r, color.g, color.b

					if (color.r == nil or color.g == nil or color.b == nil) then
						return
					else
						chat:SetBackdropBorderColor(r, g, b, 1)
						chat:SetBackdropColor(r/3, g/3, b/3)

						editbox:SetBackdropColor(r/3, g/3, b/3)
					end

				end


				chat:SetParent(ACTIVE_CHAT_EDIT_BOX)
				chat:SetFrameStrata(_G[frame]:GetFrameStrata())
				chat:SetFrameLevel(_G[frame]:GetFrameLevel() - 1)
				chat:Point("TOPLEFT", frame, 0, 0)
				chat:Point("BOTTOMRIGHT", frame, 0, 1)


				editbox:SetParent(ACTIVE_CHAT_EDIT_BOX)
				editbox:SetFrameLevel(_G[frame .. "EditBox"]:GetFrameLevel() - 1)
				editbox:Point("TOPLEFT", ACTIVE_CHAT_EDIT_BOX, -10, 10)
				editbox:Point("BOTTOMLEFT", ACTIVE_CHAT_EDIT_BOX, 10, -10)

			else
				chat:SetBackdropBorderColor(0, 0, 0, 0)
				chat:SetBackdropColor(0, 0, 0, 0)

				editbox:SetBackdropColor(0, 0, 0, 0)
			end

			for i = 1, ( CURRENT_CHAT_FRAME_ID ) do
				for i = 6, ( 8 ) do													-- ( C["Chat"]["Windows"] ) do
					_G["ChatFrame" .. i .. "EditBox"]:GetRegions():Hide()					-- print("ChatFrame".. i .. "EditBox", "REGIONS HIDDEN")
				end
			end

		end)

	end
end

--------------------------------------------------
--	Chat Style
--------------------------------------------------
local ChatStyle
do
	local CHAT_FRAME_TEXTURES = CHAT_FRAME_TEXTURES
	local ChatFrameMenuButton = ChatFrameMenuButton

	ChatStyle = function(frame)

		if (f.styled) then return end

		local name = frame:GetName()
		local f = _G[name]



		-- ChatFrame
		for _, texture in pairs(CHAT_FRAME_TEXTURES) do
			_G[name .. texture]:SetTexture(nil)
		end

		-- f:SetBackdrop({bgFile = Addon.default.backdrop.texture})						-- edgeFile = Addon.default.border.texture, edgeSize = X, insets = {left = -3, right = -3, top = -3, bottom = -3}})
		-- f:SetBackdropColor(unpack(Addon.default.backdrop.color))

		-- f:Backdrop()
		f:Border()
		f.border:SetFrameStrata(f:GetFrameStrata())
		f.border:SetFrameLevel(f:GetFrameLevel() - 1)
		f.border:SetBackdrop({bgFile = Addon.default.backdrop.texture})
		f.border:SetBackdropColor(0, 0, 0, 0)

		-- f.border:SetBackdrop({bgFile = Addon.default.backdrop.texture})						-- (Addon.template.backdrop)
		-- f.border:SetBackdropColor(0, 0, 0, 0)
		-- f.border:SetBackdropBorderColor(0, 0, 0, 0)
		-- f.border:EnableMouse(false)


		-- Editbox
		local e = _G[name .. "EditBox"]

		e:SkinEditBox()
		e:Point('BOTTOMLEFT', f, 'TOPLEFT', 0, 30)						-- ('TOPLEFT', f, 0, 30)
		e:Point('BOTTOMRIGHT', f, 'TOPRIGHT', 0, 30)						-- ('TOPRIGHT', f, 0, 30)

		local a, b, c = select(6, e:GetRegions()) a:Kill() b:Kill() c:Kill()


		e:Border()
		e.border:SetFrameStrata(f:GetFrameStrata())
		e.border:SetFrameLevel(f:GetFrameLevel() - 1)

		e.border:ClearAllPoints()
		e.border:SetPoint('TOPLEFT', -10, 10)
		e.border:SetPoint('BOTTOMRIGHT', 10, -10)

		e.border:SetBackdrop({bgFile = Addon.default.backdrop.texture})
		e.border:SetBackdropColor(0, 0, 0, 0)


		-- Color
		SetChatColorToChannelColor(name)


--[[		f.backdrop = CreateFrame('Frame', "$parent_Backdrop", f)
		f.backdrop:SetPoint('TOPLEFT', -3, 3)
		f.backdrop:SetPoint('BOTTOMRIGHT', 3, -3)
		f.backdrop:SetBackdrop({bgFile = Addon.default.backdrop.texture})
		f.backdrop:SetBackdropColor(unpack(Addon.default.backdrop.color))
		f.backdrop:SetFrameLevel(f:GetFrameLevel() - 10)

		f.border = CreateFrame('Frame', "$parent_Border", f)
		f.border:Point('TOPLEFT', f.backdrop, 'TOPLEFT', 1, -1)
		f.border:Point('BOTTOMRIGHT', f.backdrop, 'BOTTOMRIGHT', -1, 1)
		f.border:SetBackdrop({
			edgeFile = Addon.default.border.texture,
			edgeSize = 1,
			insets   = {left = 1, right = 1, top = 1, bottom = 1}})
		f.border:SetBackdropBorderColor(unpack(Addon.default.border.color))
--]]

		-- f.s = CreateFrame('Frame', "$parent_Border", f)
		-- f.s:SetFrameLevel(3)
		-- f.s:Point('TOPLEFT', f, Icon.border.insets, -Icon.border.insets)
		-- f.s:Point('BOTTOMRIGHT', f, -Icon.border.insets, Icon.border.insets)
		-- f.s:SetBackdrop({
			-- bgFile = Icon.border.bgFile,
			-- edgeFile = Icon.border.edgeFile,
			-- edgeSize = Icon.border.edgeSize,
			-- insets = {left = Icon.border.inset, right = Icon.border.inset, top = Icon.border.inset, bottom = Icon.border.inset}})
		-- f.s:SetBackdropColor(unpack(Icon.border.bgColor))
		-- f.s:SetBackdropBorderColor(unpack(Icon.border.edgeColor))



		-- EditBox
		-- local editbox = _G[name .. 'EditBox']
		-- editbox:ClearAllPoints()
		-- editbox:Point('BOTTOMLEFT', f, 'TOPLEFT', 0, 30)								-- ('TOPLEFT', f, 0, 30)
		-- editbox:Point('BOTTOMRIGHT', f, 'TOPRIGHT', 0, 30)								-- ('TOPRIGHT', f, 0, 30)
		-- editbox:SetTextInsets(10, 10, 10, 10)	-- (5, 5, 5, 5)						-- (left, right, top, bottom)
		-- editbox.SetTextInsets = Addon["Dummy"]
		-- editbox:SetBackdrop(nil)
		-- editbox:Template()					-- ("TRANSPARENT")


		-- ButtonFrame

		ChatFrameMenuButton:Kill()
	  -- _G[name .. 'ButtonFrame']:Kill()
		_G[name .. 'ButtonFrameUpButton']:Kill()
		_G[name .. 'ButtonFrameDownButton']:Kill()
	  -- _G[name .. 'ButtonFrameBottomButton']:Kill()
		_G[name .. 'ButtonFrameMinimizeButton']:Kill()

		-- ResizeButton
		_G[name .. 'ResizeButton']:ClearAllPoints()
		_G[name .. 'ResizeButton']:Point('BOTTOMRIGHT', f.backdrop, -1, 1)

		f.styled = true
	end
end

--------------------------------------------------
--	Events
--------------------------------------------------
do
	local ChatFrame1 = ChatFrame1
	local ChatFrame2 = ChatFrame2
	local ChatFrame3 = ChatFrame3
	local ChatFrame4 = ChatFrame4


	local e = CreateFrame('Frame')
	e:RegisterEvent('PLAYER_ENTERING_WORLD')							-- e:RegisterEvent('ADDON_LOADED')
	e:SetScript('OnEvent', function(self, event, addon)

		ResetChatSettings()
		SetupChatWindows()

		ChatStyle(ChatFrame1)
		ChatStyle(ChatFrame2)
		ChatStyle(ChatFrame3)
		ChatStyle(ChatFrame4)

		-- SetChatColorToChannelColor()

		-- Release
		self:UnregisterEvent(event)		-- self:UnregisterEvent('PLAYER_ENTERING_WORLD')

	end)
end


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

	for i = 1, (C["Chat"]numwindows) do
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

--[[ EditBox Backdrop

	editbox.backdrop = CreateFrame('Frame', '$parentBackdrop', editbox)
	editbox.backdrop:SetFrameLevel(editbox:GetFrameLevel() - 1)
	editbox.backdrop:SetPoint('TOPLEFT', 2 * X, -10)
	editbox.backdrop:SetPoint('BOTTOMRIGHT', -2 * X, 2 * X)
	editbox.backdrop:SetBackdrop({
		bgFile 	= default.backdrop.texture,
		edgeFile 	= default.border.texture,
		edgeSize 	= X,
		insets 	= {left = X, right = X, top = X, bottom = X}})
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

local CHAT_CHANNEL_ALIASES 		= C["Chat"]channel_aliases
local CHAT_CHANNEL_GLOBAL_ALIASES	= C["Chat"]channel_global_aliases

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
