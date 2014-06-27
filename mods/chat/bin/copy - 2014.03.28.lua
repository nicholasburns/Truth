local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Copy"]["Enable"]) then return end

local concat, tinsert = table.concat, table.insert
local format, tostring = string.format, tostring
local select, unpack = select, unpack
local GetText = GetText
local InCombatLockdown = InCombatLockdown
local HideUIPanel, ShowUIPanel = HideUIPanel, ShowUIPanel
local UIParent, UISpecialFrames = UIParent, UISpecialFrames

-- Constant
local NUM_CHAT_FRAMES = C["Chat"]["Windows"]

local MARGIN = G.MARGIN
local PAD = G.PAD

local DEFAULT_FRAME_WIDTH = C["Chat"]["Copy"]["Width"]		-- or 450
local DEFAULT_FRAME_HEIGHT = C["Chat"]["Copy"]["Height"]	-- or 250
local DEFAULT_FRAME_POINT = C["Chat"]["Copy"]["Point"]



-- Private
local ChatFrames = A["ChatFrames"]
local F


local Lines = {}



function ChatFrames:CreateCopyFrame()
	F = CreateFrame('Frame', 'TruthCopyFrame', UIParent)
	F:Size(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT)
	F:Point(unpack(DEFAULT_FRAME_POINT))
	F:Template("TRANSPARENT")
	tinsert(UISpecialFrames, 'TruthCopyFrame')
	ToggleFrame(F)																			-- HideUIPanel(F)

	F["Title"] = F:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	F["Title"]:Point('TOPLEFT', MARGIN, -MARGIN)
	F["Title"]:Point('TOPRIGHT', -32, -MARGIN)


	F["Scroll"] = CreateFrame("ScrollFrame", "$parent_ScrollFrame", F, 'UIPanelScrollFrameTemplate')
	F["Scroll"]:Point('TOPLEFT', F, MARGIN, -30)
	F["Scroll"]:Point('BOTTOMRIGHT', F, -(ScrollBarWidth + MARGIN), MARGIN)
	-- F["Scroll"]:Point('BOTTOMRIGHT', F, -30, MARGIN)


  -- /d TruthCopyFrame_ScrollFrameScrollBar:GetSize() --> 16, 178
  -- /d TruthCopyFrame_ScrollFrameScrollBar:GetPoint() --> {'TOPLEFT', {}, 'TOPRIGHT', 6, -16}
	F["Scroll"]["ScrollBar"]:SkinScrollBar()
	local ScrollBarWidth = F["Scroll"]["ScrollBar"]:GetWidth()								-- F["Scroll"]["ScrollBar"]["Width"] = F["Scroll"]["ScrollBar"]:GetWidth()


  -- /d TruthCopyFrame_EditBox:GetSize() --> 450, 70
  -- /d TruthCopyFrame_EditBox:GetPoint() --> {'TOPLEFT', {}, 'TOPLEFT', 0, 0}
--[[
[1] = 'TOPLEFT',
[2] =  {
    ['ScrollBar'] =  { … }
    ['points'] = 2,
    ['offset'] = 0,
    [0] = <UserData 1>,
}
[3] = 'TOPLEFT',
[4] = -0,
[5] = 0,


/d TruthCopyFrame_EditBox:GetPoint()
     [1] = 'TOPLEFT',
     [2] = <Table 1: UIObject:ScrollFrame 'TruthCopyFrame_ScrollFrame'> {
	['ScrollBar'] = <Table 2: UIObject:Slider 'TruthCopyFrame_ScrollFrameScrollBar'> { … }
	['points'] = 2,
	['offset'] = 0,
	[0] = <UserData 1>,
     }
     [3] = 'TOPLEFT',
     [4] = -0,
     [5] = 0,


TruthCopyFrame_EditBox:GetPoint()
     [1] = 'TOPLEFT',
     [2] = <Table 1: UIObject:ScrollFrame 'TruthCopyFrame_ScrollFrame'> {
	     ['ScrollBar'] = <Table 2: UIObject:Slider 'TruthCopyFrame_ScrollFrameScrollBar'> { … }
	     ['points'] = 2,
	     ['offset'] = 0,
	     [0] = <UserData 1>,
}
     [3] = 'TOPLEFT',
     [4] = -0,
     [5] = 0,

     /d TruthCopyFrame_EditBox:GetPoint()
     [1] = 'TOPLEFT',
     [2] = <Table 1: UIObject:ScrollFrame 'TruthCopyFrame_ScrollFrame'> {
	     ['ScrollBar'] = <Table 2: UIObject:Slider 'TruthCopyFrame_ScrollFrameScrollBar'> { … }
	     ['points'] = 2,
	     ['offset'] = 0,
	     [0] = <UserData 1>,
     }
     [3] = 'TOPLEFT',
     [4] = -0,
     [5] = 0,

--]]

	F["Editbox"] = CreateFrame("EditBox", "$parent_EditBox", F)
	F["Editbox"]:SetMultiLine(true)
	F["Editbox"]:SetMaxLetters(0) 																-- (99999)
	F["Editbox"]:EnableMouse(true)
	F["Editbox"]:SetAutoFocus(false)
	F["Editbox"]:SetFontObject('GameFontHighlight')
	F["Editbox"]:Width(DEFAULT_FRAME_WIDTH - (ScrollBarWidth + MARGIN))
	F["Editbox"]:Height(DEFAULT_FRAME_HEIGHT)
	F["Editbox"]:Template("CLASSCOLOR")
	F["Editbox"]:SetScript("OnEscapePressed", F["Editbox"].ClearFocus) 									-- function() HideUIPanel(F) end)


	F["Scroll"]:SetScrollChild(F["Editbox"])


	F["Closer"] = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
	F["Closer"]:SkinCloseButton()
	F["Closer"]:Point("TOPRIGHT", -5, -5)


	F["Resizer"] = CreateFrame("Button", "$parent_ResizeButton", F)
	F["Resizer"]:SkinResizeButton()
