local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Neon"]["Enable"]) then
	return
end

local select, unpack = select, unpack
local hooksecurefunc = hooksecurefunc
local match = string.match
local ChatTypeInfo = ChatTypeInfo
local ChatFrame1EditBox = ChatFrame1EditBox
local GetChannelName = GetChannelName


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




--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ NeonChat by Mikma
 ## Interface: 40300
 ## Title: NeonChat 3.2
 ## Notes: Colors the border of chat depending where you are planning to write. Never write nasty secrets to wrong chat again!
 ## Author: Mikma
 ## SavedVariables: NeonChatDB
--]]


