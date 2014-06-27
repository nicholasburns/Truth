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
local MARGIN = G.MARGIN
local PAD = G.PAD

local DEFAULT_FRAME_WIDTH = 450
local DEFAULT_FRAME_HEIGHT = 250
local DEFAULT_FRAME_POINT = {'BOTTOMLEFT', ChatFrame1EditBox, 0, MARGIN}
-- local DEFAULT_FRAME_WIDTH = C["Chat"]["Copy"]["Width"]
-- local DEFAULT_FRAME_HEIGHT = C["Chat"]["Copy"]["Height"]
-- local DEFAULT_FRAME_POINT = C["Chat"]["Copy"]["Point"]

local NUM_CHAT_FRAMES = C["Chat"]["Windows"]


-- Private
local ChatFrames = A["ChatFrames"]
local F
local Lines = {}


function ChatFrames:CreateCopyFrame()
	F = CreateFrame('Frame', "TruthCopyFrame", UIParent)
	F:Size(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT)
	F:Point(unpack(DEFAULT_FRAME_POINT))											-- F:Point(unpack(C["Chat"]["Copy"]["Point2"]))
	F:Template("TRANSPARENT")

	HideUIPanel(F)
	tinsert(UISpecialFrames, "TruthCopyFrame")

	local title = F:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	title:Point('TOPLEFT', MARGIN, -MARGIN)
	title:Point('TOPRIGHT', -32, -MARGIN)
	F.title = title

	local ScrollFrame = CreateFrame("ScrollFrame", "$parent_ScrollFrame", F, 'UIPanelScrollFrameTemplate')
	ScrollFrame:Point('TOPLEFT', F, MARGIN, -30)
	ScrollFrame:Point('BOTTOMRIGHT', F, -30, MARGIN)

  -- /d TruthCopyFrame_ScrollFrameScrollBar:GetSize() --> 16, 178
	ScrollFrame.ScrollBar:SkinScrollBar()

	local Editbox = CreateFrame("EditBox", "$parent_EditBox", F)
	Editbox:SetMultiLine(true)
	Editbox:SetMaxLetters(0) 																-- (99999)
	Editbox:EnableMouse(true)
	Editbox:SetAutoFocus(false)
	Editbox:SetFontObject('GameFontHighlight')

  -- /d TruthCopyFrame_EditBox:GetSize() --> 450, 70
	Editbox:Size(DEFAULT_FRAME_WIDTH - 30, DEFAULT_FRAME_HEIGHT)
	Editbox:Template("CLASSCOLOR")
	-- Editbox:SetScript("OnEscapePressed", function() HideUIPanel(F) end)
	Editbox:SetScript("OnEscapePressed", Editbox.ClearFocus)
	F.Editbox = Editbox

	ScrollFrame:SetScrollChild(Editbox)

	local CloseButton = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
	CloseButton:SkinCloseButton()
	CloseButton:Point("TOPRIGHT", -5, -5)
	F.CloseButton = CloseButton

	local ResizeButton = CreateFrame("Button", "$parent_ResizeButton", F)
	ResizeButton:SkinResizeButton()

end


function ChatFrames:GetLines(...)														-- local GetLines = function(...)
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


function ChatFrames:CopyText(ChatFrame)													-- local CopyText = function(ChatFrame)
	local LineCount = ChatFrames:GetLines(ChatFrame:GetRegions())
	local Text = concat(Lines, "\n", 1, LineCount)

	if (F:IsVisible()) then
		return HideUIPanel(F)
	end

	ShowUIPanel(F)

	-- F.title:SetFont(A.media.font.continuum, 18, "OUTLINE")									-- F.title:SetFont(C["Chat"]["Font"][1], 18, "OUTLINE")
	-- F.title:SetJustifyH("LEFT")
	-- F.title:SetFontObject('ChatFontNormal')
	F.title:SetText(ChatFrame:GetName())

   -- F.Editbox:SetFont(unpack(C["Chat"]["Copy"]["Font"]))
	F.Editbox:SetText(Text)
end


function ChatFrames:CreateCopyButtons()
	for i = 1, (NUM_CHAT_FRAMES) do
		local ChatFrame = _G['ChatFrame' .. i]

		local Button = CreateFrame("Button", "$parent_CopyButton", ChatFrame)							-- local Button = CreateFrame("Button", nil, f)
		Button:Size(24)
		Button:Point("TOPRIGHT", -5, -5)
		Button:SetNormalTexture(C["Chat"]["Copy"]["ButtonNormal"])
		Button:GetNormalTexture():Size(20)
		Button:SetHighlightTexture(C["Chat"]["Copy"]["ButtonHighlight"])
		Button:GetHighlightTexture():SetAllPoints(Button:GetNormalTexture())
		Button:Show()
		Button:SetScript("OnMouseUp", function(self)
			if (InCombatLockdown()) then return end
			ChatFrames:CopyText(self.ChatFrame)				-- ChatFrames:CopyText(self.ChatFrame)
		end)

		Button.ChatFrame = ChatFrame
	end
end


--------------------------------------------------
--	Backup
--------------------------------------------------
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
	local ScrollFrame = CreateFrame("ScrollFrame", "$parent_ScrollFrame", F, "UIPanelScrollFrameTemplate")
	ScrollFrame:Point("TOPLEFT", F, 8, -30)
	ScrollFrame:Point("BOTTOMRIGHT", F, -30, 8)

	-- Scroll Editbox
	Editbox = CreateFrame("EditBox", "$parent_EditBox", F)
	Editbox:SetMultiLine(true)
	Editbox:SetMaxLetters(99999)
	Editbox:EnableMouse(true)
	Editbox:SetAutoFocus(false)
	Editbox:SetFontObject(ChatFontNormal)
	Editbox:Size(450, 270)
	Editbox:SetScript("OnEscapePressed", function() F:Hide() end)

	-- Scroll Child
	ScrollFrame:SetScrollChild(Editbox)

	-- Close Button
	local close = CreateFrame("Button", "$parent_CloseButton", F, "UIPanelCloseButton")
	close:SkinCloseButton()
	close:SetPoint("TOPRIGHT", F, 4, 0)

	-- Remember
	isCopyFrameCreated = true
end
--]]