end


function ChatFrames:GetLines(...)																-- local GetLines = function(...)
	local count = 1
	for i = select("#", ...), ( 1 ), -1 do
		local region = select(i, ...)
		if (region:GetObjectType() == "FontString") then
			Lines[count] = tostring(region:GetText())
			count = count + 1
		end
	end
	return count - 1
end


function ChatFrames:CopyText(ChatFrame)															-- local CopyText = function(ChatFrame)
	local LineCount = ChatFrames:GetLines(ChatFrame:GetRegions())
	local Text = concat(Lines, "\n", 1, LineCount)

	ToggleFrame(F)																			-- if (F:IsVisible()) then return HideUIPanel(F) end ShowUIPanel(F)

	F["Title"]:SetFont(A.media.font.continuum, 18, "OUTLINE")
	F["Title"]:SetFont(C["Chat"]["Font"][1], 18, "OUTLINE")
	F["Title"]:SetFontObject('ChatFontNormal')
	F["Title"]:SetJustifyH("LEFT")
	F["Title"]:SetText(ChatFrame:GetName())

	F["Editbox"]:SetFont(unpack(C["Chat"]["Copy"]["Font"]))
	F["Editbox"]:SetText(Text)
end


function ChatFrames:CreateCopyButtons()
	for i = 1, (NUM_CHAT_FRAMES) do
		local ChatFrame = _G[format("ChatFrame%d", i)]

		local Button = CreateFrame("Button", "$parent_CopyButton", ChatFrame)
		Button:Size(24)
		Button:Point('TOPRIGHT', -5, -5)

		Button:SetNormalTexture(C["Chat"]["Copy"]["ButtonNormal"])
		Button:GetNormalTexture():Size(20)
		Button:SetHighlightTexture(C["Chat"]["Copy"]["ButtonHighlight"])
		Button:GetHighlightTexture():SetAllPoints(Button:GetNormalTexture())

		Button:Show()

		Button:SetScript("OnMouseUp", function(self)
			if (InCombatLockdown()) then
				return
			end

			ChatFrames:CopyText(self.ChatFrame)
		end)

		Button.ChatFrame = ChatFrame
	end
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local DEFAULT_FRAME_WIDTH = 450
	local DEFAULT_FRAME_HEIGHT = 250
	local DEFAULT_FRAME_POINT = {'BOTTOM', ChatFrame1EditBox, 'TOP', 0, MARGIN}
--]]

--[[ Backdrop & Border

	F:SetBackdrop({
		bgFile   = A.default.backdrop.texture,
		edgeFile = A.default.border.texture,
		edgeSize = 1,
		insets   = {left = 1, right = -1, top = -1, bottom = -1}})
	F:SetBackdropColor(unpack(A.default.backdrop.color))
	F:SetBackdropBorderColor(unpack(A.default.border.color))
--]]

--[[ Create F Frame

local CreateCopyFrame = function()

	-- Main Window
	local F = CreateFrame('Frame', "TruthCopyFrame", UIParent)
	F:Template("DEFAULT")
	F:Height(700)
	F:Point("BOTTOMLEFT", ChatFrame1EditBox, "TOPLEFT", 3, 10)
	F:Point("BOTTOMRIGHT", ChatFrame1EditBox, "TOPRIGHT", -3, 10)
	F:SetFrameStrata("DIALOG")
	F:Hide()
	tinsert(UISpecialFrames, F)

	-- Scroll Frame
	local F["Scroll"] = CreateFrame("F["Scroll"]", "$parent_ScrollFrame", F, "UIPanelScrollFrameTemplate")
	F["Scroll"]:Point("TOPLEFT", F, 8, -30)
	F["Scroll"]:Point("BOTTOMRIGHT", F, -30, 8)

	-- Scroll F["Editbox"]
	F["Editbox"] = CreateFrame("EditBox", "$parent_EditBox", F)
	F["Editbox"]:SetMultiLine(true)
	F["Editbox"]:SetMaxLetters(99999)
	F["Editbox"]:EnableMouse(true)
	F["Editbox"]:SetAutoFocus(false)
	F["Editbox"]:SetFontObject(ChatFontNormal)
	F["Editbox"]:Size(450, 270)
	F["Editbox"]:SetScript("OnEscapePressed", function() F:Hide() end)

	-- Scroll Child
	F["Scroll"]:SetScrollChild(F["Editbox"])

	-- Close Button
	local close = CreateFrame("Button", "$parent_CloseButton", F, "UIPanelCloseButton")
	close:SkinCloseButton()
	close:SetPoint("TOPRIGHT", F, 4, 0)

	-- Remember
	isCopyFrameCreated = true
end
--]]

