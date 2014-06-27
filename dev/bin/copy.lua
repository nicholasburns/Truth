local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Enable"] or not C["Dev"]["Copy"]["Enable"]) then
	return
end

local tconcat = table.concat
local tinsert = table.insert


local MARGIN, PAD = G.MARGIN, G.PAD



CT = {
	lines = {},
	str = nil,
}






-- Addon Frame

local F = CreateFrame('Frame', "CTF", UIParent, "DialogBoxFrame")
F:SetSize(500, 400)
F:Template("TRANSPARENT")
A.MakeMovable(F)
tinsert(UISpecialFrames, "CTF")

local Title = F:CreateFontString(nil, 'ARTWORK', "GameFontHighlight")
Title:SetPoint('TOPLEFT', PAD, -PAD)

local ScrollFrame = CreateFrame("ScrollFrame", "$parent_Scroll", F, 'UIPanelScrollFrameTemplate')
ScrollFrame:SetSize(455, 330)
ScrollFrame:SetPoint('TOPLEFT', MARGIN, -30)
ScrollFrame["ScrollBar"]:SkinScrollBar()

local EditBox = CreateFrame("EditBox", "$parent_EditBox", F)
EditBox:SetSize(450, 344)					-- EditBox:SetSize(ScrollFrame:GetWidth(), ScrollFrame:GetHeight())
-- EditBox:Template("CLASSCOLOR")
EditBox:SetMultiLine(true)
EditBox:SetMaxLetters(99999)
EditBox:EnableMouse(true)
EditBox:SetAutoFocus(true)
EditBox:SetFontObject('ChatFontNormal')
EditBox:SetFont(unpack(C["Chat"]["Copy"]["Font"]))
EditBox:SetTextColor(unpack(C["Chat"]["Copy"]["FontColor"]))
EditBox:SetScript("OnTextChanged", function(self) CT:OnTextChanged(self) end)
EditBox:SetScript("OnEscapePressed", function(self) CT:Hide() end)

ScrollFrame:SetScrollChild(EditBox)

local CloseButton = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
CloseButton:SkinCloseButton()

local ResizeButton = CreateFrame("Button", "$parent_ResizeButton", F)
ResizeButton:SkinResizeButton()



function CT:ScrapeMouseoverFrame()
	CT:ScrapeTopFrame(GetMouseFocus())
end


function CT:ScrapeGameTooltip()
	CT:ScrapeTopFrame(GameTooltip)
end


function CT:ScrapeTopFrame(f)
	if (f == nil) then
		return
	end -- local name = f:GetName() or ""

	CT.lines = {}

	self:ScrapeFrame(f)

	self.str = tconcat(self.lines, "\n")

	Title:SetText((f.GetName and f:GetName() or "") .. " Text")
	EditBox:SetText(self.str)

	F:Show()
end


function CT:ScrapeFrame(f)
	if (f == nil) then
		return
	end

	local lines = { f:GetRegions() }
	for i = #lines, (1), -1 do
		if (lines[i]:GetObjectType() == "FontString") then
			tinsert(self.lines, lines[i]:GetText())
		end
	end

	local children = {f:GetChildren()}
	for i = 1, (#children) do
		self:ScrapeFrame(children[i])
	end
end


function CT:OnTextChanged(self)
	if (self:GetText() ~= self.str) then
		self:SetText(self.str)
	end

	local ScrollBar = ScrollFrame
	self:GetParent():UpdateScrollChildRect()

	local minimum, maximum = ScrollBar:GetMinMaxValues()
	if (maximum > 0 and self.max ~= maximum) then
		self.max = maximum
		ScrollBar:SetValue(maximum)
	end
end


function CT:Hide()
	F:Hide()
end


--------------------------------------------------
function CT:ParseCmd(msg)
	local f = _G[msg]

	if (f and f.GetName) then
	   self:ScrapeTopFrame(f)
	else
		DEFAULT_CHAT_FRAME:AddMessage("Copy: Usage /ct <Frame>")
	end
end

SlashCmdList["TRUTH_COPYTEXT"] = function(msg)
	CT:ParseCmd(msg)
end

_G["SLASH_TRUTH_COPYTEXT1"] = "/ct"


