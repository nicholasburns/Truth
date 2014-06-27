local A, C, G, L = select(2, ...):Unpack()

local M = C["Chat"]["Copy"]

if (not C["Chat"]["Enable"] or not C["Chat"]["Copy"]["Enable"]) then
	return
end


-- Constant
local MARGIN = G.MARGIN
local PAD    = G.PAD


-- Datatable
local Lines = {}


-- CopyFrame
local F = CreateFrame('Frame', "TCF", UIParent)
table.insert(UISpecialFrames, "TCF")
F:SetWidth(M["Width"])
F:SetHeight(M["Height"])
F:SetPoint(unpack(M["Point"]))
F:SetFrameStrata("DIALOG")
F:Template("TRANSPARENT")
A.MakeMovable(F)
F:Hide()

local Title = F:CreateFontString(nil, 'OVERLAY', "GameFontNormal")
Title:SetHeight(15)
Title:SetPoint('BOTTOMLEFT', F, 'TOPLEFT', MARGIN, MARGIN)
Title:SetPoint('BOTTOMRIGHT', F, 'TOPRIGHT', -MARGIN, MARGIN)
Title:SetJustifyH("LEFT")
Title:SetJustifyV("BOTTOM")
F.Title = Title

local ScrollFrame = CreateFrame("ScrollFrame", "$parent_Scroll", F, 'UIPanelScrollFrameTemplate')
ScrollFrame:SetPoint('TOPLEFT', MARGIN, -MARGIN)
ScrollFrame:SetPoint('BOTTOMRIGHT', -(ScrollFrame["ScrollBar"]:GetWidth() + MARGIN + PAD), MARGIN)	-- ScrollFrame:SetScript("OnMouseWheel", function(self, delta) ScrollFrameTemplate_OnMouseWheel(self, delta, self.ScrollBar) end)

ScrollFrame["ScrollBar"]:SkinScrollBar()												-- ScrollFrame["ScrollBar"]:SetScript("OnMouseWheel", function(self, delta) ScrollFrameTemplate_OnMouseWheel(self, delta, self) end)

local EditBox = CreateFrame("EditBox", "$parent_EditBox", F)
EditBox:SetWidth(500)
EditBox:SetHeight(1000)
EditBox:Template("CLASSCOLOR")
EditBox:SetMultiLine(true)
EditBox:SetMaxLetters(0)
EditBox:EnableMouse(true)
EditBox:SetAutoFocus(false)
EditBox:SetFontObject("ChatFontNormal")
EditBox:SetFont(unpack(M["Font"]))
EditBox:SetScript("OnEscapePressed", EditBox.ClearFocus)
F.EditBox = EditBox

ScrollFrame:SetScrollChild(F.EditBox)

local CloseButton = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
CloseButton:SkinCloseButton()
CloseButton:ClearAllPoints()
CloseButton:SetPoint('BOTTOMRIGHT', F, 'TOPRIGHT', 0, PAD)

local ResizeButton = CreateFrame("Button", "$parent_ResizeButton", F)
ResizeButton:SkinResizeButton()


do
	local concat, select, unpack = table.concat, select, unpack
	local format, gsub, tostring = string.format, string.gsub, tostring
	local OnMouseDown, OnMouseUp, GetLines, CreateCopyButton


	GetLines = function(...)
		local i = 1

		for j = select('#', ...), 1, -1 do

			local region = select(j, ...)

			if (region:GetObjectType() == "FontString") then

				Lines[ i ] = tostring(region:GetText())

				i = i + 1

			end

		end

		return i - 1
	end


	OnMouseDown = function(self)
		self:GetNormalTexture():ClearAllPoints()
		self:GetNormalTexture():SetPoint('CENTER', 1, -1)
	end

	OnMouseUp = function(self)
		if (InCombatLockdown()) then
			return
		end
		self:GetNormalTexture():ClearAllPoints()
		self:GetNormalTexture():SetPoint('CENTER')
		if (F:IsShown()) then
			F:Hide()
			F:Show()
		else
			F:Show()
		end

		local numlines = GetLines(self:GetParent():GetRegions()) or 0
		local copytext = concat(Lines, "\n", 1, numlines)

		F.Title:SetText(self:GetParent():GetName())

		F.EditBox:SetText(copytext)
		F.EditBox:SetCursorPosition(0)

	--	F.EditBox:HighlightText(0)			-- Code for a Highlight Button
	--	F.EditBox:SetFocus()
	end

	CreateCopyButton = function(ChatFrame)
		local B = CreateFrame("Button", "$parent_CopyButton", ChatFrame)
		B:SetSize(20, 20)
		B:SetPoint('TOPRIGHT', -PAD, -PAD)

		B:SetNormalTexture(M["ButtonNormal"])
		B:GetNormalTexture():SetSize(20, 20)

		B:SetHighlightTexture(M["ButtonHighlight"])
		B:GetHighlightTexture():SetAllPoints(B:GetNormalTexture())

		B:SetScript("OnMouseDown", OnMouseDown)
		B:SetScript("OnMouseUp", OnMouseUp)

		ChatFrame.B = B
	end
end


for i = 1, (G.NUM_CHAT_FRAMES) do
	local ChatFrame = _G[("ChatFrame%d"):format(i)]
	CreateCopyButton(ChatFrame)
end

hooksecurefunc("FCF_OpenTemporaryWindow", function(chatType, chatTarget, sourceChatFrame, selectWindow)
	local ChatFrame = FCF_GetCurrentChatFrame()
	CreateCopyButton(ChatFrame)
end)


-- hooksecurefunc("FCF_OpenTemporaryWindow", CreateCopyButton)



--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ [DOCUMENTATION]  Bnet Message Formatting

	|K[gsf][0-9]+|k[0]+|k

	Represents a Battle.net friends name

	The 3rd character indicates given name, surname or fullname
	The number which follows it represents the Bnet Presence ID of friend
	The zeros between the |k form a string of the same length as the name which will replace it

	Example:

	If ( Your first name is John and your PresenceID is 30 ) then
		Your name (John) = represented by string:  |Kg30|k0000|k
	End
--]]

--[[ Bnet Code Block

	for i = 1, (NUM_CHAT_FRAMES) do														-- credit: AsphyxiaUI [#CopyChatFrame]
		local Editbox = _G[("ChatFrame%dEditBox"):format(i)]
		Editbox:HookScript("OnTextChanged", function(self)
			local text = self:GetText()
			local new, found = (text):gsub("|Kf(%S+)|k(%S+)%s(%S+)k:%s",  "%2 %3: ")
			if (found > 0) then
				new = (new):gsub("|", "")
				self:SetText(new)
			end
		end)
	end
--]]

--[[ OnMouseUp Revert

	OnMouseUp = function(self)
		if (F:IsShown()) then F:Hide() return else F:Show() end

		local NumLines = GetLines(self:GetParent():GetRegions()) or 0
		local text = concat(Lines, "\n", 1, NumLines)

		F.Title:SetText(self:GetParent():GetName())
		F.EditBox:SetText(text)
	end

--]]

